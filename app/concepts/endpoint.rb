module FirstTouch
  class Endpoint
    DEFAULT_MATCHERS = {
      created: {
        rule: ->(result) { result.success? && result['model.action'] == :new },
        resolve: lambda do |result, representer|
          { 'data': representer.new(result['model']),
            'status': :created }
        end
      },
      deleted: {
        rule: ->(result) { result.success? && result['model.action'] == :destroy },
        resolve: lambda do |result, _representer|
          { 'data': { id: result['model'].id },
            'status': :ok }
        end
      },
      success_list: {
        rule: ->(result) { result.success? && !result['models'].nil? },
        resolve: lambda do |result, representer|
          { 'data': representer.new(result['models']), 'status': :ok }
        end
      },
      success: {
        rule: ->(result) { result.success? && !result['model'].nil? },
        resolve: lambda do |result, representer|
          { 'data': representer.new(result['model']), 'status': :ok }
        end
      },
      unauthenticated: {
        rule: ->(result) { result.unauthenticated? },
        resolve: lambda do |result, _representer|
          { 'data': { errors: result.errors }, 'status': :unauthorized }
        end
      },
      unauthorized: {
        rule: ->(result) { result.unauthorized? },
        resolve: ->(_result, _representer) { { 'data': {}, 'status': :forbidden } }
      },
      not_found: {
        rule: ->(result) { result.failure? && result['result.model']&.failure? },
        resolve: lambda do |result, _representer|
          { 'data': { errors: result['result.model.errors'] },
            'status': :unprocessable_entity }
        end
      },
      invalid: {
        rule: ->(result) { result.failure? },
        resolve: lambda do |result, _representer|
          { 'data': { errors: result.errors }, 'status': :unprocessable_entity }
        end
      },
      fallback: {
        rule: ->(_result) { true },
        resolve: lambda do |_result, _representer|
          { 'data': { errors: "Can't process the result" },
            'status': :unprocessable_entity }
        end
      }
    }.freeze

    # NOTE: options expects a TRB Operation result
    # it might have a representer, else will assume the default name
    def self.call(operation_result, representer_class = nil, overrides = {})
      endpoint_opts = { result: operation_result, representer: representer_class }
      new.(endpoint_opts, overrides)
    end

    def call(options, overrides)
      overrides.each do |rule_key, rule_description|
        rule = rule_description[:rule] || DEFAULT_MATCHERS[rule_key][:rule]
        resolve = rule_description[:resolve] || DEFAULT_MATCHERS[rule_key][:resolve]
        if rule.nil? || resolve.nil?
          puts "Matcher is not properly set. #{rule_key} will be ignored"
          next
        end

        return resolve.(options[:result], options[:representer]) if rule.(options[:result])
      end
      matching_rules(overrides).each_value do |rule_description|
        if rule_description[:rule].(options[:result])
          return rule_description[:resolve].(options[:result], options[:representer])
        end
      end
    end

    def matching_rules(overrides)
      DEFAULT_MATCHERS.except(*overrides.keys)
    end
  end
end
