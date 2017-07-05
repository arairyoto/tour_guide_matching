class MatchController < ApplicationController
    def push
        bid_id = params[:bid_id]
        ask_id = params[:ask_id]
        @ask = Ask.find(ask_id)
        @bid = Bid.find(bid_id)
        @match = Match.create(status: "waiting")
        @ask.update(match_id: @match.id)
        @bid.update(match_id: @match.id)
        render text: "done!!"
    end
end
