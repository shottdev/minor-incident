/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomise();

swing_init();

shirt_color = choose(
make_colour_rgb(255, 103, 15), 
make_colour_rgb(0, 163, 5),
c_red,
make_colour_rgb(38, 121, 255),
c_yellow
);

velh = 0;
velv = 0;
vel = 1;

colorise_init();

colorise_alpha = 0;

change_delay = random_range(FPS, FPS * 2);
change_timer = 0;

colliders = [obj_wall, obj_human];

infected = false;
infection_seconds = 5;
infection_time = FPS * infection_seconds;

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
	
			if (point_distance(x, y, _zombie.x, _zombie.y) < 50)
			{
				dir = point_direction(x, y, _zombie.x, _zombie.y) + 180;
				state = running_state;
			}
		}
	}
	
	if (infected)
	{
		state = infected_state;
	}
}

idle_state = function()
{
	change_timer++;
	velh = 0;
	velv = 0;
	
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
	
			if (point_distance(x, y, _zombie.x, _zombie.y) < 50)
			{
				dir = point_direction(x, y, _zombie.x, _zombie.y) + 180;
				state = running_state;
			}
		}
	}
	
	if (infected)
	{
		state = infected_state;
	}
}

running_state = function()
{
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (vel > 0.4)
	{
		vel -= 0.005;
	}
	
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
		state = infected_state;
	}
}

infected_state = function()
{
	if (image_angle != 0)
	{
		image_angle = lerp(image_angle, 0, .1);
	}
	
	infection_time--;
	velh = 0;
	velv = 0;
	
	var _value_alpha = 1 / (infection_seconds * FPS);
	var _value_yscale = (1 - 0.6) / (infection_seconds * FPS);
	
	colorise_alpha += _value_alpha;
	image_yscale -= _value_yscale;
	
	colorise_apply(, colorise_alpha);
	
	if (infection_time <= 0)
	{
		instance_destroy();
		instance_create_layer(x, y, "zombies", obj_zombie);
		
		repeat (10)
		{
			var _part = instance_create_layer(x, y - (sprite_height / 2), "particles", obj_part);
			_part.dir = random(359);
			_part.vel = random_range(1, 2);
			var _scale = random_range(1, 2.5);
			_part.image_xscale = _scale;
			_part.image_yscale = _scale;
		}
	}
}

state = idle_state;