require 'dry-matcher'

module FirstTouch
  # This class assumes that the project is api only and its rendering
  # JSON. For other options (e.g render a view) this needs to be thought
  class Endpoint
    Matcher = Dry::Matcher.new(
      success: Dry::Matcher::Case.new(
        match: ->(result:, **) { result.success? },
        resolve: ->(result:, representer:, **) do
          {
            'data': representer.new(result['models']),
            'status': :ok
          }
        end
      ),
      created: Dry::Matcher::Case.new(
        match: ->(result:, **) do
          result.success? && result['model.action'] == :new
        end,
        resolve: ->(result:, representer:, **) do
          {
            'data': representer.new(result['model']),
            'status': :created
          }
        end
      ),
      unauthenticated: Dry::Matcher::Case.new(
        match: ->(result:, **) { result.policy_error? },
        resolve: ->(_result:, **) do
          {
            'data': { errors: ['unauthorized'] },
            'status': :unauthorized
          }
        end
      ),
      not_found: Dry::Matcher::Case.new(
        match: ->(result:, **) do
          result.failure? && result['result.model']&.failure?
        end,
        resolve: ->(result:, **) do
          {
            'data': { errors: result['result.model.errors'] },
            'status': :unprocessable_entity
          }
        end
      ),
      invalid: Dry::Matcher::Case.new(
        match: ->(result:, **) do
          result.failure? && result['result.contract.default']&.failure?
        end,
        resolve: ->(result:, **) do
          {
            'data': { errors: result['contract.default']&.errors&.full_messages },
            'status': :unprocessable_entity
          }
        end
      )
    )

    # options expects a TRB Operation result
    # it might have a representer, else will assume the default name
    def self.call(operation_class, options = {})
      result = operation_class.(*options[:args])
      endpoint_opts = { result: result, representer: options[:representer] }
      new.(endpoint_opts)
    end

    def call(options)
      matcher.(options) do |m|
        m.created { |v| v }
        m.success { |v| v }
        m.not_found { |v| v }
        m.unauthenticated { |v| v }
        m.invalid { |v| v }
      end
    end

    def matcher
      Matcher
    end
  end
end
