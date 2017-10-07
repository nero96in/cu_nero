class HomeController < ApplicationController

  def index
    @posts = Post.all
    @documents = Document.all
  end
  
end
