class CreateNotebookFilters < ActiveRecord::Migration
  def change
    create_table :notebook_filters do |t|
      t.string :cpu
      t.string :harddisk
      t.string :screen
      t.string :keyword
      t.string :price
      t.string :name

      t.timestamps
    end
  end
end
