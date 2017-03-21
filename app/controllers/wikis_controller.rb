class WikisController < ApplicationController


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
    @wiki = Wiki.new
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]


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
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

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

  def new_collaboration
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end
  end

  def edit_collaboration
    Collaboration.where(wiki_id: @wiki).each do |collaboration|
      collaboration.destroy
    end
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end

  end


end
