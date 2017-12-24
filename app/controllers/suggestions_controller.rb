class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy, :download]
  before_action :log_impression, only: [:show]


  # GET /suggestions
  # GET /suggestions.json
  
  def index
    if params[:search]
      @suggestions = Suggestion.search(params[:search]).order("created_at DESC")
    else
      @suggestions = Suggestion.all.order("created_at DESC")
    end
    @suggestions = @suggestions.page params[:page]
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @author = User.find(@suggestion.user_id)
  end
  
  def log_impression
    @hit_suggestion = Suggestion.find(params[:id])
      # this assumes you have a current_user method in your authentication system
    @hit_suggestion.impressions.create(ip_address: request.remote_ip)
  end
  
  def download
    data = open(@suggestion.avatars[0].url)
    send_data data.read, :type => data.content_type, :x_sendfile => true
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
  end

  # suggestion /suggestions
  # suggestion /suggestions.json
  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.user_id = current_user.id

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @suggestion, notice: 'suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:title, :content, {avatars: []}, :search)
    end
end
