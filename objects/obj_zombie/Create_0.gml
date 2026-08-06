/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

swing_init();

velh = 0;
velv = 0;
vel = global.z_speed_list[global.upg_speed.level];

target = noone;

change_delay = FPS / 1.5;
change_timer = 0;

hunt_time = FPS * 4;

state = noone;

colliders = [obj_wall];

dir = 0;

shirt_color = make_colour_rgb(38, 121, 255);
shirt_sprite = spr_zombie_shirt;

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
				change_delay = FPS / 2;
				hunt_time = FPS * 5;
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
						change_delay = FPS;
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
		//seto ele
		target = instance_nearest_with_value(x, y, obj_human, "infected", false);
		
		if (target == noone)
		{
			state = idle_state;
		}
	}
}

idle_state = function()
{
	change_timer++;
	
	velh = 0;
	velv = 0;
	
	if (change_timer >= change_delay)
	{
		change_timer = 0;
		state = hunting_state;
		hunt_time = FPS * 5;
	}
}

state = idle_state;