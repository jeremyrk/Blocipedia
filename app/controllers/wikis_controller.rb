class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
    authorize! :create, Wiki, message: "You need to be a member to create a new wiki."
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
     authorize! :edit, @wiki, message: "You need to own the wiki to edit it."
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize! :create, @wiki, message: "You need to be signed up to do that."
    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:error] = "Error creating Wiki. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to own the wiki to edit it."
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end