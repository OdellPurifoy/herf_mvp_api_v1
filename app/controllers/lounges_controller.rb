# frozen_string_literal: true

class LoungesController < ApplicationController
  before_action :authenticate_lounge_owner!, only: %i[new create edit update destroy]

  def index
    @lounges = Lounge.all
    render json: { data: LoungeSerializer.new(@lounges).serializable_hash[:data].map do |lounge|
      lounge[:attributes]
    end }, status: :ok
  end

  def show
    @lounge = Lounge.find(params[:id])
    if @lounge
      render json: { data: LoungeSerializer.new(@lounge).serializable_hash[:data][:attributes] }, status: :ok
    else
      render json: { errors: 'Lounge not found' }, status: :not_found
    end
  end

  def new
    @lounge = Lounge.new
  end

  def create
    @lounge = current_lounge_owner.lounges.build(lounge_params)
    if @lounge.save
      render json: { data: LoungeSerializer.new(@lounge).serializable_hash[:data][:attributes] }, status: :created
    else
      render json: { errors: @lounge.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @lounge = Lounge.find(params[:id])
  end

  def update
    @lounge = Lounge.find(params[:id])
    if @lounge.update(lounge_params)
      render json: { data: LoungeSerializer.new(@lounge).serializable_hash[:data][:attributes] }, status: :ok
    else
      render json: { errors: @lounge.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @lounge = Lounge.find(params[:id])
    @lounge.destroy
    render json: { data: 'Lounge deleted' }, status: :ok
  end

  private

  def lounge_params
    params.require(:lounge).permit(:name, :email, :phone_number, :address_street_1, :address_street_2, :city, :state,
                                   :zip_code, :description, :outside_cigars_allowed, :outside_drinks_allowed, :drinks_served, :outside_food_allowed, :food_served, :lounge_owner_id)
  end
end
