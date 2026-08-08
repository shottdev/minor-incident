/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


draw_self();

if (image_yscale < targ_yscale) exit;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_counter);

var _marg = 15;

draw_set_colour(c_red);
draw_text_transformed(x, y - (sprite_height / 2) + _marg, "SUBJECT TERMINATED", .5, .5, 0);
draw_set_colour(c_white);

draw_sprite_ext(spr_zombie_count, 0, x - 23, y - 15, 1.8, 1.8, 0, c_white, 1);
draw_set_halign(fa_left);

var _string_counter = string(instance_number(obj_zombie));
draw_text_transformed_outline_shadow(x + 5, y - 10, string_repeat("0", 2 - string_length(_string_counter)) + _string_counter, .7, .7, 0, 2, 0, 3);

draw_set_halign(fa_center);



draw_set_font(-1);
draw_set_halign(fa_none);
draw_set_valign(fa_none);