class UpdateCitizen
  include Interactor

  def call
    context.citizen = Citizen.new(context.params)

    if context.citizen.update
      Citizen.where(active: true).each do |citizen|
        UpdateCitizenJob.perform_async(citizen.id)
      end
    else
      context.fail! unless context.citizen.valid?
    end
  end
end