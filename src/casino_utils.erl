-module(casino_utils).

-export([now/0]).

now()->
	Now=os:timestamp(),
	{Mega, Sec, Micro}=Now,
	Mills=Mega * 1000000 * 1000000 + Sec * 1000000 + Micro,
	{Mills,Now}.