// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

/// Draw a text with outline and shadow, with the specified color you want
/// @param _x			 The X coordinate do you want to draw
/// @param _y			 The Y coordinate do you want to draw
/// @param _string		 The text you want to draw
/// @param _offsetx		 The X offset of the shadow
/// @param _offsety		 The Y offset of the shadow
/// @param _shadow_color The shadow color (default to black)
function draw_text_shadow(_x, _y, _string, _offsetx, _offsety, _shadow_color = c_black)
{
	var _col = draw_get_colour();
	
	draw_set_colour(_shadow_color);
	
	draw_text(_x + _offsetx, _y + _offsety, _string);
	
	draw_set_colour(_col);
	
	draw_text(_x, _y, _string);
}