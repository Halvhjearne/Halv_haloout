/*
	halo from vehicles
	by Halv
*/

//this is the height (in meters) above ground the player needs to be, before the halo scroll action becomes available. default 250 
_haloheight = 250;

_haloaction = -1;

while{alive player}do{
	_vehicle = vehicle player;
	if(player != _vehicle)then{
		if((getPosATL _vehicle) select 2 > _haloheight && !(_vehicle isKindOf "Parachute_base") && player != driver _vehicle)then{
			if(_haloaction < 0)then{
				_haloaction = _vehicle addAction["<img size='1.5'image='\a3\Ui_f\data\IGUI\Cfg\Actions\eject_ca.paa'/> <t color='#0096ff'>HALO</t><t > </t><t color='#00CC00'>Eject</t>","custom\eject.sqf",_vehicle, -10, true, true, "", ""];
			};
		}else{
			_vehicle removeAction _haloaction;
			_haloaction = -1;
		};
	}else{
		_vehicle removeAction _haloaction;
		_haloaction = -1;
	};
	sleep 1;
};

waitUntil{alive player};

[]execVM __FILE__;
