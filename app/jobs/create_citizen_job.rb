class CreateCitizenJob < ApplicationJob
  queue_as :mailer

  def perform(citizen_id)
    CitizenMailer.welcome_citizen(citizen_id).deliver_now
  end
end
