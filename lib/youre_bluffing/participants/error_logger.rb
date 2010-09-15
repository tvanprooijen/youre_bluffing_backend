module YoureBluffing::Participants

  class ErrorLogger < Base
    
    def log_error
      log "process: #{work_item.wfid} in error" 
      log work_item.error
      game.put(:fail)
    end
    
  end
  
end