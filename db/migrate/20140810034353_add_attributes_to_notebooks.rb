# -*- encoding : utf-8 -*-
class AddAttributesToNotebooks < ActiveRecord::Migration
  def change
    add_column :notebooks, :real_price, :string, :default => ''
    add_column :notebooks, :cpu, :string, :default => ''
    add_column :notebooks, :screen, :string, :default => ''
    add_column :notebooks, :harddisk, :string, :default => ''
    add_column :notebooks, :add_to_cart_link, :string, :default => ''
    add_column :notebooks, :created_by, :string, :default => ''
  end
end
