module CreateTableMpts

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:mpts) do
    [
      pk()
      column(:ticker, :string, limit=10) 
      column(:timestamp, :string, limit = 30)
      column(:open, :float)
      column(:high, :float)
      column(:low, :float)
      column(:close, :float)
      column(:adjusted_close, :float)
      column(:volume, :float)
      column(:dividend_amount, :float)
      column(:split_coefficient, :float)
    ]
  end

  add_indices(:mpts, :ticker, :timestamp)
end

function down()
  drop_table(:mpts)
end

end
