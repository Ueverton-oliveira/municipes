class UpdateCitizenJob < ApplicationJob
  queue_as :mailers

  def perform(citizen_id)
    CitizenMailer.update_citizen(citizen_id).deliver_now
  end
end
