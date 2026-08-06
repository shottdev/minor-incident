/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (global.in_transition && global.transition == noone)
{
	switch (global.transition_state)
	{
		case 1:
		{
			global.transition = layer_sequence_create("Transition", 0, 0, sq_transition1)
		}
		break;
		case 2:
		{
			global.transition = layer_sequence_create("Transition", 0, 0, sq_transition2)
		}
	}
}