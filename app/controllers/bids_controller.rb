class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :matching]
  before_action :authenticate_user!

  # GET /bids
  # GET /bids.json
  def index
    @bids_not_matched = current_user.bids.where(match_id: nil)
    @bids_matched = current_user.bids.where.not(match_id: nil)
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        current_user.bids << @bid
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /bids/1/matching
  # POST /bids/1/matching.json
  def matching
    # 第一言語か第二言語がマッチした人のAsk
    @users = User.where('first_language = ? or second_language = ?', @bid.user.first_language, @bid.user.first_language).pluck(:id)
    @asks = Ask.where(user_id: @users)
    # マッチしてない
    @asks = @asks.where(match_id: nil)
    # 時間がマッチしたAsk
    @asks = @asks.where('time_from <= ? and time_to >= ?', @bid.time_from, @bid.time_to)
    # 距離が近い順にソート＋フィルタリング
    @asks= @asks.near([@bid.latitude, @bid.longitude], 50)
    render json: @asks.to_json(:include => :user)
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = current_user.bids.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:address, :latitude, :longitude, :time_from, :time_to, :user_id)
    end
end
