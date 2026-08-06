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