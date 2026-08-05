/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var _mouse_in = position_meeting(mouse_x, mouse_y, id);
var _mouse_click = mouse_check_button_pressed(mb_left);

if (_mouse_in)
{
	if (_mouse_click)
	{
		if (global.essences >= value)
		{
			var _qtd = array_length(targets);
		
			if (_qtd > 0)
			{
				for (var i = 0; i < _qtd; i++)
				{
					var _index = targets[i];
				
					if (!_index.active)
					{
						_index.active = true;
					}
				}
			}
			
			obtained = true;
		}
		
		
	}
}