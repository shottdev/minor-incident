/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(fnt_upgrades);

draw_text_transformed(x, y, "Menu", 0.5 * image_xscale, 0.5 * image_yscale, image_angle);

draw_set_font(-1);
draw_set_valign(fa_none);
draw_set_halign(fa_none);