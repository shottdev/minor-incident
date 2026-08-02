/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomise();

velh = 0;
velv = 0;
vel = 1;

change_delay = random_range(FPS, FPS * 2);
change_timer = 0;

colliders = [obj_wall, obj_human];

infected = false;

dir = random(359);

state = noone;

walking_state = function()
{
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (place_meeting(x + velh, y, colliders))
	{
		state = idle_state;
		change_delay = (game_get_speed(gamespeed_fps) / 3);
	}
	else
	{
		x += velh;
	}
	
	if (place_meeting(x, y + velv, colliders))
	{
		state = idle_state;
		change_delay = (game_get_speed(gamespeed_fps) / 3);
	}
	else
	{
		y += velv;
	}
		
	change_timer++;
	
	if (change_timer >= change_delay)
	{
		state = choose(walking_state, idle_state);
		change_timer = 0;
		change_delay = random_range((game_get_speed(gamespeed_fps) / 2), (game_get_speed(gamespeed_fps) * 2));
	}
	
	if (!infected)
	{
		if (instance_exists(obj_zombie))
		{
			var _zombie = instance_nearest(x, y, obj_zombie);
	
			if (point_distance(x, y, _zombie.x, _zombie.y) < 30)
			{
				dir = point_direction(x, y, _zombie.x, _zombie.y) + 180;
				state = running_state;
			}
		}
	}
}

idle_state = function()
{
	change_timer++;
	
	if (change_timer >= change_delay && !infected)
	{
		state = choose(walking_state, idle_state);
		change_timer = 0;
		dir = random(359);
		change_delay = random_range((game_get_speed(gamespeed_fps) / 2), (game_get_speed(gamespeed_fps) * 2));
	}
	
	if (!infected)
	{
		if (instance_exists(obj_zombie))
		{
			var _zombie = instance_nearest(x, y, obj_zombie);
	
			if (point_distance(x, y, _zombie.x, _zombie.y) < 30)
			{
				dir = point_direction(x, y, _zombie.x, _zombie.y) + 180;
				state = running_state;
			}
		}
	}
}

running_state = function()
{
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (place_meeting(x + velh, y, colliders))
	{
		dir += choose(-45, 45);
	}
	else
	{
		x += velh;
	}
	
	if (place_meeting(x, y + velv, colliders))
	{
		dir += choose(-45, 45);
	}
	else
	{
		y += velv;
	}
	
	if (instance_exists(obj_zombie))
	{
		var _zombie = instance_nearest(x, y, obj_zombie);
	
		if (point_distance(x, y, _zombie.x, _zombie.y) > 120)
		{
			state = idle_state;
		}
	}
	
	if (infected)
	{
		state = idle_state;
	}
}

state = idle_state;