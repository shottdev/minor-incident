/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//iniciando o efeito swing (game feel pra simular animação de walking)
swing_init();

//decidindo a cor da camisa
shirt_color = choose(
make_colour_rgb(255, 103, 15), 
make_colour_rgb(0, 163, 5),
make_colour_rgb(230, 34, 34),
make_colour_rgb(38, 121, 255),
make_colour_rgb(255, 179, 0),
make_colour_rgb(138, 24, 219)
);

//distancia de notar a presença do zumbi
notice_distance = 50;

//distancia segura do zumbi
safe_distance = 120;

//velocidade horizontal
velh = 0;

//velocidade vertical
velv = 0;

//velocidade geral
vel = 1;

//iniciando o efeito colorise
colorise_init();

image_alpha = 0;
image_yscale = 0.5;
image_xscale = 1.4;

//alpha do efeito
colorise_alpha = 0;

//timer e delay pra mudar de estado
change_delay = random_range(FPS, FPS * 2);
change_timer = 0;

//delay pra curar um infectado (pros médicos)
heal_delay = FPS * 1.3;

//colisores
colliders = [obj_wall];

//delay pra recalcular rota de fuga
repath_timer = FPS / 3;

//checando se estou infectado
infected = false;

//tempo em segundos da infecção
infection_seconds = 5;

//delay da infecção
infection_time = FPS * infection_seconds;

//se eu to sendo ignorado por um médico agora
being_ignored = false;

//tempo ignorado
ignored_timer = 0;

//se eu to marcado por um médico no momento
marked = false;

//id do meu alvo (pros médicos)
target_infected = noone;

//direção que vou andar
dir = random(359);

//estado
state = noone;

//método para achar um infe
find_infected = function()
{
	//procurando o infectado mais próximo (que esteja infectado, não esteja sendo ignorado e que não esteja marcado por outro médico)
	var _nearest_infected = instance_nearest_infected(x, y);
	
	//se meu infectado existe e eu não tenho nenhum alvo
	if (instance_exists(_nearest_infected) && target_infected == noone)
	{
		//se um zumbi existe
		if (instance_exists(obj_zombie))
		{
			//pegando o zumbi mais próximo de mim
			var _zombie = instance_nearest(x, y, obj_zombie);
			
			//se ele estiver longe o suficiente
			if (point_distance(x, y, _zombie.x, _zombie.y) > 80)
			{
				//pego minha direção pro infectado mais próximo
				dir = point_direction(x, y, _nearest_infected.x, _nearest_infected.y);
				
				//vou pro estado de ir curar
				state = going_heal_state;
				
				//seto meu alvo
				target_infected = _nearest_infected;
				
				//dizendo pro meu alvo que ele tá sendo marcado por um médico
				target_infected.marked = true;
			}
		}
	}
}

starting_state = function()
{
	velh = 0;
	velv = 0;
	
	if (image_alpha < 1)
	{
		image_alpha += 0.05;
	}
	else
	{
		if (image_xscale == 1 && image_yscale == 1)
		{
			state = idle_state;
			change_delay = FPS / 3;
		}
		else
		{
			image_xscale = lerp(image_xscale, 1, .2);
			image_yscale = lerp(image_yscale, 1, .2);
		}
	}
}

//estado de andar/passear
walking_state = function()
{
	//pegando a velocidade horizontal com base na direção e velocidade geral
	velh = lengthdir_x(vel, dir);
	
	//pegando a velocidade vertical com base na direção e velocidade geral
	velv = lengthdir_y(vel, dir);
	
	//checando se eu to colidindo com uma parede
	if (place_meeting(x + velh, y, colliders))
	{
		//mudo pro estado de idle
		state = idle_state;
		
		//seto meu delay pra mudar de estado de novo
		change_delay = (game_get_speed(gamespeed_fps) / 3);
	}
	else //se não to encostando em nada
	{
		//aumento minha velh no meu x
		x += velh;
	}
	
	//se eu to colidindo com uma parede (pela vertical)
	if (place_meeting(x, y + velv, colliders))
	{
		//mudo meu estado pro idle
		state = idle_state;
		
		//seto o delay
		change_delay = (game_get_speed(gamespeed_fps) / 3);
	}
	else //se não to colidindo com nada na vertical
	{
		//aumento minha velv no meu y
		y += velv;
	}
	
	//aumento o timer de mudar de estado
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
	
			if (point_distance(x, y, _zombie.x, _zombie.y) <= notice_distance)
			{
				dir = point_direction(x, y, _zombie.x, _zombie.y) + 180;
				state = running_state;
				repath_timer = FPS / 3;
				vel = 1.3;
			}
		}
	}
	
	if (infected)
	{
		state = infected_state;
		image_yscale = 1;
	}
	
	if (profession == HUMAN_MEDIC && !infected)
	{
		find_infected();
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
				dir = point_direction(_zombie.x, _zombie.y, x, y);
				state = running_state;
				repath_timer = FPS / 3;
				vel = 1.3;
			}
		}
	}
	
	if (infected)
	{
		state = infected_state;
		image_yscale = 1;
	}
	
	if (profession == HUMAN_MEDIC && !infected)
	{
		find_infected();
	}
}

running_state = function()
{
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (vel > 0.7)
	{
		vel -= 0.005;
	}
	
	if (place_meeting(x + velh, y, obj_wall))
	{
		dir += choose(-45, 45);
		repath_timer = FPS / 2;
	}
	else
	{
		x += velh;
	}
	
	if (place_meeting(x, y + velv, obj_wall))
	{
		dir += choose(-45, 45);
		repath_timer = FPS / 2;
	}
	else
	{
		y += velv;
	}
	
	if (instance_exists(obj_zombie))
	{
		var _zombie = instance_nearest(x, y, obj_zombie);
	
		if (point_distance(x, y, _zombie.x, _zombie.y) > safe_distance)
		{
			state = idle_state;
			vel = 1;
		}
	}
	
	if (repath_timer > 0)
	{
		repath_timer--;
	}
	else
	{
		var _zombie = instance_nearest(x, y, obj_zombie)
		
		if (instance_exists(_zombie))
		{
			dir = point_direction(_zombie.x, _zombie.y, x, y);
		}
		
		repath_timer = FPS / 3;
	}
	
	if (infected)
	{
		state = infected_state;
		image_yscale = 1;
	}
	
	if (profession == HUMAN_MEDIC && !infected)
	{
		find_infected();
	}
}

going_heal_state = function()
{
	vel = 1.6;
	
	velh = lengthdir_x(vel, dir);
	velv = lengthdir_y(vel, dir);
	
	if (place_meeting(x + velh, y, obj_wall))
	{
		dir += choose(-45, 45);
	}
	else
	{
		x += velh;
	}
	
	if (place_meeting(x, y + velv, obj_wall))
	{
		dir += choose(-45, 45);
	}
	else
	{
		y += velv;
	}
	
	if (instance_exists(target_infected))
	{
		dir = point_direction(x, y, target_infected.x, target_infected.y);
		
		//checando se eu to encostando no infectado
		if (place_meeting(x, y, target_infected))
		{	
			//mudando pro estado de curar
			state = healing_state;
			change_timer = 0;
			vel = 1;
		}
		
		if (point_distance(x, y, target_infected.x, target_infected.y) < safe_distance - 60)
		{
			if (instance_exists(obj_zombie))
			{
			
				var _nearest_zombie = instance_nearest(target_infected.x, target_infected.y, obj_zombie)
			
				if (point_distance(target_infected.x, target_infected.y, _nearest_zombie.x, _nearest_zombie.y) <= 50)
				{
					state = idle_state;
					change_timer = 0;
					vel = 1;
					target_infected.being_ignored = true;
					target_infected.ignored_timer = FPS;
					target_infected.marked = false;
					target_infected = noone;
				}
			}
		}
		
		if (target_infected != noone && target_infected.infection_time < FPS / 1.4)
		{
			state = idle_state;
			change_timer = 0;
			vel = 1;
			target_infected.being_ignored = true;
			target_infected.ignored_timer = FPS;
			target_infected.marked = false;
			target_infected = noone;
		}
	}
	else //se não existe
	{
		//volto pro estado idle
		state = idle_state;
		vel = 1;
	}
	
	if (infected)
	{
		state = infected_state;
		vel = 1;
	}
}

healing_state = function()
{
	change_timer++;
	velh = 0;
	velv = 0;
	
	if (instance_exists(target_infected))
	{
		if (place_meeting(x, y, target_infected))
		{
			if (change_timer >= heal_delay)
			{
				target_infected.infected = false;
				target_infected.infection_time = infection_seconds * FPS;
				state = idle_state;
				change_timer = 0;
				target_infected.marked = false;
				target_infected = noone;
			}
		}
	}
	else
	{
		state = idle_state;
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
	var _value_yscale = (1 - 0.7) / (infection_seconds * FPS);
	var _value_xscale = (1 - 0.3) / (infection_seconds * FPS);
	
	colorise_alpha += _value_alpha;
	image_yscale -= _value_yscale;
	image_xscale += _value_xscale;
	
	colorise_apply(, colorise_alpha);
	
	if (!infected)
	{
		state = idle_state;
		change_delay = FPS / 2;
		colorise_alpha = 0;
		colorise_return(999);
		image_xscale = 1;
		image_yscale = 1;
		
		repeat (10)
		{
			var _part = instance_create_depth(x, y - (sprite_height / 2), depth - 1, obj_part);
			_part.dir = random(359);
			_part.vel = random_range(1, 2);
			var _scale = random_range(1, 2.5);
			_part.image_xscale = _scale;
			_part.image_yscale = _scale;
			_part.image_blend = make_colour_rgb(0, 255, 102);
		}
	}
	
	if (ignored_timer > 0)
	{
		ignored_timer--;
	}
	else
	{
		being_ignored = false;
	}
	
	if (infection_time <= 0)
	{
		instance_destroy();
		var _new_zombie = instance_create_layer(x, y, "zombies", obj_zombie);
		
		switch (profession)
		{
			case HUMAN_CIVIL:
			{
				_new_zombie.shirt_color = shirt_color;
				_new_zombie.shirt_sprite = spr_zombie_shirt;
			}
			break;
			case HUMAN_MEDIC:
			{
				_new_zombie.shirt_color = noone;
				_new_zombie.shirt_sprite = spr_medic_zombie_shirt;
			}
			break;
		}
		
		repeat (10)
		{
			var _part = instance_create_depth(x, y - (sprite_height / 2), depth - 1, obj_part);
			_part.dir = random(359);
			_part.vel = random_range(1, 2);
			var _scale = random_range(1, 2.5);
			_part.image_xscale = _scale;
			_part.image_yscale = _scale;
		}
		
		repeat (global.essence_amount)
		{
			var _essence = instance_create_layer(x, y - (sprite_height / 2), "essences", obj_essence);
			_essence.dir = random(359);
			var _scale = random_range(1, 1.5);
			_essence.image_xscale = _scale;
			_essence.image_yscale = _scale;
		}
	}
}

state = starting_state;