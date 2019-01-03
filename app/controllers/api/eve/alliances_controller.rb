# frozen_string_literal: true

module Api
  module Eve
    class AlliancesController < BaseController
      skip_before_action :authenticate

      def index
        skip_policy_scope

        @alliances = ::Eve::Alliance.includes(:faction, :creator_corporation, :creator, :executor_corporation)
                                    .page(params[:page])
      end

      def show
        skip_authorization

        @alliance = ::Eve::Alliance.find_by!(alliance_id: params[:id])
      end
    end
  end
end
