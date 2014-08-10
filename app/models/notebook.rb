# -*- encoding : utf-8 -*-
class Notebook < ActiveRecord::Base
  attr_accessible :name, :real_price, :cpu, :screen, :harddisk, :add_to_cart_link,
    :created_by
end
