class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :download]
  before_action :log_impression, only: [:show]


  # GET /posts
  # GET /posts.json
  
  def index
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order("created_at DESC")
    end
    @posts = @posts.page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @author = User.find(@post.user_id)
  end
  
  def log_impression
    @hit_post = Post.find(params[:id])
      # this assumes you have a current_user method in your authentication system
    @hit_post.impressions.create(ip_address: request.remote_ip)
  end
  
  def download
    data = open(@post.avatars[0].url)
    send_data data.read, :type => data.content_type, :x_sendfile => true
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, {avatars: []}, :search)
    end
end
