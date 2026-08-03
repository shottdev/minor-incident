/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (global.paused)
{
	exit;
}

x += lengthdir_x(vel, dir);
y += lengthdir_y(vel, dir);

dir += 1;
image_xscale -= 0.05;
image_yscale -= 0.05;

if (image_xscale <= 0 and image_yscale <= 0)
{
	instance_destroy();
}