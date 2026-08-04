// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

/// Draw a text with outline, with the specified color you want
/// @param _x				 The X coordinate do you want to draw
/// @param _y				 The Y coordinate do you want to draw
/// @param _string			 The text you want to draw
/// @param _xscale			 The xscale of the text to draw
/// @param _yscale			 The yscale of the text to draw
/// @param _angle			 The angle of the text to draw
/// @param _thickness		 The outline thickness
/// @param _offsetx			 The X offset of the shadow
/// @param _offsety			 The Y offset of the shadow
/// @param _out_color		 The outline color (default to black)
/// @param _shadow_color	 The shadow color (default to black) 
function draw_text_transformed_outline_shadow(_x, _y, _string, _xscale, _yscale, _angle, _thickness, _offsetx, _offsety, _out_color = c_black, _shadow_color = c_black)
{
	var _col = draw_get_colour();
	
	draw_set_colour(_shadow_color);
	
	draw_text_transformed(_x + _offsetx, _y + _offsety, _string, _xscale, _yscale, _angle);
	
	draw_set_colour(_col);
	
	draw_text_transformed_outline(_x, _y, _string, _xscale, _yscale, _angle, _thickness, _out_color);
}