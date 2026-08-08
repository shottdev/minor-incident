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