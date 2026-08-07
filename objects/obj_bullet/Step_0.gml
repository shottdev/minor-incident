/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.paused)
{
	exit;
}

x += lengthdir_x(vel, dir);
y += lengthdir_y(vel, dir);

if (vel > 3.5)
{
	vel -= 0.0005;
}