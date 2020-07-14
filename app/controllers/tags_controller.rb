class TagsController < ApplicationController
  before_action :require_user, except: [:index]
  before_action :find_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:name))

    if @tag.save
      tag_successfully(:created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.save
      tag_successfully(:updated)
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    tag_successfully(:destroyed)
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_successfully(action, path=tags_path)
    redirect_to path, notice: "Tag was successfully #{action}."
  end
end