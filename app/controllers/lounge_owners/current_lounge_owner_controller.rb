class LoungeOwners::CurrentLoungeOwnerController < ApplicationController
  before_action :authenticate_lounge_owner!

  def show
    render json: LoungeOwnerSerializer.new(current_lounge_owner).serializable_hash[:data][:attributes]
  end
end