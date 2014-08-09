# -*- encoding : utf-8 -*-
class AddInitialSettings < ActiveRecord::Migration
  def up
    GlobalSetting.create(:name => 'quality_type')
    GlobalSetting.create(:name => 'pn_type')
    GlobalSetting.create(:name => 'count_to_buy')
  end

  def down
    GlobalSetting.delete(:name => 'quality_type')
    GlobalSetting.delete(:name => 'pn_type')
    GlobalSetting.delete(:name => 'count_to_buy')
  end
end
