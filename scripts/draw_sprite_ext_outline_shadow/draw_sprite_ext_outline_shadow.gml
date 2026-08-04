// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

/// Draw a sprite with outline and shadow, with the specified color you want
/// @param _sprite		 The index of the sprite you want to draw
/// @param _subimg		 The image index of the sprite you want do draw
/// @param _x			 The X coordinate do you want to draw
/// @param _y			 The Y coordinate do you want to draw
/// @param _thickness	 The outline distance
/// @param _offsetx		 The X offset of the shadow
/// @param _offsety		 The Y offset of the shadow
/// @param _out_color    The outline color (default to black)
/// @param _shadow_color The shadow color (default to black)
function draw_sprite_ext_outline_shadow(_sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _colour, _alpha, _thickness, _offsetx, _offsety, _out_color = c_black, _shadow_color = c_black)
{
	var _col = draw_get_colour();
	
	draw_set_colour(_shadow_color);
	
	draw_sprite_ext(_sprite, _subimg, _x + _offsetx, _y + _offsety, _xscale, _yscale, _rot, _colour, _alpha);
	
	draw_set_colour(_col);
	
	draw_sprite_ext_outline(_sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _colour, _alpha, _thickness, _out_color);
}