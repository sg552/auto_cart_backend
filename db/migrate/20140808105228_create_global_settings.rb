# -*- encoding : utf-8 -*-
class CreateGlobalSettings < ActiveRecord::Migration
  def change
    create_table :global_settings do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
