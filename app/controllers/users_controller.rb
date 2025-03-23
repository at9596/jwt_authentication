class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i(create)
  before_action :set_user, only: %i(show update destroy)

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      render json: @user,  status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: @user, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
  end
  private

  def user_params
    # params.expect(user: [:name , :email, :password])
    params.require(:user).permit(:name, :email, :password)
  end
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
