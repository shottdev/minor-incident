/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_sprite(spr_shadow, 0, x, y);
draw_self();
colorise_draw(sprite_index);

switch (profession)
{
	case HUMAN_CIVIL:
	{
		draw_sprite_ext(spr_human_shirt, 0, x, y, image_xscale, image_yscale, image_angle, shirt_color, image_alpha);
		colorise_draw(spr_human_shirt);
	}
	break;
	case HUMAN_MEDIC:
	{
		draw_sprite_ext(spr_medic_shirt, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
		colorise_draw(spr_medic_shirt);
	}
	break;
	case HUMAN_COP:
	{
		draw_sprite_ext(spr_cop_cloth, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
		colorise_draw(spr_cop_cloth);
	}
}

if (profession == HUMAN_COP && state == shooting_state)
{
	if (instance_exists(obj_zombie))
	{
		var _zombie = instance_nearest(x, y, obj_zombie);
		var _dir = point_direction(x, y, _zombie.x, _zombie.y);
		draw_sprite_ext(spr_pistol, 0, x, y - (sprite_height / 2), 1, 1, _dir, c_white, 1);
	}
}