/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


draw_set_halign(fa_center);

var _gui_w = display_get_gui_width();
var _zombie_count = instance_number(obj_zombie);
var _text_counter = string(_zombie_count);
var _text_final = string_repeat("0", 2 - string_length(_text_counter)) + _text_counter;

var _subject = string(global.subject);
var _text_subject = string_repeat("0", 2 - string_length(_subject)) + _subject;

var _timer = game_time / FPS;
var _timer_formatted = string_format(_timer, 2, 0);
var _timer_final = string_repeat("0", 2 - string_length(_timer_formatted)) + _timer_formatted;

draw_set_font(fnt_subject);

draw_text_outline_shadow(_gui_w / 2, 30, "SUBJECT #" + _text_subject, 5, 0, 7);

draw_set_font(fnt_counter);

draw_sprite_ext(spr_zombie_count, 0, (_gui_w / 2) - 60, 80, 3, 3, 0, c_white, 1);
draw_text_outline_shadow(_gui_w / 2, 80, _text_final, 3, 0, 5);
draw_sprite_ext(spr_clock, 0, (_gui_w / 2) - 40, 117, 3, 3, 0, c_white, 1);
draw_text_outline_shadow(_gui_w / 2, 110, _timer_final + "s", 3, 0, 5);

draw_sprite_ext(spr_essence, 0, 30, 30, 3, 3, 0, c_white, 1);

draw_set_valign(fa_middle);
draw_set_halign(fa_left);

draw_text_outline_shadow(50, 30, global.essences, 3, 0, 5);

draw_set_valign(fa_none);
draw_set_halign(fa_none);

draw_set_font(-1);
