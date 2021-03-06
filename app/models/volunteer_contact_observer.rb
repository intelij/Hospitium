require 'juggernaut'

class VolunteerContactObserver < ActiveRecord::Observer
  def after_update(volunteer_contact)
    publish(:update, volunteer_contact)
  end

  def publish(_type, volunteer_contact)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/volunteer_contact/#{volunteer_contact.id}", {
    #   id: volunteer_contact.id,
    #   type: type,
    #   klass: volunteer_contact.class.name,
    #   record: volunteer_contact.changes
    # })
    ActionCable.server.broadcast "bip_#{volunteer_contact.id}",
                                 record: volunteer_contact.changes
  end
end
