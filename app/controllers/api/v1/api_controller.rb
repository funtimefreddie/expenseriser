class Api::V1::ApiController < ActionController::Base
# Authentication and other filters implementation.

  def authenticate

    token = request.headers["token"]
    name = request.headers["name"]
    @user = User.where(name: name).first

    # byebug 

    @test = @user.api_key.token == token 
    return @test

  end

end