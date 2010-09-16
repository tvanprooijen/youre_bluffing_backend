module YoureBluffing::Participants
  class Base
    include YoureBluffing::Constants
    attr :work_item
  
    def initialize(work_item)
      raise ArgumentError, "work item is missing game id" if work_item.fields['game_id'].blank? 
      @work_item = work_item
    end
    
    def game
      @game ||= YoureBluffing::Models::Game.find(work_item.fields['game_id'])
    end
    
    def reload_game
      @game = nil
    end
  
    def current_player 
      game.try(:current_player)
    end
  
    def current_player_name 
      current_player.try(:name)
    end
    
    def other_players
      # all players except current_player
      game.players.reject{|p|p.id == current_player.id}
    end
    
  
    def current_card_on_deck
      "<Pig - 600>"
    end
  
    def current_player_in_bidding
      "Harry S."
    end
  
    def auction_winner
      "MR. X"
    end
  
    def log(text, access = :private)
      # public logs will be shown to the players in the gui
      puts "[#{Time.now.strftime('%H:%m')} - #{self.class.name} ] #{text}"
    end
  
    def method_missing(method, *args)
      log "unknow task '#{method}'"
    end

  end
end 