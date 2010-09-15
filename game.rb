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

engine.register_participant :error_logger do |work_item|
  error_logger = YoureBluffing::Participants::ErrorLogger.new work_item
  error_logger.log_error
  error_logger.work_item
end

wfid = engine.launch YoureBluffing::GameProcess::DEFINTITION

require 'sinatra'
require 'builder'
require 'xmlsimple'

set :bind, 'localhost'
set :port, 8088

puts "Youre Bluffing Backend started - listining on http://localhost:88/"

post '/game_processes.xml' do
  game_process = XmlSimple.xml_in request.body.read
  game_id = game_process["game-id"].first["content"]
  
  if game_id.blank?
    halt 500
  else
    wfid = engine.launch( 
      YoureBluffing::GameProcess::DEFINTITION,
      {'game_id' => game_id } )
    
    builder do |xml|
      xml.game_process do
        xml.id wfid
      end
    end
  end
end
