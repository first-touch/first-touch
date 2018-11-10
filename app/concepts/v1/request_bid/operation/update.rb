module V1
  module RequestBid
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBid::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_model!(options, params:,  **)
        options['model.class'] = ::RequestBid
        options[:model] = options[:current_user].request_bids.find(params[:id])
      end
    end
  end
end
