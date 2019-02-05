class ApplicationController < ActionController::Base
  def hello
    render html:"¡Hola,mondo!"
  end

  def goodbye
    render html:"goodbye,world!"
  end
end
