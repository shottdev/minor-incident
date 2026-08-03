// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//criei essa bosta desse macro pq já tava cansado de escrever, to bravo mesmo
#macro FPS game_get_speed(gamespeed_fps)

global.paused = false;

function instance_nearest_with_value(_x, _y, _obj, _var_name, _value)
{
	var _instances = [];
	
	with (_obj)
	{
		var _var = variable_instance_get(id, _var_name);
		
		if (_var == _value)
		{
			array_push(_instances, self);
		}
	}
	
	var _nearest = noone;
	var _shortest_distance = 9999999;
	
	for (var i = 0; i < array_length(_instances); i++)
	{
		var _distance = point_distance(_x, _y, _instances[i].x, _instances[i].y);
		if (_distance < _shortest_distance)
		{
			_shortest_distance = _distance;
			_nearest = _instances[i];
		}
	}
	
	//retorno o id da intancia mais proxima com a variavel
	return _nearest;
}

function swing_init()
{
	walk_wave = 0;
}

function swing(_velh, _velv)
{
	if (_velh != 0 or _velv != 0)
	{
		walk_wave += 0.15;
		
		image_angle = sin(walk_wave) * 5;
		
		image_yscale = 1 + sin(walk_wave + 90) * 0.08;
	}
	else
	{
		image_angle = lerp(image_angle, 0, .1);
		image_yscale = lerp(image_yscale, 1, .1);
	}
}