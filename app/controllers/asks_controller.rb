class AsksController < ApplicationController
  before_action :set_ask, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /asks
  # GET /asks.json
  def index
    @asks_not_matched = current_user.asks.where(match_id: nil)
    @asks_matched = current_user.asks.where.not(match_id: nil)
  end

  # GET /asks/1
  # GET /asks/1.json
  def show
  end

  # GET /asks/new
  def new
    @ask = Ask.new
  end

  # GET /asks/1/edit
  def edit
  end

  # POST /asks
  # POST /asks.json
  def create
    @ask = Ask.new(ask_params)

    respond_to do |format|
      if @ask.save
        current_user.asks << @ask
        format.html { redirect_to @ask, notice: 'Ask was successfully created.' }
        format.json { render :show, status: :created, location: @ask }
      else
        format.html { render :new }
        format.json { render json: @ask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asks/1
  # PATCH/PUT /asks/1.json
  def update
    if current_user.asks.where(id: @ask.id).exists? then
      respond_to do |format|
        if @ask.update(ask_params)
          format.html { redirect_to @ask, notice: 'Ask was successfully updated.' }
          format.json { render :show, status: :ok, location: @ask }
        else
          format.html { render :edit }
          format.json { render json: @ask.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { render :edit }
      format.json { render json: @ask.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /asks/1
  # DELETE /asks/1.json
  def destroy
    @ask.destroy
    respond_to do |format|
      format.html { redirect_to asks_url, notice: 'Ask was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask
      @ask = current_user.asks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ask_params
      params.require(:ask).permit(:address, :latitude, :longitude, :time_from, :time_to, :user_id)
    end
end
