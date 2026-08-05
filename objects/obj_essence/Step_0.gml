/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.paused)
{
	exit;
}

if (vel > 0 && !picked)
{
	vel -= 0.05;
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
}

if (picked)
{
	dir = point_direction(x, y, 10, 10);
	
	vel = lerp(vel, 10, .1)
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (point_distance(x, y, 10, 10) <= 15)
	{
		instance_destroy();
		global.essences++;
	}
}

if (point_distance(x, y, mouse_x, mouse_y) <= 15)
{
	picked = true;
}

if (x < 0 or x > room_width or y < 0 or y > room_height)
{
	picked = true;
}

x += velh;
y += velv;