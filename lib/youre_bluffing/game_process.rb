module YoureBluffing::GameProcess
  
  DEFINTITION = Ruote.process_definition :name => 'youre_bluffing', :version => '1' do
    referee         :task       =>  :start_game
    referee         :task       =>  :pick_first_player

    cursor do
      referee       :task       =>  :prepare_action
      skip 1,       :unless     =>  "${f:action} == undicided"
      player        :task       =>  :choose_auction_or_trade
      auction       :if         =>  "${f:action} == auction"
      trade         :if         =>  "${f:action} == trade"
      referee       :task       =>  :calculate_scores
      referee       :task       =>  :check_for_winner
      stop          :if         =>  '${f:winner}'
      referee       :task       =>  :pick_next_player
      rewind
    end

    define 'auction' do
      referee       :task       =>  :start_auction
      referee       :task       =>  :flip_card_for_auction
      referee       :task       =>  :pick_first_player_for_bidding

      cursor do
        cursor do   
          player    :task       =>  :make_bid_or_pass
          referee   :task       =>  :check_if_auction_is_finished
          stop      :if         =>  '${f:auction_finished}'
          referee   :task       =>  :pick_next_player_for_bidding
          rewind  
        end
        player      :task       =>  :choose_to_buy_self_or_sell
        referee     :task       =>  :check_if_buyer_has_enough_cash
        stop        :unless     =>  '${f:auction_failed}'
        referee     :task       =>  :show_buyers_money
        rewind      
      end

      cursor do
        player      :task       =>  :buyer_pick_notes
        referee     :task       =>  :check_if_picked_enough
        rewind      :if         =>  '${f:not_picked_enough}' 
      end
      referee       :task       =>  :move_cash_from_seller_to_buyer  
      referee       :task       =>  :move_card_from_deck_to_buyer         
    end

    define 'trade' do
      cursor do
        player      :task       =>  :select_animal_for_trading
        referee     :task       =>  :check_if_animal_is_tradeable
        rewind      :if         =>  '${f:animal_not_tradeable}'
      end
      referee       :task       =>  :check_trade_partner_posibilities
      cursor        :unless     =>  '${f:only_one_trade_partner_possible}' do
        player      :task       =>  :select_trade_partner
        referee     :task       =>  :validate_trade_partner
        rewind      :if         =>  '${f:trade_partner_invalid}'
      end
      referee       :task       =>  :set_trade_partner
      referee       :task       =>  :set_number_of_cards_in_trade
      referee       :task       =>  :move_cards_from_player_to_trade_pit
      referee       :task       =>  :move_cards_from_trade_partner_to_trade_pit
      player        :task       =>  :make_offer
      player        :task       =>  :accept_offer_or_make_counter_offer
      referee       :task       =>  :move_notes_from_player_to_trade_partner
      referee       :task       =>  :move_notes_from_trade_partner_to_player
      referee       :task       =>  :determen_trade_winner
      referee       :task       =>  :move_cards_from_trade_pit_to_winner

    end
  
  end

end