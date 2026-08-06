// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//criei essa bosta desse macro pq já tava cansado de escrever, to bravo mesmo
#macro FPS game_get_speed(gamespeed_fps)
#macro HUMAN_CIVIL 0
#macro HUMAN_MEDIC 1
#macro HUMAN_COP 2

global.paused = false;
global.subject = 1;
global.essence_amount = 1;
global.essences = 50;

global.z_speed_list = [0.8, 0.9, 1.0, 1.1];

global.in_transition = false;
global.next_room = noone;
global.transition_state = noone;

global.transition = noone;

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

function instance_nearest_infected(_x, _y)
{
	var _instances = [];
	
	with (obj_human)
	{		
		if (infected && !being_ignored && !marked)
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

function spawn_humans(_amount, _medics = 0)
{
	var _center_x = room_width / 2;
	var _center_y = room_height / 2;
	
	var _professions = []
	
	for (var i = 0; i < _amount - _medics; i++)
	{
		array_push(_professions, HUMAN_CIVIL);
	}
	
	for (var i = 0; i < _medics; i++)
	{
		array_push(_professions, HUMAN_MEDIC);
	}
	
	for (var i = 0; i < _amount; i++)
	{
		var _tries = 100;
		var _margin = 20;
		
		while (_tries > 0)
		{
			var _x = random_range(_margin, room_width - _margin);
			var _y = random_range(_margin, room_height - _margin);
			
			if (point_distance(_x, _y, _center_x, _center_y) >= 180)
			{
				var _human = instance_create_layer(_x, _y, "humans", obj_human);
				_human.profession = _professions[i];
				break;
			}
			
			_tries--;
		}
	}
}

function go_to_room()
{
	global.transition_state = 2;
	global.transition = noone;
	room_goto(global.next_room);
	
	if (instance_exists(obj_final_results))
	{
		instance_destroy(obj_final_results);
	}
	
	if (instance_exists(obj_return_button))
	{
		instance_destroy(obj_return_button);
	}
}

function end_transition()
{
	global.in_transition = false;
	global.transition_state = 0;
	global.next_room = noone;
	
	if (layer_sequence_exists("sq_transition", global.transition))
	{
		layer_sequence_destroy(global.transition);
	}
	
	global.transition = noone;
}

function upgrade(_sprite = spr_upgrade, _title, _desc, _cost_list, _level, _active, _min_level, _max_level, _parent = undefined) constructor
{
	sprite = _sprite;
	title = _title;
	desc = _desc;
	cost_list = _cost_list;
	level = _level;
	active = _active;
	min_level = _min_level;
	max_level = _max_level;
	parent_id = _parent;
}

global.upg_start = new upgrade(
spr_upg_start,
"Protocolo Inicial",
"O começo do experimento",
[0],
0,
true,
1,
1);

global.upg_speed = new upgrade(
spr_upg_speed,
"Metabolismo Acelerado",
"Aumenta a velocidade dos zumbis",
[20, 35, 50],
0,
false,
2,
3);
