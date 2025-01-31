class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :download]
  before_action :log_impression, only: [:show]


  # GET /documents
  # GET /documents.json
  
  def index
    if params[:search]
      @documents = Document.search(params[:search]).order("created_at DESC")
    else
      @documents = Document.all.order("created_at DESC")
    end
    @documents = @documents.page params[:page]
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @author = User.find(@document.user_id)
  end
  
  def log_impression
    @hit_document = Document.find(params[:id])
      # this assumes you have a current_user method in your authentication system
    @hit_document.impressions.create(ip_address: request.remote_ip)
  end
  
  def download
    data = open(@document.avatars[0].url)
    send_data data.read, :type => data.content_type, :x_sendfile => true
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # document /documents
  # document /documents.json
  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :content, {avatars: []}, :search)
    end
end
