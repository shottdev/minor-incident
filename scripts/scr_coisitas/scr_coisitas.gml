// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//criei essa bosta desse macro pq já tava cansado de escrever, to bravo mesmo
#macro FPS game_get_speed(gamespeed_fps)
#macro HUMAN_CIVIL 0
#macro HUMAN_MEDIC 1
#macro HUMAN_COP 2
#macro HUMAN_BASE_VEL 1
#macro HUMAN_RUN_VEL 1.3
#macro HUMAN_MEDIC_RUNNING_VEL 1.6

global.paused = false;
global.subject = 0;
global.essences = 0;

global.in_transition = false;
global.next_room = noone;
global.transition_state = noone;

global.transition = noone;

global.fullscreen = false;

global.master_gain = 1;
global.music_gain = 1;
global.sfx_gain = .7;
global.music = noone;

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

function instance_nearest_medic(_x, _y)
{
	var _instances = [];
	
	with (obj_human)
	{		
		if (!infected && profession == HUMAN_MEDIC)
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

function spawn_humans(_amount, _medics = 0, _cops = 0)
{
	var _center_x = room_width / 2;
	var _center_y = room_height / 2;
	
	var _professions = []
	
	for (var i = 0; i < _amount - _medics - _cops; i++)
	{
		array_push(_professions, HUMAN_CIVIL);
	}
	
	for (var i = 0; i < _medics; i++)
	{
		array_push(_professions, HUMAN_MEDIC);
	}
	
	for (var i = 0; i < _cops; i++)
	{
		array_push(_professions, HUMAN_COP);
	}
	
	array_shuffle(_professions);
	
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

function pitch(_soundid, _min, _max)
{
	audio_play_sound(_soundid, 0, false, global.master_gain * global.sfx_gain, 0, random_range(_min, _max));
}

function go_to_room()
{
	global.transition_state = 2;
	global.transition = noone;
	global.paused = false;
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

function onoff(_value)
{
	switch (_value)
	{
		case true:
		{
			return "ON";
		}
		
		case false:
		{
			return "OFF";
		}
	}
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
[10, 20],
0,
false,
1,
2);

global.z_speed_list = [0.8, 0.9, 1.0];

global.upg_essences = new upgrade(
spr_upg_essences,
"Sacrifício Valorizado",
"Aumenta o número de essências dropadas dos humanos",
[5],
0,
false,
1,
1);

global.essence_amount_list = [1, 2];

global.upg_magnetism = new upgrade(
spr_upg_magnetism,
"Coleta Magnética",
"Aumenta o raio de distância necessário pra coletar os upgrades",
[15, 20, 25],
0,
false,
2,
3);

global.essence_magnetism_list = [15, 20, 30, 45];

global.upg_infec_time = new upgrade(
spr_upg_infec_time,
"Mordida Profunda",
"Diminui o tempo pra um humano se tornar zumbi após ser infectado",
[35],
0,
false,
1,
1);

global.infec_sec_list = [5, 4.5];

global.upg_hunt_time = new upgrade(
spr_upg_hunt_time,
"Ferozmente Determinado",
"Aumenta o tempo de perseguição do zumbi antes de desistir de um alvo",
[15, 30],
0,
false,
1,
2);

global.hunt_time_list = [4, 5, 6];

global.upg_idle_time = new upgrade(
spr_upg_idle_time,
"Reativação Imediata",
"Diminui o tempo que os zumbis ficam parados antes de voltar a caçar",
[25, 35, 50],
0,
false,
2,
3);

global.idle_time_list = [1, .8, .6, .3];

global.upg_life = new upgrade(
spr_upg_life,
"Tecido Reforçado",
"Aumenta a vida dos zumbis",
[20, 30],
0,
false,
1,
2);

global.z_life_list = [1, 2, 3];

global.upg_notice_dist = new upgrade(
spr_upg_notice_dist,
"Modo Camaleão",
"Diminui a distância necessária pros humanos perceberem a presença de um zumbi",
[15, 25, 45],
0,
false,
2,
3);

global.notice_dist_list = [60, 55, 45, 30];

global.upg_safe_dist = new upgrade(
spr_upg_safe_dist,
"Limiar do Pânico",
"Diminui a distância em que os humanos se sentem seguros",
[25, 35, 45],
0,
false,
2,
3);

global.safe_dist_list = [140, 130, 100, 80];

global.upg_essences_bonus = new upgrade(
spr_upg_essences_bonus,
"Excedente do Sacrifício",
"Aumenta ainda mais o número de essências dropadas pelos humanos",
[30],
0,
false,
1,
1);

global.upg_essence_speed = new upgrade(
spr_upg_essence_speed,
"Extração Acelerada",
"Aumenta a velocidade que as essências são coletadas",
[25, 30, 40],
0,
false,
1,
3);

global.essence_speed_list = [8, 10, 12, 14];

global.upg_bullets = new upgrade(
spr_upg_bullets,
"Escassez de Recursos",
"Diminui o número de balas do policial",
[25, 30],
0,
false,
1,
2);

global.bullets_list = [5, 4, 3];

global.upg_estrategism = new upgrade(
spr_upg_estrategism,
"Estrategismo",
"Agora os zumbis caçam os médicos mais próximos primeiro",
[55],
0,
false,
1,
1);