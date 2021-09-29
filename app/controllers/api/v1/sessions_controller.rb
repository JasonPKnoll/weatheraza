class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params['email'])

    if user.present? && user.authenticate(params['password'])
      render json: UserSerializer.new(user),
        status: 200,
        logged_in: true
    else
      render json: { error: 'bad paramaters' }, status: 401
    end
  end

end
