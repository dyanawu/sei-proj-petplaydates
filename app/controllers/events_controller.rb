# require 'time'
# require "active_support/all"
require "net/http"

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def homepage
    @events = Event.order(id: :desc)
    @events_today = Event.where(start_time: Time.now.beginning_of_day..Time.now.end_of_day)
                      .order(start_time: :asc)
    @events_upcoming = Event.where(
      start_time: Time.now.beginning_of_day + 1.day..Time.now.beginning_of_day + 8.days)
                         .order(start_time: :asc)
    @events_recent = Event.order(id: :desc).limit(15)
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
  end

  # POST /events
  # POST /events.json
  def create
    @types = Type.all
    @event = parse_event_to_local_time(Event.new(event_params))
    @event.user = current_user

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
      params.require(:event).permit(:title, :description, :capacity, :location, :start_time, :end_time, :min_pets, :type_id, :pet_ids => [])
    end
end
