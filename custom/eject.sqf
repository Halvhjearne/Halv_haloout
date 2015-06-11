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

player addAction [localize "STR_HALO_OPEN_CHUTE",{player removeAction (_this select 2);HALV_openchute = true;}];

waitUntil{!isNil "HALV_openchute"};
HALV_openchute = nil;

private ["_pos","_para"];

_pos = getPosATL player;

if (_pos select 2 < 10) then{
	_para = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "FLY"];
	_para setPosATL _pos;
	_para setDir getDir player;
}else{
	_para = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
	_para setPosATL _pos;
	_para setDir getDir player;
};

_para disableCollisionWith player;
player moveInDriver _para;
_para setVelocity [0,0,0];

waitUntil {isTouchingGround player || !alive player};

if (!isNull _para) then{
	_para setVelocity [0,0,0];
	sleep 0.5;
	if (vehicle player == _para) then { moveOut player };
	sleep 1.5;
	deleteVehicle _para;
};