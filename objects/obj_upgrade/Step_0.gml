/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var _mouse_in = position_meeting(mouse_x, mouse_y, id);
var _mouse_click = mouse_check_button_pressed(mb_left);

parent_upg = upg_info.parent_id;

if (instance_exists(parent_upg))
{
	var _ideal_size = point_distance(x, y, parent_upg.x, parent_upg.y);
	
	line_size = lerp(line_size, _ideal_size, .2);
}

if (_mouse_in)
{
	if (_mouse_click)
	{
		if (upg_info.level < upg_info.max_level)
		{
			if (global.essences >= upg_info.cost_list[upg_info.level])
			{
				var _qtd = array_length(targets);
			
				global.essences -= upg_info.cost_list[upg_info.level];
				upg_info.level++;
			
				if (_qtd > 0 && upg_info.level >= upg_info.min_level)
				{
					for (var i = 0; i < _qtd; i++)
					{
						var _index = targets[i];
				
						if (!_index.upg_info.active)
						{
							_index.upg_info.active = true;
							_index.image_angle = 360;
							_index.upg_info.parent_id = id;
							
							repeat (10)
							{
								var _part = instance_create_depth(_index.x, _index.y, depth - 2, obj_part);
								_part.dir = random(359);
								var _scale = random_range(1.4, 2.2);
								_part.image_xscale = _scale;
								_part.image_yscale = _scale;
								_part.vel = random_range(1.2, 2);
							}
						}
					}
				}
				pitch(snd_upgrade, .6, 1.4);
			}
			else
			{
				pitch(snd_upgrade_blocked, .7, 1.3);	
			}
		}
		
		
	}
	
	tween(id, "image_xscale", 1.4, tween_animation.expo_out);
	tween(id, "image_yscale", 1.4, tween_animation.expo_out);
}
else
{
	tween(id, "image_xscale", 1, tween_animation.elastic_out);
	tween(id, "image_yscale", 1, tween_animation.elastic_out);
}

tween(id, "image_angle", 0, tween_animation.expo_out);

if (upg_info.level < upg_info.max_level)
{
	if (global.essences < upg_info.cost_list[upg_info.level])
	{
		image_blend = make_colour_rgb(120, 120, 120)
	}
	else
	{
		image_blend = c_white;
	}
}
else
{
	image_blend = c_white;
}

if (upg_info.level == upg_info.max_level)
{
	line_color = c_yellow;
}
else
{
	line_color = c_white;
}