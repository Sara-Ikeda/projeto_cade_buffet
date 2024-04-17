require 'rails_helper'

describe 'Usuário visita página inicial' do
    it 'e vê nome da aplicação' do
      visit root_path

      expect(page).to have_content 'Cadê Buffet?'
  end
end
