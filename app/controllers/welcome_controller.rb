class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails"
    @nome = params[:nome] 
    @curso = "Rails"
  end
end
