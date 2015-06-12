/*
	halo from vehicles
	by Halv
*/

_id = _this select 2;
_vehicle = _this select 3;
_vehicle removeAction _id;

if(player == driver _vehicle)exitWith{titleText["Cant HALO Jump as pilot ...","PLAIN DOWN"];};

moveOut player;
waitUntil{player != _vehicle};

sleep 1;

_action = player addAction [localize "STR_HALO_OPEN_CHUTE",{HALV_openchute = true;}];

waitUntil{sleep 1;(!isNil "HALV_openchute" || (getPosATL player)select 2 <= 10)};
player removeAction _action;
HALV_openchute = nil;

private "_chute";

_pos = getPosATL player;

if (_pos select 2 < 10) then{
	_chute = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "FLY"];
	_chute setPosATL _pos;
	_chute setDir getDir player;
}else{
	_chute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
	_chute setPosATL _pos;
	_chute setDir getDir player;
};

_chute disableCollisionWith player;
player moveInDriver _chute;
_chute setVelocity [0,0,0];

waitUntil {isTouchingGround player || !alive player};

if (!isNull _chute) then{
	_chute setVelocity [0,0,0];
	sleep 0.5;
	if (vehicle player == _chute) then { moveOut player };
	sleep 1.5;
	deleteVehicle _chute;
};