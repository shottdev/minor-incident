/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (!upg_info.active) exit;

draw_set_font(fnt_upgrades);
var _mouse_in = position_meeting(mouse_x, mouse_y, id);

var _mouse_x = device_mouse_x_to_gui(0);
var _mouse_y = device_mouse_y_to_gui(0);

var _title_scale = .7;
var _desc_scale = .5;
var _cost_scale = .6;
var _margin = 10;

var _max_desc_width = 180;
var _title_width = string_width(upg_info.title) * _title_scale;

var _bwidth = max(_title_width, _max_desc_width) + (_margin * 2);

var _desc_width = (_bwidth - (_margin * 2)) / _desc_scale;

var _desc_height = string_height_ext(upg_info.desc, 17, _desc_width) * _desc_scale;
var _title_height = string_height(upg_info.title) * _title_scale;
var _cost_height = noone;

if (upg_info.level < upg_info.max_level)
{
	_cost_height = string_height(upg_info.cost_list[upg_info.level]) * _cost_scale;
}
else
{
	_cost_height = string_height("MAX!") * _cost_scale;
}

var _bheight = _desc_height + _title_height + _cost_height + (_margin * 4);

var _bxscale = _bwidth / sprite_get_width(spr_textbox);
var _byscale = _bheight / sprite_get_height(spr_textbox);

if (_mouse_in)
{
	draw_sprite_ext(spr_textbox, 0, _mouse_x, _mouse_y - 10, _bxscale, _byscale, 0, c_white, 1);
	
	var _draw_x = _mouse_x - (_bwidth / 2) + _margin;
	var _draw_y = _mouse_y - _bheight;
	
	draw_text_transformed(_draw_x, _draw_y, upg_info.title, _title_scale, _title_scale, 0);
	
	_draw_y += string_height("A") * _title_scale + 6;
	
	draw_text_ext_transformed(_draw_x, _draw_y, upg_info.desc, 17, _desc_width, _desc_scale, _desc_scale, 0);
	
	_draw_y += _desc_height + _margin;
	
	draw_sprite_ext(spr_essence, 0, _draw_x + 5, _draw_y + 5, 2, 2, 0, c_white, 1);
	
	_draw_x += (sprite_get_width(spr_essence) * 2);
	
	if (upg_info.level < upg_info.max_level)
	{
		if (global.essences >= upg_info.cost_list[upg_info.level])
		{
			draw_set_colour(c_lime);
		}
		else
		{
			draw_set_colour(c_red);
		}
		draw_text_transformed(_draw_x, _draw_y, upg_info.cost_list[upg_info.level], _cost_scale, _cost_scale, 0);
		draw_set_colour(c_white);
	}
	else
	{
		draw_set_colour(c_yellow);
		draw_text_transformed(_draw_x, _draw_y, "MAX!", _cost_scale, _cost_scale, 0);
		draw_set_colour(c_white);
	}
}
draw_set_font(-1);