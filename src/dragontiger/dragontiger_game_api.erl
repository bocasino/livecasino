-module(dragontiger_game_api).
-export([start_link/3,start_eventbus/1]).
-export([dealer_connect/2,dealer_disconnect/1]).
-export([new_shoe/1,start_bet/1,stop_bet/1,commit/1,bet/3]).
-export([deal/3,clear/2,scan/2]).
-export([update_countdown/2]).
-export([ace/0,two/0,three/0,four/0,five/0,six/0,seven/0,eight/0,nine/0,ten/0,jack/0,queen/0,king/0]).


-define(SERVER,dragontiger_game).

start_eventbus(DeaelrTableId)-> 
	EventBus=game_eventbus:global_game_eventbus(DeaelrTableId),
	game_eventbus:start_game_eventbus(EventBus).

start_link(EventBus,Table,Countdown)->
	GameServer=game_eventbus:global_game_server(Table),
	game_eventbus:start_game_server(GameServer,?SERVER,{EventBus,Table,Countdown}).

new_shoe(GameServer)->
	gen_fsm:sync_send_event(GameServer,new_shoe).

start_bet(GameServer)->
	gen_fsm:sync_send_event(GameServer,start_bet).

bet(GameServer,Cats,Amounts)->
	gen_fsm:sync_send_event(GameServer,{bet,Cats,Amounts}).

stop_bet(GameServer)->
	gen_fsm:sync_send_event(GameServer,stop_bet).

scan(GameServer,Card)->
	gen_fsm:sync_send_event(GameServer,{scan,Card}).

deal(GameServer,Pos,Card)->
	gen_fsm:sync_send_event(GameServer,{deal,Pos,Card}).

clear(GameServer,Pos)->
	gen_fsm:sync_send_event(GameServer,{clear,Pos}).

commit(GameServer)->
	gen_fsm:sync_send_event(GameServer,commit).

dealer_connect(GameServer,Dealer)->
	gen_fsm:sync_send_all_state_event(GameServer,{dealer_connect,Dealer}).

dealer_disconnect(GameServer)->
	gen_fsm:send_all_state_event(GameServer,{dealer_disconnect,self()}).

update_countdown(GameServer,Countdown)->
	gen_fsm:sync_send_all_state_event(GameServer,{update_countdown,Countdown}).


-include("dragontiger.hrl").
ace()->?ACE.
two()->?TWO.
three()->?THREE.
four()->?FOUR.
five()->?FIVE.
six()->?SIX.
seven()->?SEVEN.
eight()->?EIGHT.
nine()->?NINE.
ten()->?TEN.
jack()->?JACK.
queen()->?QUEEN.
king()->?KING.