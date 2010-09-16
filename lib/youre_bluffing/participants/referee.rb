module YoureBluffing::Participants

  class Referee < Base
  
    ######### Main game flow
  
    def start_game
      game.put(:start)
      log "Game started.", :public
    end
  
    def pick_first_player
      game.put(:next_player)
      reload_game
      log "Player '#{current_player_name}' is first to start", :public 
    end
    
    def pick_next_player
      game.put(:next_player)
      reload_game
      log "Player '#{current_player_name}' is next", :public
    end
  
    def calculate_scores
      game.put(:calculate_scores)
      log "Scores calculated"
    end
  
    def prepare_action
      can_trade = !game.deck.empty?
      type_of_cards_on_table = other_players.collect{|p|p.cards.collect{|c|c.type}}.flatten.uniq
      can_auction = current_player.cards.detect{|c| type_of_cards_on_table.include? c.type}
      
      work_item.fields['action'] = case
        when can_trade && can_auction then
          MainPlayerActions::UNDICIDED
          log "Player '#{current_player_name}', Please choose if You want to Auction or Trade?", :public
        when can_trade then  
          MainPlayerActions::TRADE
          log "Player '#{current_player_name}', You have to Trade this Turn!", :public
        when can_auction then
          MainPlayerActions::AUCTION
          log "Player '#{current_player_name}', You have to Auction this Turn!", :public
        else
          MainPlayerActions::PASS
          log "Player '#{current_player_name}', You will be Passed this Turn!", :public
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