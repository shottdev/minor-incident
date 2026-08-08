/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_sprite_ext(spr_essence, 0, 30, 30, 3, 3, 0, c_white, 1);

draw_set_font(fnt_counter);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);

draw_text_outline_shadow(50, 30, global.essences, 3, 0, 5);

draw_set_valign(fa_none);
draw_set_halign(fa_none);
draw_set_font(-1);



//desenhar dica

var _bxscale = 8;
var _byscale = 5;

var _text = "Lembre-se, para coletar essências, basta passar o mouse perto delas!";
var _marg = 15;

var _w = display_get_gui_width();
var _h = display_get_gui_height();

var _bxscale_total = sprite_get_width(spr_textbox) * _bxscale;
var _byscale_total = sprite_get_height(spr_textbox) * _byscale;

draw_sprite_ext(spr_textbox, 0, _w - (_bxscale_total / 2) - _marg, _marg + (_byscale_total), _bxscale, _byscale, 0, c_white, 1);

draw_set_font(fnt_upgrades);

draw_text_ext(_w - _bxscale_total, (_marg * 2), _text, 20, _bxscale_total - (_marg * 2));

draw_set_font(-1);