# -*- encoding : utf-8 -*-
class NotebookFiltersController < ApplicationController
  before_filter :get_by_id, :only => [:show, :edit, :update, :destroy]

  def read_complete_content
    html_content = params[:html_content]

    File.open 'tmp/result', 'w' do |file|
      file.write html_content
    end
    ParseHelper.parse(html_content)

    render :json => {:result => 'success', :size => html_content.size }
  end

  def index
    @notebook_filters = NotebookFilter.all
    @pn_setting = GlobalSetting.where('name = ?', 'pn_type').first
    @quality_setting = GlobalSetting.where('name = ?', 'quality_type').first
    @count_to_buy_setting = GlobalSetting.where('name = ?', 'count_to_buy').first
  end

  def show
  end

  def new
    @notebook_filter = NotebookFilter.new
  end

  def edit
  end

  def create
    @notebook_filter = NotebookFilter.new(params[:notebook_filter])
    @notebook_filter.save
    redirect_to notebook_filters_path, notice: 'Notebook filter was successfully created.'
  end

  def update
    @notebook_filter.update_attributes(params[:notebook_filter])
    redirect_to notebook_filters_path, notice: 'Notebook filter was successfully updated.'
  end

  def destroy
    @notebook_filter.destroy
    redirect_to notebook_filters_url
  end
  private
  def get_by_id
    @notebook_filter = NotebookFilter.find(params[:id])
  end
end
