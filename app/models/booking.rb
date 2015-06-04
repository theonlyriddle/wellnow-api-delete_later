class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor
  belongs_to :slot
  belongs_to :event
  belongs_to :capacity

  after_update :update_related_event

  def update_related_event
    # Booking is confirmed, we create a related event
    if self.booking_status_id == 2 && self.event.nil?
      ev = Event.create(
        :title => "#{self.user.full_name} - #{self.capacity.procedure.name}",
        :description => "<p>Patient</p>
        <ul>
        <li>E-mail: #{self.user.email}</li>
        <li>Phone: #{self.user.phone}</li>
        </ul>
        <p>#{self.description}</p>
        <p>Pain: #{self.pain}</p>
        <p>-- Created online with Wellnow.ch</p>",
        :place => self.doctor.full_street_address,
        :is_all_day => false,
        :datetime_from => self.slot.start,
        :datetime_to => self.slot.start + self.capacity.length.minutes,
        :is_recurring => false,
        :doctor => self.doctor
      )

      self.event = ev
      self.save

    # Booking is cancelled, we delete the related event
    elsif self.booking_status_id == 3
      self.event.destroy
    end

  end
end
