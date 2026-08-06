/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (keyboard_check_pressed(vk_escape))
{
	global.paused = !global.paused;
}

if (global.paused) exit;

if (!layer_sequence_exists("Transition", global.transition))
{
	game_time--;
	
	if (game_time <= 0 && !global.paused)
	{
		global.paused = true;
		
		instance_create_layer(room_width / 2, room_height / 2, "final_results", obj_final_results);
	}
}