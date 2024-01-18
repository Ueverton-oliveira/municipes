class CitizenController < ApplicationController
  before_action :set_citizen,
                only: %i[show edit update]

  def index
    if params[:name].present?
      @citizen = Citizen.search_by_name(params[:name])
      if @citizen.empty?
        flash.now[:notice] = "Nenhum munícipe com esse nome encontrado."
      end
    else
      @citizen = Citizen.all
    end
  end

  def show; end

  def new
    @citizen = Citizen.new
    @citizen.build_address
  end

  def edit
    @citizen.build_address unless @citizen.address
  end

  def create
    result = CreateCitizen.call(params: citizen_params)

    if result.success?
      redirect_to result.citizen, notice: t('controllers.citizen.create.success')
    else
      @article = result.citizen
      render :new
    end
  end

  def update
    result = UpdateCitizen.call(params: citizen_params)

    if result.success?
      redirect_to result.citizen, notice: t('controllers.citizen.update')
    else
      @article = result.citizen
      render :edit
    end
  end

  private

  def set_citizen
    @citizen = Citizen.find(params[:id])
  end

  def citizen_params
    params.require(:citizen).permit(
      :full_name, :cns, :cpf, :email, :birthday, :phone, :active, :photo,
      address_attributes:
        %i[id cep street neighborhood city uf complement ibge]
    )
  end
end
