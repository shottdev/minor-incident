/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


image_yscale = lerp(image_yscale, targ_yscale, .1);

if (image_yscale == targ_yscale && !instance_exists(obj_return_button))
{
	var _button = instance_create_layer(x, y + (sprite_height / 2) - 25, "final_results", obj_return_button);
	_button.image_blend = make_colour_rgb(220, 50, 0);
}