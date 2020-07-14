class TagsController < ApplicationController
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
      redirect_to tags_path, notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.save
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, notice: 'Tag was successfully deleted.'
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end
end