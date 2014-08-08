# -*- encoding : utf-8 -*-
class GlobalSetting < ActiveRecord::Base
  attr_accessible :name, :value
end
