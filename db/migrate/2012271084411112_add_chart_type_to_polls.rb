class AddChartTypeToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :chart_type, :string
  end
end
