class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
      layout "form", only: [:edit_profile]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:profile)
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @pets = current_user.pets
      @hosting = current_user.events
      @attending = current_user.events_attending
    else
      redirect_to root_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def edit_profile
    @profile = Profile.find(current_user.profile.id)
  end

  def save_profile
    @profile = Profile.find(current_user.profile.id)
    @user = User.find(current_user.id)
    uploaded_file = params[:profile][:dp_url].path
    cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    @profile.update(profile_params)
    url = cloudinary_file['url']
    @profile[:dp_url] = url
    if @profile.save
      redirect_to @user
    else
      render 'edit_profile'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def profile_params
      params.require(:profile).permit(:name, :dp_url, :birthday, :bio, :gender)
  end

end
