/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


velh = 0;
velv = 0;
vel = 1;

target = noone;

state = noone;

dir = 0;

//estado de caça
hunting_state = function()
{
	//se o alvo existe
	if (instance_exists(target))
	{
		//checando se o alvo tá infectado
		if (!target.infected)
		{
			dir = point_direction(x, y, target.x, target.y);
			
			velh = lengthdir_x(vel, dir);
			velv = lengthdir_y(vel, dir);
			
			move_and_collide(velh, 0, obj_wall);
			move_and_collide(0, velv, obj_wall);
			
			if (place_meeting(x + velh, y + velv, target))
			{
				target.infected = true;
			}
		}
		else
		{
			
		}
	}
	else //se o alvo não existir
	{
		//seto ele
		target = instance_nearest(x, y, obj_human);
	}
}

state = hunting_state;