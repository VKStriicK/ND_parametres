ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local mainMenu = RageUI.CreateMenu("Paramètres", "Menu principal")
local hudMenu = RageUI.CreateSubMenu(mainMenu, "HUD", "Personnalisation du HUD")
local hideMapOnFoot = false
local hideRightCorner = false
local positions = {"Droite", "Gauche", "Milieu"}
local currentIndex = 1
local carHudPosition = "Droite"
local showBankMoney = true
local hudColor = { r = 255, g = 255, b = 255 }
local textColor = { r = 0, g = 0, b = 0 }
local HUDColorStyle = {ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 180 }, ProgressColor = { R = 255, G = 255, B = 255, A = 255 }, LeftBadge = RageUI.BadgeStyle.None, RightBadge = RageUI.BadgeStyle.None, Enabled = true}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local letSleep = true
        
        RageUI.IsVisible(mainMenu, function()
			letSleep = false
			if Config.hideMapOnFoot then
				RageUI.Checkbox("Carte uniquement en voiture", "Affiche ou non la carte quand vous êtes à pied.", hideMapOnFoot, {}, {
					onChecked = function()
						hideMapOnFoot = not hideMapOnFoot
						SaveMapPreference()
					end,
					onUnChecked = function()
						hideMapOnFoot = not hideMapOnFoot
						SaveMapPreference()
					end,
					onSelected = function(Index)
					end
				})
			end
			if Config.hasND_hud then
				RageUI.Button("Paramètres HUD", "Personnalisez le HUD.", { RightLabel = nil }, true, {
					onSelected = function()
				end}, hudMenu)
			end
        end)
        
        RageUI.IsVisible(hudMenu, function()
			letSleep = false
			
			RageUI.List("Position du HUD en véhicule", positions, currentIndex, "Choisissez la position du HUD en véhicule.", {}, true, {
				onListChange = function(Index, Item)
					carHudPosition = Item
					SaveCarHudPosition(Item)
				end
			})

			RageUI.Checkbox("Masquer l'argent en banque", "Affiche ou non l'argent en banque.", not showBankMoney, {}, {
				onChecked = function()
					showBankMoney = not showBankMoney
					SaveBankMoneyPreference()
				end,
				onUnChecked = function()
					showBankMoney = not showBankMoney
					SaveBankMoneyPreference()
				end,
				onSelected = function(Index)
				end
			})

			RageUI.Checkbox("Masquer le HUD de droite", "Affiche ou non les informations à droite.", hideRightCorner, {}, {
				onChecked = function()
					hideRightCorner = not hideRightCorner
					SaveCornerPreference()
				end,
				onUnChecked = function()
					hideRightCorner = not hideRightCorner
					SaveCornerPreference()
				end,
				onSelected = function(Index)
				end
			})

			if not hideRightCorner then
				RageUI.Separator("~y~↓~l~---~y~ Couleur du HUD ~l~---~y~↓~s~")

				RageUI.SliderProgress("~r~Rouge", hudColor.r, 255, "Changer la couleur rouge du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(hudColor.r) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								hudColor.r = math.floor(number)
								SaveHudColor()
							end
						end
					end,
					onSliderChange = function(value)
						hudColor.r = value
						SaveHudColor()
					end
				})

				RageUI.SliderProgress("~g~Vert", hudColor.g, 255, "Changer la couleur verte du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(hudColor.g) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								hudColor.g = math.floor(number)
								SaveHudColor()
							end
						end
					end,
					onSliderChange = function(value)
						hudColor.g = value
						SaveHudColor()
					end
				})

				RageUI.SliderProgress("~b~Bleu", hudColor.b, 255, "Changer la couleur bleue du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(hudColor.b) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								hudColor.b = math.floor(number)
								SaveHudColor()
							end
						end
					end,
					onSliderChange = function(value)
						hudColor.b = value
						SaveHudColor()
					end
				})

				RageUI.Separator("~y~↓~l~---~y~ Couleur du texte ~l~---~y~↓~s~")

				RageUI.SliderProgress("~r~Rouge", textColor.r, 255, "Changer la couleur rouge du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(textColor.r) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								textColor.r = math.floor(number)
								SaveHudColorText()
							end
						end
					end,
					onSliderChange = function(value)
						textColor.r = value
						SaveHudColorText()
					end
				})

				RageUI.SliderProgress("~g~Vert", textColor.g, 255, "Changer la couleur verte du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(textColor.g) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								textColor.g = math.floor(number)
								SaveHudColorText()
							end
						end
					end,
					onSliderChange = function(value)
						textColor.g = value
						SaveHudColorText()
					end
				})

				RageUI.SliderProgress("~b~Bleu", textColor.b, 255, "Changer la couleur bleue du RGB", HUDColorStyle, true, {
					onSelected = function()
						local input = KeyboardInputFloat("Entrez une valeur entre 0 et 255 (Actuelle : " .. tostring(textColor.b) .. ")", 3)
						if input then
							local number = tonumber(input)
							if number and number >= 0 and number <= 255 then
								textColor.b = math.floor(number)
								SaveHudColorText()
							end
						end
					end,
					onSliderChange = function(value)
						textColor.b = value
						SaveHudColorText()
					end
				})
			end
        end)
		
		if letSleep then
			Citizen.Wait(500)
		end
    end
end)

if Config.hideMapOnFoot then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(750)
			local player = PlayerPedId()
			if hideMapOnFoot then
				if IsPedOnFoot(player) then
					DisplayRadar(false)
				else
					DisplayRadar(true)
				end
			else
				DisplayRadar(true)
			end
		end
	end)
end

Citizen.CreateThread(function()
	if Config.hideMapOnFoot then
    	LoadMapPreference()
	end
	if Config.hasND_hud then
		LoadHudColor()
		LoadHudColorText()
		LoadCornerPreference()
		LoadCarHudPosition()
		LoadBankMoneyPreference()
	end
end)

if Config.hideMapOnFoot then
	function SaveMapPreference()
		SetResourceKvp("map_hide_on_foot", tostring(hideMapOnFoot))
	end

	function LoadMapPreference()
		local kvp = GetResourceKvpString("map_hide_on_foot")
		hideMapOnFoot = (kvp == "true")
	end
end

if Config.hasND_hud then
	function LoadHudColor()
		hudColor.r = GetResourceKvpInt("hud_color_r")
		hudColor.g = GetResourceKvpInt("hud_color_g")
		hudColor.b = GetResourceKvpInt("hud_color_b")
		TriggerServerEvent('ND_hud:updateHudColor', hudColor)
	end

	function SaveHudColor()
		SetResourceKvpInt("hud_color_r", hudColor.r)
		SetResourceKvpInt("hud_color_g", hudColor.g)
		SetResourceKvpInt("hud_color_b", hudColor.b)
		TriggerServerEvent('ND_hud:updateHudColor', hudColor)
	end

	function LoadHudColorText()
		textColor.r = GetResourceKvpInt("hud_text_color_r")
		textColor.g = GetResourceKvpInt("hud_text_color_g")
		textColor.b = GetResourceKvpInt("hud_text_color_b")
		TriggerServerEvent('ND_hud:updateHudColorText', textColor)
	end

	function SaveHudColorText()
		SetResourceKvpInt("hud_text_color_r", textColor.r)
		SetResourceKvpInt("hud_text_color_g", textColor.g)
		SetResourceKvpInt("hud_text_color_b", textColor.b)
		TriggerServerEvent('ND_hud:updateHudColorText', textColor)
	end

	function SaveCornerPreference()
		SetResourceKvp("right_corner_hide", tostring(hideRightCorner))
		TriggerServerEvent('ND_hud:updateRightCornerPreference', hideRightCorner)
	end

	function LoadCornerPreference()
		local kvp = GetResourceKvpString("right_corner_hide")
		hideRightCorner = tostring(kvp) == "true"
		TriggerServerEvent('ND_hud:updateRightCornerPreference', hideRightCorner)
	end

	function SaveCarHudPosition(position)
		SetResourceKvp("hud_position_speedometer", tostring(position))
		TriggerServerEvent('ND_hud:updateCarHudPosition', position)
		currentIndex = getPositionIndex(position)
	end

	function LoadCarHudPosition()
		local kvp = GetResourceKvpString("hud_position_speedometer")
		carHudPosition = tostring(kvp)
		TriggerServerEvent('ND_hud:updateCarHudPosition', carHudPosition)
		currentIndex = getPositionIndex(carHudPosition)
	end

	function SaveBankMoneyPreference()
		SetResourceKvp("bank_money_hide", tostring(showBankMoney))
		TriggerServerEvent('ND_hud:updateBankMoneyPreference', showBankMoney)
	end

	function LoadBankMoneyPreference()
		local kvp = GetResourceKvpString("bank_money_hide")
		showBankMoney = tostring(kvp) == "true"
		TriggerServerEvent('ND_hud:updateBankMoneyPreference', showBankMoney)
	end

	function getPositionIndex(position)
		for i, pos in ipairs(positions) do
			if pos == position then
				return i
			end
		end
		return 1
	end

	function KeyboardInputFloat(textEntry, maxLength)
		AddTextEntry("FMMC_KEY_TIP1", textEntry)
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", maxLength or 3)
		while UpdateOnscreenKeyboard() == 0 do
			Citizen.Wait(0)
		end
		if UpdateOnscreenKeyboard() == 1 then
			local result = GetOnscreenKeyboardResult()
			return result
		end
		return nil
	end
end

RegisterCommand('open_settings_menu', function()
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end, false)

RegisterKeyMapping('open_settings_menu', 'Paramètres du joueur', 'keyboard', 'F5')

exports("GetHudColor", function()
    return hudColor
end)

exports("GetHudColorText", function()
    return textColor
end)

exports("GetRightCornerPreference", function()
    return hideRightCorner
end)

exports("GetCarHudPosition", function()
    return carHudPosition
end)

exports("GetBankMoney", function()
    return showBankMoney
end)