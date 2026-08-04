/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


draw_set_halign(fa_center);

var _gui_w = display_get_gui_width();
var _zombie_count = instance_number(obj_zombie);
var _text_counter = string(_zombie_count);
var _text_final = string_repeat("0", 2 - string_length(_text_counter)) + _text_counter;

draw_set_font(fnt_subject);

draw_text_outline_shadow(_gui_w / 2, 30, "SUBJECT #01", 5, 0, 7);

draw_set_font(fnt_counter);

draw_sprite_ext(spr_zombie_count, 0, (_gui_w / 2) - 60, 80, 3, 3, 0, c_white, 1);
draw_text_outline_shadow(_gui_w / 2, 80, _text_final, 3, 0, 5);
