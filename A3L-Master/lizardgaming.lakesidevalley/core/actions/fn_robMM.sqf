/*
MORRISON MARKET| Creds to MrKraken
*/
private["_robber","_shop","_timer","_funds","_dist","_success"]; 
_shop = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_robber = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param; 
_action = [_this,2] call BIS_fnc_param;
_timer = 240;
_funds = 15000 + round(random 25000);  
_dist = _robber distance _shop;
_success = false;

if(side _robber != civilian) exitWith { hint "You are not civilian!"; };

_cops = (west countSide playableUnits);
if(_cops < 4) exitWith { hint "My Register is locked until more Police are on Duty! (4+)"; }; 

if(vehicle player != _robber) exitWith { hint "You need to exit your vehicle!"; }; 
if (alive _robber && {currentWeapon _robber != ""} && {_funds > 0}) then {

[[1,format["911 DISPATCH: Morrison Market has unknown armed suspects!",_storename]],"life_fnc_broadcast",west,false] spawn life_fnc_MP;
hint format ["Robbing the Store! Wait %1 sec.",_timer];

_shop removeAction _action;//Deleting the action,so it won't be spammed


_shop say3D "RobAlarm";


while {true} do {
		hintsilent format ["%1 seconds remaining.",_timer];
		sleep 1;
		_timer = _timer - 1;
		_dist = _robber distance _shop;

		if (!alive _robber) exitwith
			{
				[[1,format["911 DISPATCH: ONE ASSAILANT HAS DIED: Morrison Market",_storename]],"life_fnc_broadcast",west,false] spawn life_fnc_MP;
				hint "STORE CLERK: Oh damn, you just got blood on my cash register.";
				sleep 300;
				_action = _shop addAction["Rob Market",life_fnc_robShops];
			};
			if (_dist >= 6) exitwith {
			[[1,format["911 DISPATCH: ONE ASSAILANT HAS FLED: Morrison Market",_storename]],"life_fnc_broadcast",west,false] spawn life_fnc_MP;
			hint "STORE CLERK: Thank you for letting me go!";
			sleep 300;
			_action = _shop addAction["Rob Market",life_fnc_robShops];
			};
			
if(_timer < 1) exitWith { _success = true; }; //Finishes robbery when timer hits zero
};
if(!_success) exitWith { }; //Stops Message
life_cash = life_cash + _funds; //Self explanatory
hint format["You have stolen $%1",_funds]; //BANK!!!!!
[[getPlayerUID _robber,name _robber,"211"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;//Add the robber to the wanted list

[[1,format["BEAKING NEWS!: Robbers at Morrison Market got away with $%2", _shop, [_funds] call life_fnc_numberText]],"life_fnc_broadcast",civilian,false] spawn life_fnc_MP;
_funds = 0;
life_use_atm = false;
sleep 180;
life_use_atm = true;
sleep 900;//Cooldown between the robberies
_action = _shop addAction["Rob Market",life_fnc_robMM];//Adding action for the robbery
};