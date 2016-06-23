class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    message = []
    if user.tickets < attraction.tickets && user.height < attraction.min_height
      message << "Sorry. You do not have enough tickets the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif user.tickets < attraction.tickets
      message << "Sorry. You do not have enough tickets the #{self.attraction.name}."
    elsif user.height < attraction.min_height
      message << "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    end
    if user.tickets >= attraction.tickets && user.height >= attraction.min_height
      user.tickets -= attraction.tickets
      user.nausea += attraction.nausea_rating
      user.happiness += attraction.happiness_rating
      user.save
      message << "Thanks for riding the #{self.attraction.name}!"
    end
    message.join(" ")
  end

end
