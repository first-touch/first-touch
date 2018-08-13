module V1
  module CareerEntry
    class Create < FirstTouch::Operation
      step Model(::CareerEntry, :new)
      step :setup_club!
      step :setup_user!
      step Trailblazer::Operation::Contract::Build(
        constant: CareerEntry::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :career_entry)
      step Trailblazer::Operation::Contract::Persist()

      def setup_club!(model:, params:, **)
        club_id = params[:career_entry][:club_id]
        return true unless club_id
        model.club = ::Club.find_by id: club_id
      end

      def setup_user!(model:, current_user:, **)
        model.user = current_user
        true
      end
    end
  end
end
