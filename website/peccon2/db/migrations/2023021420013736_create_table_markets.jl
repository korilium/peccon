module CreateTableMarkets

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:markets) do
    [
      pk()
      column(:ticker, :string, limit=10) 
      column(:timestamp, :date)
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

  add_indices(:markets, :ticker, :timestamp)
end

function down()
  drop_table(:markets)
end

end
