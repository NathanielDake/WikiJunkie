class WikisController < ApplicationController
include WikisHelper

  before_action :authorize_user, except: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @collaborations = User.all - [current_user]
  end

  def create
    create_wiki
    if @wiki.save
      new_collaboration
      flash[:notice] = "Your new Wiki has been created."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error creating the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborations = User.all - [@wiki.user]
  end

  def update
    update_wiki
    if @wiki.save
      edit_collaboration
      flash[:notice] = "Your wiki has been updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating your wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private
  def authorize_user
    unless current_user
      flash[:alert] = "You must be signed in to do that."
      redirect_to wikis_path
    end
  end

end
