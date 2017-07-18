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
    
    def check
        id = params[:id]
        @match = Match.find(id)
        if @match.update(status: "checked") then
            render text: "true"
        else
            render text: "false"
        end
    end
end
