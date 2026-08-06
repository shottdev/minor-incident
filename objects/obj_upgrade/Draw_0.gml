/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (upg_info.active == false) exit;


draw_set_font(fnt_upgrades);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (instance_exists(parent_upg))
{
	var _dir = point_direction(parent_upg.x, parent_upg.y, x, y);
	
	var _x1 = parent_upg.x + lengthdir_x(13 * parent_upg.image_xscale, _dir);
	var _y1 = parent_upg.y + lengthdir_y(13 * parent_upg.image_yscale, _dir);
	
	var _x2 = parent_upg.x + lengthdir_x(line_size, _dir);
	var _y2 = parent_upg.y + lengthdir_y(line_size, _dir);
	
	draw_line_width(_x1, _y1, _x2, _y2, 4);
}

if (upg_info.level < upg_info.max_level)
{
	draw_text_transformed_outline_shadow(x, y + 23, string("{0}/{1}", upg_info.level, upg_info.max_level), .4, .4, 0, 1, 0, 1.5);
}
else
{
	draw_set_colour(c_yellow);
	draw_text_transformed_outline_shadow(x, y + 23, "MAX!", .4, .4, 0, 1, 0, 1.5);
	draw_set_colour(c_white);
}

draw_set_halign(fa_none);
draw_set_valign(fa_none);
draw_set_font(-1);

draw_sprite_ext(upg_info.sprite, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

