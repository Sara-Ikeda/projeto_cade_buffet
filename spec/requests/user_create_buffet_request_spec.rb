require 'rails_helper'

describe 'Usuário cria um Buffet' do
  it 'e não está autenticado' do
    
    post(buffets_path, params: { buffet: {trade_name: '', registration_number: '65845268000269'}})

    expect(response).to redirect_to new_owner_session_path
  end
end