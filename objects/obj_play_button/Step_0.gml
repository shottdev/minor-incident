/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var _mouse_in = position_meeting(mouse_x, mouse_y, id);
var _mouse_click = mouse_check_button_pressed(mb_left);

if (_mouse_in)
{
	tween(id, "image_xscale", 1.3, tween_animation.expo_out);
	tween(id, "image_yscale", 1.3, tween_animation.expo_out);
	
	if (_mouse_click)
	{
		tween(id, "image_angle", 20, tween_animation.elastic_out);
		
		global.in_transition = true;
		global.transition_state = 1;
		global.next_room = rm_game;
	}
}
else
{
	tween(id, "image_xscale", 1, tween_animation.expo_out);
	tween(id, "image_yscale", 1, tween_animation.expo_out);
}

if (image_angle > 19)
{
	tween(id, "image_angle", 0, tween_animation.elastic_out);
}