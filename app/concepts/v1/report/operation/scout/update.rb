module V1
  module Report
    module Operation
      module Scout
        class Update < FirstTouch::Operation
          step Model(::Report, :find_by)
          failure :model_not_found!, fail_fast: true
          step Trailblazer::Operation::Contract::Build(
            constant: Report::Contract::Update
          )
          step Trailblazer::Operation::Contract::Validate()
          step Trailblazer::Operation::Contract::Persist()
        end
      end
    end
  end
end
