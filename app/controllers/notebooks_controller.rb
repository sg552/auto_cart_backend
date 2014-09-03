# -*- encoding : utf-8 -*-
class NotebooksController < ApplicationController
  def index
    @notebooks = Notebook.all

  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def new
    @notebook = Notebook.new
  end

  def edit
    @notebook = Notebook.find(params[:id])
  end

  def create
    @notebook = Notebook.new(params[:notebook])

      if @notebook.save
        redirect_to @notebook, notice: 'Notebook was successfully created.'
      else
        render action: "new"
      end
  end

  def update
    @notebook = Notebook.find(params[:id])

    if @notebook.update_attributes(params[:notebook])
      redirect_to @notebook, notice: 'Notebook was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @notebook = Notebook.find(params[:id])
    @notebook.destroy
    redirect_to notebooks_url
  end

  def available_notebooks
    render :json =>{
      :result => Notebook.all.map {  |notebook|
        {
          :url =>  notebook.name
        }
      }
    }
  end
end
