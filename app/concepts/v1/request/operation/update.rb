module V1
  module Request
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Request::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_model!(options, params:, current_user:, **)
        # @Todo CLUB not current_user
        model = current_user.requests.find_by(id: params[:id])
        options['model'] = model
        options['model.class'] = ::Request
        if model.nil?
          false
        else
          if !params[:status].blank?
            model.status = params[:status]
          end
            true

        end

      end

    end
  end
end
