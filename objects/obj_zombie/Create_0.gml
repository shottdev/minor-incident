/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

swing_init();

velh = 0;
velv = 0;
vel = global.z_speed_list[global.upg_speed.level];

target = noone;

change_delay = FPS;
change_timer = 0;

hunt_time = FPS * global.hunt_time_list[global.upg_hunt_time.level];

state = noone;

colliders = [obj_wall];

hp = global.z_life_list[global.upg_life.level];

dir = 0;

kb_velh = 0;
kb_velv = 0;
kb_vel = 0;

kb_dir = 0;

shirt_color = make_colour_rgb(38, 121, 255);
shirt_sprite = spr_zombie_shirt;

check_bullet = function()
{
	var _bullet = instance_place(x, y, obj_bullet);
	
	if (_bullet)
	{
		instance_destroy(_bullet);
		
		hp--;
		
		repeat (15)
		{
			var _part = instance_create_depth(x, y - (sprite_height / 2), depth - 1, obj_blood_part);
			_part.dir = random(359);
			_part.vel = random_range(1, 1.5);
			_part.scale = random_range(.7, 1.3);
		}
		
		pitch(snd_damage, .8, 1.2);
	}
	
	if (hp <= 0)
	{
		instance_destroy();
	}
}

//estado de caça
hunting_state = function()
{
	//se o alvo existe
	if (instance_exists(target))
	{
		//checando se o alvo tá infectado
		if (!target.infected)
		{
			hunt_time--;
			
			dir = point_direction(x, y, target.x, target.y);
			
			velh = lengthdir_x(vel, dir);
			velv = lengthdir_y(vel, dir);
			
			if (place_meeting(x + velh, y, colliders))
			{
				dir += choose(-45, 45);
				//change_delay = FPS / 2;
				//target = noone;
			}
			x += velh;
			
			if (place_meeting(x, y + velv, colliders))
			{
				dir += choose(-45, 45);
				//change_delay = FPS / 2;
				//target = noone;
			}
			y += velv;
			
			if (hunt_time <= 0)
			{
				state = idle_state;
				target = noone;
				change_delay = FPS * global.idle_time_list[global.upg_idle_time.level];
				hunt_time = FPS * global.hunt_time_list[global.upg_hunt_time.level];
			}
			
			if (place_meeting(x, y, obj_human))
			{
				var _human = instance_place(x + velh, y + velv, obj_human)
				
				if (_human != noone)
				{
					if (!_human.infected)
					{
						_human.infected = true;
						state = idle_state;
						change_delay = FPS * global.idle_time_list[global.upg_idle_time.level];
					}
				}
			}
		}
		else
		{
			target = instance_nearest_with_value(x, y, obj_human, "infected", false);
		}
	}
	else //se o alvo não existir
	{
		if (global.upg_estrategism.level > 0)
		{
			var _medic = instance_nearest_medic(x, y);
			
			if (instance_exists(_medic))
			{
				target = _medic;
			}
			else
			{
				target = instance_nearest_with_value(x, y, obj_human, "infected", false);
			}
		}
		else
		{
			target = instance_nearest_with_value(x, y, obj_human, "infected", false);
		}
		
		//se não tiver alvo mesmo depois de tentar setá-lo
		if (target == noone)
		{
			//vou pro estado de idle
			state = idle_state;
		}
	}
	
	//checando se sou pego por uma bala
	check_bullet();
}

//estado de idle
idle_state = function()
{
	change_timer++;
	
	velh = 0;
	velv = 0;
	
	if (change_timer >= change_delay)
	{
		change_timer = 0;
		state = hunting_state;
	}
	
	check_bullet();
}

state = idle_state;