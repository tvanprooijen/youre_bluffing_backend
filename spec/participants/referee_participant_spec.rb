require File.join(File.dirname(__FILE__), '..', '..','init')
Spec::Runner.configure do |config|
  config.mock_with :rr
end

include YoureBluffing::Participants

WorkItem = Struct.new(:fields)

describe 'Referee' do
  
  before :each do
    @referee = Referee.new WorkItem.new({'game_id' => 0})
    stub(@referee).game{@game}
  end
  
  
  describe '#start_game' do
    it "should call the put start method on the active resource model" do
      @game = mock!.put(:start)
      @referee.start_game
    end
  end
  
  
  
  
  
end

