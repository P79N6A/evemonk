# frozen_string_literal: true

module Api
  class SignInsController < BaseController
    skip_before_action :authenticate

    def create
      @form = SignInForm.new(sign_in_params)

      # skip_authorization

      if @form.save
        render :create
      else
        render :errors, status: :unprocessable_entity
      end
    end

    # def create
    #   sign_in = SignIn.new(sign_in_params)

    #   if sign_in.save
    #     render json: SessionDecorator.new(sign_in.session,
    #                                       context: { with_token: true })
    #   else
    #     render json: { errors: sign_in.errors }, status: :unprocessable_entity
    #   end
    # end

    private

    def sign_in_params
      params.require(:sign_in).permit(:email, :password, :name, :device_type,
                                      :device_token)
    end
  end
end
