# frozen_string_literal: true

module LoungeOwners
  class SessionsController < Devise::SessionsController
    include RackSessionFix
    respond_to :json

    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
    #
    private

    def respond_with(resource, _opts = {})
      render json: {
        message: 'Logged in successfully',
        status: :ok,
        data: LoungeOwnerSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    end

    def respond_to_on_destroy
      if current_lounge_owner
        render json: {
          message: 'Logged out successfully',
          status: :unprocessable_content
        }
      else
        render json: {
          message: 'No active session'
        }, status: :unprocessable_entity
      end
    end
  end
end
