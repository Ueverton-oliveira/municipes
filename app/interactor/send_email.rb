class SendMessage
  include Interactor

  def call
    context.citizen = Citizen.new(context.params)

    if context.citizen.save
      Citizen.where(active: true).each do |citizen|
        SendMailJob.perform_async(citizen.id, citizen.email)
      end
    else
      context.fail! unless context.citizen.valid?
    end
  end
end