module Api
  class SessionsController < BaseController
    skip_before_action :authenticate, only: :create

    def create
      build_resource

      resource.save!

      skip_authorization
    end

    def destroy
      authorize(session)

      session.destroy!

      head :ok
    end

    private

    def build_resource
      @session = Api::Session.new(resource_params)
    end

    def resource
      @session
    end

    def resource_params
      params.require(:session)
            .permit(:email, :password, :name, :device, :device_token)
    end

    def collection
      # TODO: refactor to remove "::" before Session
      @sessions ||= policy_scope(::Session).order(created_at: :asc)
                                           .page(params[:page])
    end
  end
end
