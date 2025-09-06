class PetsController < ApplicationController
  before_action :require_login
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = current_user.all_pets
  end

  def show
  end

  def new
    @pet = current_user.pets.build
  end

  def create
    @pet = current_user.pets.build(pet_params)
    
    if @pet.save
      flash[:notice] = "Pet '#{@pet.name}' was successfully created!"
      redirect_to @pet
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      flash[:notice] = "Pet '#{@pet.name}' was successfully updated!"
      redirect_to @pet
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    pet_name = @pet.name
    @pet.destroy
    flash[:notice] = "Pet '#{pet_name}' was successfully deleted!"
    redirect_to pets_path
  end

  private

  def set_pet
    @pet = current_user.all_pets.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed)
  end
end
