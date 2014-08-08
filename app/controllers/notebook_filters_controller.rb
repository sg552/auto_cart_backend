# -*- encoding : utf-8 -*-
class NotebookFiltersController < ApplicationController
  before_filter :get_by_id, :only => [:show, :edit, :update, :destroy]
  def index
    @notebook_filters = NotebookFilter.all
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
    redirect_to @notebook_filter, notice: 'Notebook filter was successfully created.'
  end

  def update
    @notebook_filter.update_attributes(params[:notebook_filter])
    redirect_to @notebook_filter, notice: 'Notebook filter was successfully updated.'
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
