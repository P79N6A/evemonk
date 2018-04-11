# frozen_string_literal: true

module Api
  class SignInsController < BaseController
    skip_before_action :authenticate!

    def create
      sign_in = Api::SignIn.new(sign_in_params)

      sign_in.save!

      render json: SessionDecorator.new(sign_in.session,
                                        context: { with_token: true })
    end

    private

    def sign_in_params
      params.require(:sign_in).permit(:email, :password, :name, :device_type,
                                      :device_token)
    end
  end
end
