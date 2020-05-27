#### Approach and Process

1. What in our process and approach to this project would we do differently next time?

_More functionality/userflow planning to map out relational constraints might have helped us reduce the number of migrations we needed to run over the course of the project._

2. What in our process and approach to this project went well that we would repeat next time?

_Frequent deploys meant we had a working project. Teammates being used to communicating remotely meant it wasn't too hard to deconflict stuff. Everyone did their part so we managed to finish what we set out to do in good time._

--

#### Code and Code Design

1. What in our code and program design in the project would we do differently next time?

_Less use of Bootstrap cards where it isn’t appropriate, e.g. in the Events index. A modified version of Bootstrap cards would have worked better for displaying a list of events--probably one where the images are on the left of the card, and the cards are stacked in rows. Right now with the standard cards it looks quite cluttered when there are multiple events, and when the browser gets smaller the text can get hard to read._

2. What in our code and program design in the project went well? Is there anything we would do the same next time?

_Using libraries whenever available helped us reduce code written (snippet 1, using owl carousel)_

_Writing helper methods (snippet 2)_

  For each, please include code examples that each team member wrote.
  1. Code snippet up to 20 lines.

```ruby
# Snippet 1
# using active_record_union let us do this instead to
# join two queries into one ActiveRecord Collection
# app/models/user.rb
def events_all
  self.events_attending.union(self.events).distinct
end
```

``` ruby
# Snippet 2
# app/controllers/events_controller.rb
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
```


  2. Code design documents or architecture drawings / diagrams.

#### WDI Unit 3 Post Mortem (individual)
1. What habits did I use during this unit that helped me?

_dw: Committing frequently let me roll back almost as frequently._

_Chels: Using more methods to get data_

_Dian:_
_Getting used to the whole git checkout and rebase process_
_Pacing myself throughout the 1 week+_

2. What habits did I have during this unit that I can improve on?

_dw: Maybe a slightly low communication level overall._

_Chels: Tend to start work late, and do things pretty slowly._

3. How is the overall level of the course during this unit? (instruction, course materials, etc.)

_dw: a little rushed? For me, the underlying workings of Rails could have been a little more deeply covered._

_Dian: Yep, rushed._

_Chels: It was ok, but I thought that choosing Ruby on Rails was a little odd since many are saying it’s dying right now_
