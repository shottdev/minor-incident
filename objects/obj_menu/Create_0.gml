/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

menu[0, 0] = "Jogar";
menu[0, 1] = "Opções";
menu[0, 2] = "Sair";

menu[1, 0] = "Vídeo";
menu[1, 1] = "Áudio";
menu[1, 2] = "Voltar";

menu[2, 0] = "Fullscreen: " + onoff(global.fullscreen);
menu[2, 1] = "Voltar";

menu[3, 0] = "Volume geral: " + string("{0}%", global.master_gain * 100);
menu[3, 1] = "Volume música: " + string("{0}%", global.music_gain * 100);
menu[3, 2] = "Volume SFX: " + string("{0}%", global.sfx_gain * 100);
menu[3, 3] = "Voltar";

index = 0;

selected = 0;

scale = 1;

control_menu = function()
{
	var _length = array_length(menu[index]);
	
	var _down = keyboard_check_pressed(vk_down);
	var _up = keyboard_check_pressed(vk_up);
	var _left = keyboard_check_pressed(vk_left);
	var _right = keyboard_check_pressed(vk_right);
	var _accept = keyboard_check_pressed(vk_enter);
	
	if (_up && selected > 0)
	{
		selected--;
		scale = 1
	}
	
	if (_down && selected < (_length - 1))
	{
		selected++;
		scale = 1;
	}
	
	scale = lerp(scale, 1.5, .1);
	
	if (_accept)
	{
		active_menu();
	}
}

draw_menu = function()
{
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _length = array_length(menu[index]);
	
	var _x = _gui_w / 2;
	var _y = _gui_h / 2.5;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var _col = c_white;
	var _scale = 1;
	
	draw_set_font(fnt_menu);
	
	for (var i = 0; i < _length; i++)
	{
		if (selected == i)
		{
			_col = c_red;
			_scale = scale;
		}
		else
		{
			_col = c_white;
			_scale = 1;
		}
		
		draw_set_colour(_col);
		
		draw_text_transformed(_x, _y, menu[index, i], _scale, _scale, 0);
		
		draw_set_colour(c_white);
		
		_y += (string_height(menu[index, i]) * _scale) + 10;
	}
	
	draw_set_halign(fa_none);
	draw_set_valign(fa_none);
	
	draw_set_font(-1);
}

active_menu = function()
{
	switch (index)
	{
		//menu principal
		case 0:
		{
			switch (selected)
			{
				case 0:
				{
					//Jogar
					global.in_transition = true;
					global.transition_state = 1;
					global.next_room = rm_upgrades;
				}
				break;
				
				case 1:
				{
					//Opções
					index = 1;
					selected = 0;
				}
				break;
				
				case 2:
				{
					//Sair
					game_end();
				}
			}
		}
		break;
		
		//menu de opções
		case 1:
		{
			switch (selected)
			{
				case 0:
				{
					
				}
				break;
			}
		}
		break;
		
		//menu de opções de vídeo
		case 2:
		{
			switch (selected)
			{
				case 0:
				{
					
				}
				break;
			}
		}
		break;
		
		//menu de opções de áudio
		case 3:
		{
			switch (selected)
			{
				case 0:
				{
					
				}
				break;
			}
		}
		break;
	}
}