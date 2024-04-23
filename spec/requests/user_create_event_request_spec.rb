require 'rails_helper'

describe 'Usuário cria um evento' do
  it 'mas não está autenticado' do
    
    post(events_path, params: { event: {name: '', buffet_id: 1}})

    expect(response).to redirect_to new_owner_session_path
  end
end