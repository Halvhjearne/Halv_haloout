/*
	halo from vehicles
	by Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

_id = _this select 2;
_vehicle = _this select 3;
_vehicle removeAction _id;

moveOut player;
waitUntil{(!(vehicle player isEqualTo _vehicle) && animationState player == "halofreefall_non")};

sleep 1;
HALV_openchute = false;
_action = player addAction [localize "STR_HALO_OPEN_CHUTE",{HALV_openchute = true;}];

waitUntil{sleep 1;(HALV_openchute || !(alive player) || isTouchingGround player)};

player removeAction _action;

if !(HALV_openchute)exitWith{
	player setDammage 1;
	HALV_openchute = nil;
};

HALV_openchute = nil;

private "_chute";

_pos = getPosATL player;
_pos set [2,(_pos select 2)+2];

if (_pos select 2 < 10) then{
	_chute = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "FLY"];
}else{
	_chute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
};

sleep 0.2;

_chute setDir (getDir player);
_chute setPosATL _pos;
_chute disableCollisionWith player;
player moveInDriver _chute;
_chute setVelocity [0,0,0];
waitUntil{vehicle player isEqualTo _chute};
if (animationState player != "para_pilot") then{
	player switchMove "para_pilot";
};

waitUntil {isTouchingGround player || !alive player};

if (!isNull _chute) then{
	_chute setVelocity [0,0,0];
	sleep 0.5;
	if ((vehicle player) isEqualTo _chute) then { moveOut player };
	sleep 1.5;
	deleteVehicle _chute;
};