class Api::V1::UsersController < ApplicationController
  before_action :valid_params, only: [:create]

  def create
    user = User.create(user_params)

    render json: UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def valid_params
    if params[:password] != params[:password_confirmation]
      render json: {:error => 'passwords do not match'}, status: 400
    elsif !params.values_at(:email, :password, :password_confirmation).all?(&:present?)
      render json: {:error => 'missing paramater'}, status: 400
    else
    end
  end

end
