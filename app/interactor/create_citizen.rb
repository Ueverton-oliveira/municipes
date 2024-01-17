class CreateCitizen
  include Interactor

  def call
    context.citizen = Citizen.new(context.params)

    if context.citizen.save
      Citizen.where(active: true).each do |citizen|
        CreateCitizenJob.perform_async(citizen.id)
      end
    else
      context.fail! unless context.citizen.valid?
    end
  end
end