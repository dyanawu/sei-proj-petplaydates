class UserMailer < ApplicationMailer
  default from: 'pawdates2020@gmail.com'

  def rsvp_to_host
    @pet = params[:pet]
    @petowner = User.find(@pet.user_id)
    @event = params[:event]
    @host = params[:host]
    mail(to: @host.email, subject: 'PawDates: New RSVP For ' + @event.title)
  end
end
