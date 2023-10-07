class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_prototype, only: [:edit,:show ]
  before_action :move_to_index, only: [:edit, :index ]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new 
    @prototype = Prototype.new
  end

  def create 
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to '/' 
    else
    render :new , status: :unprocessable_entity
    end
  end

  def show 
    @comment = Comment.new   
    @comments = @prototype.comments.includes(:user)

  end

  def edit 
  end

  def update
    @prototype = Prototype.find(params[:id])
   if @prototype.update(prototype_params)
    redirect_to prototype_path
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? 
      redirect_to action: :index
    end
  end


end
