// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


//iniciar o efeito de brilho
/// Use essa funcao para inicializar as variáveis necessárias para o efeito de brilho
function colorise_init()
{
	cl_alpha	= 0;
	cl_color	= c_white;
}

//aplicando o efeito de brilho
/// Use essa funcao para aplicar o brilho
/// @param cor		A cor do brilho que deseja aplicar (c_white padrao)
/// @param alpha	A intensidade do brilho que deseja aplicar (1 padrao, 1 para mais intenso e 0 para sem intensidade)
function colorise_apply(_color = c_white, _alpha = 1)
{
	cl_alpha	 = _alpha;
	cl_color	 = _color;
}

//retornando pra cor orginal
/// Use essa funcao no step para retornar o brilho para o normal
/// @param vel	Velocidade que deseja que o brilho suma (padrao: 0.1)
function colorise_return(_vel = 0.1)
{
	cl_alpha = lerp(cl_alpha, 0, _vel);
}


//desenhando o efeito do brilho
/// Use essa funcao depois de desenhar sua sprite, também é possível faze-la manualmente utilizando as variáveis já criadas
function colorise_draw(_spr)
{
	//só preciso me desenhar se o alpha brilho for menor do que 0
	//se o alpha brilho nao for menor do quer zero
	if (cl_alpha <= 0.01) return;
	
	shader_set(sh_colorise);
	draw_sprite_ext(_spr, image_index, x, y, image_xscale, image_yscale, image_angle, cl_color, cl_alpha);
	shader_reset();
}
