# -*- encoding : utf-8 -*-
class GlobalSetting < ActiveRecord::Base
  attr_accessible :name, :value
  QUALITY_TYPE_NEW = 'new'
  QUALITY_TYPE_RETREADED ='retreaded'
  QUALITY_TYPE_BROKEN = 'broken'
  PN_TYPE_LONG = 'long'
  PN_TYPE_SHORT = 'short'

  def contain? setting_name
    return value.split(';').include? setting_name rescue false
  end
end
