-module(mysql_casino_master).
-export([add_db_pool/0,get_db_pool/0]).

add_db_pool()->
	Params=[{size,3},{user,"ts1"},{host,"192.168.1.12"},{password,"111111"},{database,"casino"},{encoding,utf8}],
	emysql:add_pool(?MODULE,Params).

get_db_pool() ->
	?MODULE.