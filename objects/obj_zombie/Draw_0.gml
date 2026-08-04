/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_sprite(spr_shadow, 0, x, y);
draw_self();

if (shirt_color != noone)
{
	draw_sprite_ext(shirt_sprite, 0, x, y, image_xscale, image_yscale, image_angle, shirt_color, image_alpha);
}
else
{
	draw_sprite_ext(shirt_sprite, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}