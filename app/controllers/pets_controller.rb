class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
    layout "form", only: [:new, :edit]

  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.includes(:species)
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
    if @pet.user != current_user
      redirect_to action: "show"
    end
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    @pet.gender = params[:gender]

    uploaded_file = params[:pet][:dp_url].path
    cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    @pet.dp_url = cloudinary_file['url']

    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    if params[:pet][:dp_url]
      uploaded_file = params[:pet][:dp_url].path
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    end
    respond_to do |format|

      if @pet.update(pet_params)
        if uploaded_file
          @pet.dp_url = cloudinary_file['url']
        end
        @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :dp_url, :species_id, :birthday, :bio, :gender)
    end
end
