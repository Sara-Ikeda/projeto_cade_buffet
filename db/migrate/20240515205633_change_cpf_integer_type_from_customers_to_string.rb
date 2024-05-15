class ChangeCpfIntegerTypeFromCustomersToString < ActiveRecord::Migration[7.1]
  def change
    change_column :customers, :cpf, :string
  end
end
