/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.paused)
{
	exit;
}

x += lengthdir_x(vel, dir);
y += lengthdir_y(vel, dir);

y += 1;

image_xscale = scale;
image_yscale = scale;

if (scale > 0)
{
	scale -= 0.05;
}