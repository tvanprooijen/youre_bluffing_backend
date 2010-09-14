module YoureBluffing::Participants

  class Referee < Base
  
    ######### Main game flow
  
    def start_game
      log "Game started."
    end
  
    def pick_first_player
      log "Player '#{current_player_name}' is first to start" 
    end
  
    def calculate_scores
      log "Scores calculated"
    end
  
    def prepare_action
      puts "referee: prepare action! -> (p)ass, (t)rade, (a)uction or (u)ndiceded ?"
      case gets[0,1]
        when 'p'
          work_item.fields['action'] = YoureBluffing::Actions::PASS
          log "Player '#{current_player_name}' is passed cause there are no are no matching sets of cards to trade or cards in the deck to auction." 
        when 't'
          work_item.fields['action'] = YoureBluffing::Actions::TRADE
          log "Player '#{current_player_name}' has to trade, cause the deck is out of cards."
        when 'a'
          work_item.fields['action'] = YoureBluffing::Actions::AUCTION
          log "Player '#{current_player_name}' has to auction, cause there are no matching sets of cards to trade."
        else 
          work_item.fields['action'] = YoureBluffing::Actions::UNDICIDED
          log "Player '#{current_player_name}' can choose to trade or auction."
      end
    end
  
    def check_for_winner
      puts "referee: check for winner! -> (y)es or (n)o ?"
      case gets[0,1]
        when 'y'
          work_item.fields['winner'] = true
          log "We have a winner" 
        else
          work_item.fields['winner'] = false
          log "There is no winner yet"
      end
    end 
  
    def pick_next_player
      log "Player '#{current_player_name}' is next" 
    end
  
    ############ AUCTIONING
  
    def start_auction
      log "auction started"
    end 
  
    def flip_card_for_auction
      log "Player '#{current_player_name}' flipped a  #{current_card_on_deck} from the deck of cards"
    end
  
    def pick_first_player_for_bidding
      log "Player '#{current_player_in_bidding}' is first to bid on #{current_card_on_deck}"
    end
  
    def pick_next_player_for_bidding
      log "Player '#{current_player_in_bidding}' is next to bid on #{current_card_on_deck}"
    end
  
    def check_if_auction_is_finished
      puts "referee: check if auction is finished! -> (y)es or (n)o ?"
      case gets[0,1]
        when 'y'
          work_item.fields['auction_finished'] = true
          log "This auction has finished!" 
        else
          work_item.fields['auction_finished'] = false
          log "Moving on with the auction!"
      end
    end
  
    def check_if_buyer_has_enough_cash
      puts "referee: check if buyer has enough cash! -> (y)es or (n)o ?"
      case gets[0,1]
        when 'y'
          work_item.fields['auction_failed'] = true
          log "The winner of the auction has enough cash to pay" 
        else
          work_item.fields['auction_finished'] = false
          log "The winner of the auction doesn't have enough cash to pay"
      end
    
    end
  
    def show_buyers_money
      log "Because player #{auction_winner} has bidded more then he/she has he now has to show its money. The Auction will start over"
    end
    
  end
  
end