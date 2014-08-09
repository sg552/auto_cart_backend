# -*- encoding : utf-8 -*-
class GlobalSettingsController < ApplicationController
  before_filter :get_by_id, :only => [:show, :edit, :update, :destroy]

  def update_global_config
    @pn_setting = GlobalSetting.where('name = ?', 'pn_type').first
    @pn_setting.update_attributes :value => params[:pn_type].try(:join,';')
    @quality_setting = GlobalSetting.where('name = ?', 'quality_type').first
    @quality_setting.update_attributes :value => params[:quality_type].try(:join,';')
    GlobalSetting.where('name = ?', 'count_to_buy').first.
      update_attributes :value => params[:count_to_buy]
    redirect_to :back, :notice => '操作成功'
  end
  def index
    @global_settings = GlobalSetting.all
  end

  def show
  end

  def new
    @global_setting = GlobalSetting.new
  end

  def edit
  end

  def create
    @global_setting = GlobalSetting.new(params[:global_setting])

    redirect_to @global_setting, notice: 'Global setting was successfully created.'
  end

  def update
    redirect_to @global_setting, notice: 'Global setting was successfully updated.'
  end

  def destroy
    @global_setting.destroy
    redirect_to global_settings_url
  end
  private
  def get_by_id
    @global_setting = GlobalSetting.find(params[:id])
  end
end
