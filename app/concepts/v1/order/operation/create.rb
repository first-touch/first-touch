module V1
  module Order
    class Create < Trailblazer::Operation
      step Model(::Order, :new)
      step Trailblazer::Operation::Contract::Build( constant: Order::Contract::Create )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :setup_model!

      def setup_model!(model:, params:, current_user:, **)
        model.customer_id = current_user.id
      end

    end
  end
end