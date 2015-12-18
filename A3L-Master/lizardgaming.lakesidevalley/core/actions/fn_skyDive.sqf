#include <macro.h>
/*
	File: fn_skyDive.sqf
	Author: blaster
	Edited By: Jamal Macklemore
	Taken From: http://www.altisliferpg.com/topic/9847-script-sky-diving-with-colored-smoke/
*/
private ["_num","_color","_backpackName","_backpackItems","_x"];

titleCut ["", "BLACK FADED", 999];

life_action_inUse = true;
sleep 2;

_backpackName = backpack player;
_backpackItems = backpackItems player;
sleep 1;

removeBackpack player;
player addBackpack "B_Parachute"; 
player setPos [getPos player select 0, getPos player select 1, 2000]; //2000 m. up
sleep 2;

titlecut [" ","BLACK IN",3]; 

waitUntil {(vehicle player != player)};	
	

	_num = floor(random 7);

	_color = switch (_num) do {
		case 0: {"SmokeShell";};
		case 1: {"SmokeShellGreen";};
		case 2: {"SmokeShellRed";};
		case 3: {"SmokeShellBlue";};
		case 4: {"SmokeShellOrange";};
		case 5: {"SmokeShellYellow";};
		case 6: {"SmokeShellPurple";};
		case 7: {"SmokeShell";};
	};

	_smoke = _color createVehicle position player;
    _smoke attachTo [vehicle player, [0,-0.1,1.5]];

waitUntil {isTouchingGround player};
	sleep 1;
	
	removeBackpack player;
	sleep 1;
	
	player addBackpack _backpackName;
	clearBackpackCargo player;
	{
		[_x,true,true] call life_fnc_handleItem;
	} foreach _backpackItems;


life_action_inUse = false; 