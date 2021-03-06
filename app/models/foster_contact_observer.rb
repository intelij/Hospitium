require 'juggernaut'
class FosterContactObserver < ActiveRecord::Observer
  def after_update(foster_contact)
    publish(:update, foster_contact)
  end

  def publish(_type, foster_contact)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/foster_contact/#{foster_contact.id}", {
    #   :id     => foster_contact.id,
    #   :type   => type,
    #   :klass  => foster_contact.class.name,
    #   :record => foster_contact.changes
    # })
    Rails.logger.info 'twaaaaaaa'
    ActionCable.server.broadcast "bip_#{foster_contact.id}",
                                 record: foster_contact.changes
  end
end
