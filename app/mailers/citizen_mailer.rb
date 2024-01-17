class CitizenMailer < ApplicationMailer
  def welcome_citizen(citizen_id)
    @citizen = Citizen.find(citizen_id)
    mail(to: @citizen.email, subject: "Seja bem vindo {@citizen.name}")
  end

  def update_citizen(citizen_id)
    @citizen = Citizen.find(citizen_id)
    mail(to: @citizen.email, subject: "Seja bem vindo {@citizen.name} foi atuaalizado com sucesso")
  end
end
