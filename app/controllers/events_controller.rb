# require 'time'
# require "active_support/all"
require "net/http"

class EventsController < ApplicationController

  layout "form", only: [:new, :edit]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    if params[:filter]
      @events = Event.where("type_id = ?", params[:filter]["type_id"].to_i).includes(:user, :pets)
      if params[:sort] == "recent"
        @events = @events.order(id: :desc)
      else
        @events = @events.order(id: :asc)
      end
    else
      @events = Event.all.includes(:user, :pets)
    end
  end

  def homepage
    @events_today = Event.today.includes(:user, :pets)
    @events_upcoming = Event.upcoming.includes(:user, :pets)
    @events_recent = Event.recent.includes(:user, :pets)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end


  def rsvp
    @event = Event.find(params[:id])
    @pet_ids = event_params[:pet_ids].reject!(&:blank?)

    #Get unselected pets.
    unselected_pets = current_user.pets.select{ | pet | !@pet_ids.include?(pet.id.to_s)}

    # For each pet unselected, uninvite them if already rsvped.
    unselected_pets.each do |pet|
      @event.pets.delete(pet)
    end

    # For each pet selected, add them to event if not already rsvped.
    @pet_ids.each do |id|
      pet = Pet.find(id)
      if !pet.is_rsvped(@event)
        @event.pets << pet

        #Send email to event host to notify of rsvp
        @host = User.find(@event.user_id)
        UserMailer.with(host: @host, pet: pet, event: @event).rsvp_to_host.deliver_later
      end
    end

    redirect_to @event
  end

  # GET /events/new
  def new
    @event = Event.new
    @types = Type.all

  end

  # GET /events/1/edit
  def edit
    @types = Type.all
    if @event.user != current_user
      redirect_to action: "show"
    end
  end

  # POST /events
  # POST /events.json
  def create
    @types = Type.all
    @event = parse_event_to_local_time(Event.new(event_params))
    @event.user = current_user

    if params[:event][:img_url] != ""
      puts "HERE =========================================================================================================================================================================================================================================================="
      uploaded_file = params[:event][:img_url].path
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
      @event.img_url = cloudinary_file['url']
    else
      puts "NO IMAGE HERE =========================================================================="
      @event.img_url = ""
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if params[:event][:img_url] != ""
      uploaded_file = params[:event][:img_url].path
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
      @event.img_url = cloudinary_file['url']
    else
    else
      puts "NO IMAGE HERE =========================================================================="
      @event.img_url = ""
    end

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def parse_event_to_local_time (event)
      event.start_time = parse_time_to_singapore(event.start_time)
      event.end_time = parse_time_to_singapore(event.end_time)
      event
    end

    def parse_time_to_singapore (time)
      time - 8.hours
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :capacity, :location, :start_time, :end_time, :min_pets, :img_url, :type_id, :pet_ids => [])
    end
end
