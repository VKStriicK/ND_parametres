# 📘 ND_parametres

## 📝 Description

**FR :**  
Cette ressource vous permet d’ajouter des **paramètres personnalisables** que les joueurs peuvent configurer pour adapter leur expérience de jeu selon leurs préférences.  
Exemple : afficher la mini-carte uniquement en véhicule, changer la couleur du HUD, etc.

**EN :**  
This resource allows you to add **customizable settings** that players can tweak to personalize their gameplay experience.  
Example: only display the minimap while in a vehicle, change HUD colors, etc.

---

## ⚙️ Installation

1. Placez la ressource dans votre dossier `resources`. // Place the resource in your `resources` folder.
2. Ajoutez la ligne suivante dans votre `server.cfg` : // Add the following line to your `server.cfg`:
   ```cfg
   ensure ND_parametres
   ```

---

## ➕ Ajouter un nouveau paramètre // Add a New Parameter

### 1. Créez les fonctions pour charger / sauvegarder le paramètre // Create the funcitons to load / save the parameter

#### ✅ Si c’est un paramètre booléen (oui/non) : // If it's a boolean (yes/no) :

```lua
local preference = false

function LoadPreference()
    local kvp = GetResourceKvpString("preference")
    preference = tostring(kvp) == "true"
    TriggerServerEvent('preference:updatePreference', preference)
end

function SavePreference()
    SetResourceKvp("preference", tostring(preference))
    TriggerServerEvent('preference:updatePreference', preference)
end
```

#### 🔧 Si c’est un autre type (texte, nombre...) : // If it's an other type (number, text...)

```lua
local preference = nil

function LoadPreference()
    local kvp = GetResourceKvpString("preference")
    preference = tostring(kvp)
    TriggerServerEvent('preference:updatePreference', preference)
end

function SavePreference()
    SetResourceKvp("preference", tostring(preference))
    TriggerServerEvent('preference:updatePreference', preference)
end
```

---

### 2. Ajoutez votre fonction pour charger le paramètre dans le thread principal // Add your function to load the parameter in the principal thread

```lua
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
    LoadPreference()
end)
```

---

### 3. Créez l’export du paramètre // Create the export

```lua
exports("preference", function()
    return preference
end)
```

Et ajoutez dans le `fxmanifest.lua` : // And add it to `fxmanifest.lua` :

```lua
client_export {
    "preference"
}
```

---

### 4. Côté ressource concernée : // In the target resource :

#### 🖥️ Serveur :

```lua
RegisterNetEvent('preference:updatePreference')
AddEventHandler('preference:updatePreference', function(preference)
    local source = source
    TriggerClientEvent("preference:updatePreference", source, preference)
end)
```

#### 🖥️ Client :

```lua
RegisterNetEvent("preference:updatePreference")
AddEventHandler("preference:updatePreference", function(preference)
    print(preference)
    -- Faites ce que vous voulez avec
end)
```

---

## 📬 Contact

**Pour tout bug, suggestion ou question : // For any bug, suggestion, or question :**
> Discord → `vkstriick971`