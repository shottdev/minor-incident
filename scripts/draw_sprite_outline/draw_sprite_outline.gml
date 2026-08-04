// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

/// Draw a sprite with outline
/// @param _sprite	  The index of the sprite you want to draw
/// @param _subimg	  The image index of the sprite you want do draw
/// @param _x		  The X coordinate do you want to draw
/// @param _y		  The Y coordinate do you want to draw
/// @param _thickness The thickness of the outline
/// @param _out_color The colow of the outline you want, default to black
function draw_sprite_outline(_sprite, _subimg, _x, _y, _thickness, _out_color = c_black)
{
	var _col = draw_get_colour();
	var _alpha = draw_get_alpha();
	
	draw_set_colour(_out_color);
	
	for (var i = 0; i < 360; i += 45)
	{
		var _dx = lengthdir_x(_thickness, i);
		var _dy = lengthdir_y(_thickness, i);
		
		draw_sprite_ext(_sprite, _subimg, _x + _dx, _y + _dy, 1, 1, 0, _out_color, 1);
	}
	
	draw_set_colour(_col);
	draw_set_alpha(_alpha)
	
	draw_sprite(_sprite, _subimg, _x, _y);
}