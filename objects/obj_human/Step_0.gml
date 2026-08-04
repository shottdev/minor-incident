/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.paused)
{
	exit;
}

state();

if (!infected) swing(velh, velv);

if (profession == HUMAN_MEDIC) show_debug_message(vel);

depth = -y;