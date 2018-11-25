module V1
  module Club
    class Index < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        clubs = ::Club.all
        clubs = clubs.where('name iLIKE ?', "%#{params[:q]}%") if params[:q]
        clubs = clubs.where(country_code: params[:country]) if params[:country]
        options[:models] = clubs.order(:name)
      end
    end
  end
end
