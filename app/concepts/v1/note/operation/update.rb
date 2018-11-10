module V1
  module Note
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Note::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :note)
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_model!(options, params:,  **)
        options[:model] = model = options[:current_user].notes.find_by(id: params[:id])
        options['model.class'] = ::Note
        options['result.model'] = result = Result.new(!model.nil?, {})
        result.success?
      end
    end
  end
end
