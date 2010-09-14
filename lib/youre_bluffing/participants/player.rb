module YoureBluffing::Participants
  
  class Player < Base
  
    ##### Main game flow
  
    def choose_auction_or_trade
      puts "player: choose_auction_or_trade! -> (t)rade or (a)uction?"
      case gets[0,1]
        when 't'
          work_item.fields['action'] = YoureBluffing::Actions::TRADE
          log "Player '#{current_player_name}' has chosen to trade"
        else
          work_item.fields['action'] = YoureBluffing::Actions::AUCTION
          log "Player '#{current_player_name}' has chosen to auction"
      end
    end
  
    #### Auctioning
  
    def make_bid_or_pass
      puts "player: make bid or pass! -> (p)ass or any binnding in numbers?"
      response = gets
      case
        when response[0,1] == 'p'
          log "Player '#{current_player_in_bidding}' has passed his in this auction"
        else 
          log "Player '#{current_player_in_bidding}' bids #{response} for this #{current_card_on_deck}"
      end
    end
  
    def choose_to_buy_self_or_sell
    
    end
  
  
  
    def buyer_pick_notes
    
    end
  
  end  
end