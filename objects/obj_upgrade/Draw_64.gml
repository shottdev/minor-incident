/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (!active) exit;

var _mouse_in = position_meeting(mouse_x, mouse_y, id);

var _mouse_x = device_mouse_x_to_gui(0);
var _mouse_y = device_mouse_y_to_gui(0);

if (_mouse_in)
{
	draw_sprite_ext(spr_textbox, 0, _mouse_x, _mouse_y - 10, 5, 2.5, 0, c_white, 1);
}