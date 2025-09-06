class PetInfosController < ApplicationController
  before_action :require_login
  before_action :set_pet
  before_action :ensure_pet_access
  before_action :set_pet_info, only: [:edit, :update, :destroy]

  def index
    @pet_infos = @pet.pet_infos.order(:name, :value)
  end

  def new
    @pet_info = @pet.pet_infos.build
  end

  def create
    @pet_info = @pet.pet_infos.build(pet_info_params)
    @pet_info.created_by = current_user
    
    if @pet_info.save
      flash[:notice] = "Contact information was successfully added!"
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @pet_info.update(pet_info_params)
      flash[:notice] = "Contact information was successfully updated!"
      redirect_to pet_path(@pet)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet_info.destroy
    flash[:notice] = "Contact information was successfully deleted!"
    redirect_to pet_path(@pet)
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_pet_info
    @pet_info = @pet.pet_infos.find(params[:id])
  end

  def ensure_pet_access
    unless @pet.accessible_by?(current_user)
      flash[:error] = "You don't have access to this pet"
      redirect_to pets_path
    end
  end

  def pet_info_params
    params.require(:pet_info).permit(:name, :value, channels: [])
  end
end
