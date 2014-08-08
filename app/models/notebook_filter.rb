# -*- encoding : utf-8 -*-
class NotebookFilter < ActiveRecord::Base
  attr_accessible :cpu, :harddisk, :keyword, :price, :screen, :name
end
