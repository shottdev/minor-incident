/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

randomise();

if (global.subject < 20) global.subject++;

if (global.subject > 0 && global.subject < 6)
{
	spawn_humans(40);
}
else if (global.subject > 5 && global.subject < 11)
{
	spawn_humans(50, 1)
}
else if (global.subject > 10 && global.subject < 16)
{
	spawn_humans(50, 2, 1);
}
else if (global.subject > 15 && global.subject < 21)
{
	spawn_humans(55, 4, 2);
}

game_time = 30 * FPS;

global.paused = false;