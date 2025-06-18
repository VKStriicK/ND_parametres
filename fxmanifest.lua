fx_version 'adamant'
game 'gta5'

dependency 'es_extended'

client_scripts {
    "src/RageUI/RMenu.lua",
    "src/RageUI/menu/RageUI.lua",
    "src/RageUI/menu/Menu.lua",
    "src/RageUI/menu/MenuController.lua",
    "src/RageUI/components/*.lua",
    "src/RageUI/menu/elements/*.lua",
    "src/RageUI/menu/items/*.lua",
    "src/RageUI/menu/panels/*.lua",
    "src/RageUI/menu/windows/*.lua"
}

client_scripts {
	"config.lua",
	"client/menu.lua"
}

server_scripts {
	"config.lua",
	"server/menu.lua"
}

dependencies {
	'es_extended'
}

client_export {
    'GetHudColor',
    'GetHudColorText',
    'GetRightCornerPreference',
    'GetCarHudPosition',
    'GetBankMoney',
}