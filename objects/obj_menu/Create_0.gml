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

//aba atual
index = 0;

//opção selecionada
selected = 0;

//escala da opção
scale = 1;

//começando a tocar a música
if (global.music == noone) global.music = audio_play_sound(snd_game_ost, 1, true, global.master_gain * global.music_gain);

//método pra controlar o menu
control_menu = function()
{
	//pegando o tamanho do menu
	var _length = array_length(menu[index]);
	
	//pegando os controles do menu
	var _down = keyboard_check_pressed(vk_down);
	var _up = keyboard_check_pressed(vk_up);
	var _left = keyboard_check_pressed(vk_left);
	var _right = keyboard_check_pressed(vk_right);
	var _accept = keyboard_check_pressed(vk_enter);
	
	//se aperto pra cima e a opção selecionada não é a primeira
	if (_up && selected > 0)
	{
		//subo uma opção
		selected--;
		
		//reseto a escala
		scale = 1
	}
	
	//se aperto pra baixo e a opção selecionada não é a última
	if (_down && selected < (_length - 1))
	{
		//desco uma opção
		selected++;
		
		//reseto a escala
		scale = 1;
	}
	
	//sempre tentando aumentar a escala
	scale = lerp(scale, 1.3, .1);
	
	//se aperto enter
	if (_accept)
	{
		//ativo o método pra executar o que o botão faz
		active_menu();
		
		//reseto a escala
		scale = 1;
	}

	//checando a aba
	switch (index)
	{
		//aba de áudio
		case 3:
		{
			//checando a opção selecionada
			switch (selected)
			{
				//volume geral
				case 0:
				{
					//se aperto pra esquerda, mudo o volume geral e atualizo o volume da música
					if (_left)
					{
						if (global.master_gain > 0) global.master_gain -= .05;
						audio_sound_gain(global.music, global.master_gain * global.music_gain);
					}
					
					//se aperto pra direita, mudo o volume geral e atualizo o volume da música
					if (_right)
					{
						if (global.master_gain < 1) global.master_gain += .05;
						audio_sound_gain(global.music, global.master_gain * global.music_gain);
					}
				}
				break;
					
				//volume da música
				case 1:
				{
					//se aperto pra esquerda, mudo e atualizo o volume da música
					if (_left)
					{
						if (global.music_gain > 0) global.music_gain -= .05;
						audio_sound_gain(global.music, global.master_gain * global.music_gain);
					}
						
					//se aperto pra direita, mudo e atualizo o volume da música
					if (_right)
					{
						if (global.music_gain < 1) global.music_gain += .05
						audio_sound_gain(global.music, global.master_gain * global.music_gain);
					}
				}
				break;
					
				//volume da sfx
				case 2:
				{
					//se aperto pra esquerda, mudo o volume da sfx
					if (_left)
					{
						if (global.sfx_gain > 0) global.sfx_gain -= .05;
					}
					
					//se aperto pra direita, mudo o volume da sfx
					if (_right)
					{
						if (global.sfx_gain < 1) global.sfx_gain += .05;
					}
				}
			}
		}
		break;
	}
	
	menu[3, 0] = "Volume geral: " + string("{0}%", string_format(global.master_gain * 100, 1, 0))
	menu[3, 1] = "Volume música: " + string("{0}%", string_format(global.music_gain * 100, 1, 0))
	menu[3, 2] = "Volume SFX: " + string("{0}%", string_format(global.sfx_gain * 100, 1, 0))
}

//desenhando o menu
draw_menu = function()
{
	//pegando a largura da room
	var _gui_w = room_width;
	
	//pegando a altura da room
	var _gui_h = room_height;
	
	//tamanho do menu
	var _length = array_length(menu[index]);
	
	//setando as posições
	var _x = _gui_w / 2;
	var _y = _gui_h / 2.5;
	
	//setando o alinhamento pro centro
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	//setando a cor base
	var _col = c_white;
	
	//setando a escala base
	var _scale = 1;
	
	//setando a fonte
	draw_set_font(fnt_menu);
	
	//laço de repetição pra desenhar
	for (var i = 0; i < _length; i++)
	{
		//se a minha opção ta selecionada
		if (selected == i)
		{
			//mudo a cor
			_col = c_red;
			
			//mudo a escala
			_scale = scale;
		}
		else //senão
		{
			//mantenho a cor
			_col = c_white;
			
			//mantenho a escala
			_scale = 1;
		}
		
		//seto a cor
		draw_set_colour(_col);
		
		//desenho o texto
		draw_text_transformed_outline_shadow(_x, _y, menu[index, i], _scale, _scale, 0, 3, 0, 4);
		
		//reseto a cor
		draw_set_colour(c_white);
		
		//aumento o y pra desenhar a próxima opção
		_y += 20;
	}
	
	//reseto o alinhamento
	draw_set_halign(fa_none);
	draw_set_valign(fa_none);
	
	//reseto a fonte
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
				//Vídeo
				case 0:
				{
					index = 2;
					selected = 0;
				}
				break;
				
				//Áudio
				case 1:
				{
					index = 3;
					selected = 0;
				}
				break;
				
				//Voltar
				case 2:
				{
					index = 0;
					selected = 0;
				}
			}
		}
		break;
		
		//menu de opções de vídeo
		case 2:
		{
			switch (selected)
			{
				//Fullscreen
				case 0:
				{
					global.fullscreen = !global.fullscreen;
					menu[2, 0] = "Fullscreen: " + onoff(global.fullscreen);
				}
				break;
				
				//Voltar
				case 1:
				{
					index = 1;
					selected = 0;
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
				//Voltar
				case 3:
				{
					index = 1;
					selected = 0;
				}
				break;
			}
		}
		break;
	}
}