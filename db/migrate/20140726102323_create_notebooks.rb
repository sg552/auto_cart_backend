# -*- encoding : utf-8 -*-
class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :name

      t.timestamps
    end
  end
end
