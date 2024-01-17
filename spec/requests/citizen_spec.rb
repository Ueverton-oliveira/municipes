require 'rails_helper'

RSpec.describe "Citizens", type: :request do
  let(:photo) do
    fixture_file_upload('spec/support/images/selfie1.jpg', 'image/png')
  end
  let(:citizen) { create(:citizen) }
  let(:new_attributes) { { name: 'Joao Souza' } }
  let(:valid_attributes) do
    { name: 'Ueverton Souzas', cns: '123456789',
      cpf: '568.999.300-05', email: 'ueverton.souz@gmail.com',
      birthday: Time.zone.today - 31.years, phone: '5567992269670',
      photo: photo,
      address_attributes: {
        cep: '88701-210', street: 'Rua Bongiovani',
        neighborhood: 'Vila Donaria',
        city: 'Bonito', state: 'Mato Grosso do Sul',
        complement: 'Casa de esquina', ibge: '987654321'
      } }
  end
  let(:invalid_attributes) do
    { name: '' }
  end

  describe 'GET #index' do
    it 'assigns all citizens as @citizens' do
      get :index
      expect(assigns(:citizens)).to eq([citizen])
    end
  end

  describe 'GET #index with search' do
    it 'returns the citizens searched correctly' do
      citizen1 = create(:citizen, name: 'Cidadão 1')
      citizen2 = create(:citizen, name: 'Cidadão 2')

      get :index,
          params: {
            q:
              {
                name_cont:
                  'Cidadão 1'
              }
          }

      expect(assigns(:citizens)).to include(citizen1)
      expect(assigns(:citizens)).to_not include(citizen2)
    end

    it 'excludes non-matching results' do
      create(:citizen, name: 'Cidadão 1')

      get :index,
          params: {
            q: {
              name_cont:
                'Cidadão 2'
            }
          }

      expect(assigns(:citizens)).to be_empty
    end

    it 'renders the index template' do
      get :index,
          params: {
            q: {
              name_cont:
                '1'
            }
          }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested citizen as @citizen' do
      get :show, params: { id: citizen.id }
      expect(assigns(:citizen)).to eq(citizen)
    end
  end

  describe 'GET #new' do
    it 'assigns a new citizen as @citizen' do
      get :new
      expect(assigns(:citizen)).to be_a_new(Citizen)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested citizen as @citizen' do
      get :edit, params: { id: citizen.id }
      expect(assigns(:citizen)).to eq(citizen)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Citizen' do
        expect do
          post :create,
               params: { citizen: valid_attributes }
        end.to change(Citizen, :count).by(1)
      end

      it 'redirects to the created citizen' do
        post :create,
             params: { citizen: valid_attributes }
        expect(response).to redirect_to(citizen_path(Citizen.last))
      end
    end

    context 'with invalid params' do
      it 're-renders the "new" template' do
        post :create,
             params: { citizen: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested citizen' do
        put :update,
            params: { id: citizen.id,
                      citizen: new_attributes }
        citizen.reload
        expect(citizen.name).to eq('Joao Souza')
      end

      it 'redirects to the citizen' do
        put :update,
            params: { id: citizen.id,
                      citizen: new_attributes }
        expect(response).to redirect_to(citizen_path(citizen))
      end
    end

    context 'with invalid params' do
      it 're-renders the "edit" template' do
        put :update,
            params: { id: citizen.id,
                      citizen: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end
end

