# -*- encoding : utf-8 -*-
class GlobalSettingsController < ApplicationController
  # GET /global_settings
  # GET /global_settings.json
  def index
    @global_settings = GlobalSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @global_settings }
    end
  end

  # GET /global_settings/1
  # GET /global_settings/1.json
  def show
    @global_setting = GlobalSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @global_setting }
    end
  end

  # GET /global_settings/new
  # GET /global_settings/new.json
  def new
    @global_setting = GlobalSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @global_setting }
    end
  end

  # GET /global_settings/1/edit
  def edit
    @global_setting = GlobalSetting.find(params[:id])
  end

  # POST /global_settings
  # POST /global_settings.json
  def create
    @global_setting = GlobalSetting.new(params[:global_setting])

    respond_to do |format|
      if @global_setting.save
        format.html { redirect_to @global_setting, notice: 'Global setting was successfully created.' }
        format.json { render json: @global_setting, status: :created, location: @global_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @global_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /global_settings/1
  # PUT /global_settings/1.json
  def update
    @global_setting = GlobalSetting.find(params[:id])

    respond_to do |format|
      if @global_setting.update_attributes(params[:global_setting])
        format.html { redirect_to @global_setting, notice: 'Global setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @global_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /global_settings/1
  # DELETE /global_settings/1.json
  def destroy
    @global_setting = GlobalSetting.find(params[:id])
    @global_setting.destroy

    respond_to do |format|
      format.html { redirect_to global_settings_url }
      format.json { head :no_content }
    end
  end
end
