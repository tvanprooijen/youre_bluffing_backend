module YoureBluffing::Participants
  class Base
    attr :work_item
  
    def initialize(work_item)
      @work_item = work_item
    end
  
    def current_player_name 
      "Johny Test"
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
  
    def log(text)
      puts "[#{Time.now.strftime('%H:%m')} - #{self.class.name} ] #{text}"
    end
  
    def method_missing(method, *args)
      log "unknow task '#{method}'"
    end

  end
end 