require 'init'

engine = Ruote::Engine.new(
  Ruote::Worker.new(
    Ruote::FsStorage.new(
      'ruote_work'
    )
  )
)
  

engine.register_participant :player do |work_item|
  player = YoureBluffing::Participants::Player.new work_item
  player.send work_item.fields["params"]["task"].to_sym
  player.work_item
end

engine.register_participant :referee do |work_item|
  referee = YoureBluffing::Participants::Referee.new work_item
  referee.send work_item.fields["params"]["task"].to_sym
  referee.work_item
end

wfid = engine.launch YoureBluffing::GameProcess::DEFINTITION


engine.wait_for(wfid)


engine.errors(wfid).each do |error|
  error.each_pair{|k,v| puts "#{k}\t\t\t: #{v}"}
end
