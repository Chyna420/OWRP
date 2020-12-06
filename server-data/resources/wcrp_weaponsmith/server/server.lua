VORP = exports.vorp_inventory:vorp_inventoryApi()



RegisterServerEvent('wc_cattlemanmake')
AddEventHandler('wc_cattlemanmake', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "ironingot")
    local count2 = VORP.getItemCount(_source, "woodlog")
    local count3 = VORP.getItemCount(_source, "cattleblueprint")

    local ammoList = {
    ["AMMO_REVOLVER"] = 100
    }

    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 5 and count2 >= 2 and count3 >= 1 then
         
        VORP.subItem(_source, "ironingot", 5)
        VORP.subItem(_source, "woodlog", 2)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_CATTLEMAN", ammoList, compsList) --Check limit of weapons of your inventory becaouse this not work if you have max weapons.

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_CATTLEMAN", playerped) Not needed, create weapon gives automatically to your inventory.

        --Wait(100)

        --VORP.addBullets(source, "WEAPON_REVOLVER_CATTLEMAN", "AMMO_REVOLVER", 100) Ammo is gived

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'You Crafted a Cattleman Pistol', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'You need: 5 Iron Ingots, 2 Wood Logs, and 1 Cattleman Blueprint', 4500)
        print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_doublemake')
AddEventHandler('wc_doublemake', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "ironingot")
    local count2 = VORP.getItemCount(_source, "woodlog")
    local count3 = VORP.getItemCount(_source, "doubleblueprint")
    local ammoList = {
    ["AMMO_REVOLVER"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 5 and count2 >= 2 and count3 >=1 then
         
        VORP.subItem(_source, "ironingot", 5)
        VORP.subItem(_source, "woodlog", 2)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_DOUBLEACTION", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'You Crafted a Double Action Pistol', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'You need: 5 Iron Ingots, 2 Wood Logs, and Double-Action Blueprints', 4500)
        print('noitemsrequired')
    end      
end)

