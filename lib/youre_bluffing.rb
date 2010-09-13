module YoureBluffing
  module Actions 
    PASS  = 'pass'
    UNDICIDED = 'undicided'
    AUCTION = 'auction'
    TRADE = 'trade'
  end
end


require File.join(File.dirname(__FILE__), 'youre_bluffing', 'game_process')
require File.join(File.dirname(__FILE__), 'youre_bluffing', 'participant')
require File.join(File.dirname(__FILE__), 'youre_bluffing', 'player_participant')
require File.join(File.dirname(__FILE__), 'youre_bluffing', 'referee_participant')