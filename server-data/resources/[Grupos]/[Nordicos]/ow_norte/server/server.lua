VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


-- CRAFTING TONICO INDIANI
RegisterServerEvent('wc_tonico_aug')
AddEventHandler('wc_tonico_aug', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "water")
    local count2 = VORP.getItemCount(_source, "uisque")
    local count3 = VORP.getItemCount(_source, "emptybottle")
    local count4 = VORP.getItemCount(_source, "alginseng")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 4 and count2 >= 2 and count3 >= 1 and count3 >= 5 then
         
        VORP.subItem(_source, "water", 4)
        VORP.subItem(_source, "uisque", 2)
        VORP.subItem(_source, "emptybottle", 1)
        VORP.subItem(_source, "alginseng", 5)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.addItem(_source, "oblackshark", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Óleo BlackShark', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 4 água, 2 uisque, 1 garrafa vazia e 5 Gingseng', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE NORMALI
RegisterServerEvent('wc_arcofreccebase')
AddEventHandler('wc_arcofreccebase', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "corda")
    local count3 = VORP.getItemCount(_source, "pelet")

    local ammoList = {
    ["AMMO_ARROW"] = 15
    }

    local compsList = {
    ["nothing"] = 0
    }
    
    if count >= 5 and count2 >= 1 and count3 >= 2 then
         
        VORP.subItem(_source, "wood", 5)
        VORP.subItem(_source, "corda", 1)
        VORP.subItem(_source, "pelet", 2)
        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_BOW", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Arco Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '5 Madeiras, 1 Corda, 2 Pele tratada', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE AVVELENATE
RegisterServerEvent('wc_arcofrecceavvelenate')
AddEventHandler('wc_arcofrecceavvelenate', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "corda")
    local count3 = VORP.getItemCount(_source, "pelet")
    local count4 = VORP.getItemCount(_source, "feather")

    local ammoList = {
    ["AMMO_ARROW"] = 15
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 10 and count2 >= 2 and count3 >= 3 and count4 >= 2 then
         
        VORP.subItem(_source, "wood", 10)
        VORP.subItem(_source, "corda", 2)
        VORP.subItem(_source, "pelet", 3)
        VORP.subItem(_source, "feather", 2)
        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_BOW_IMPROVED", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Arco Reforçado Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '10 Madeira, 2 Cordas, 3 Pele tratada, 2  Penas', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_tomahawk')
AddEventHandler('wc_tomahawk', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "pelet")
    local count3 = VORP.getItemCount(_source, "ironore")

    local ammoList = {
    ["AMMO_TOMAHAWK"] = 1
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 1 and count2 >= 2 and count3 >= 2 then
         
        VORP.subItem(_source, "wood", 1)
        VORP.subItem(_source, "pelet", 2)
        VORP.subItem(_source, "ironore", 2)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_THROWN_TOMAHAWK", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Tomahawk Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '1 Madeira, 2 Pele Tratada, 2 Ferro', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING hunter
RegisterServerEvent('wc_hunter')
AddEventHandler('wc_hunter', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "pelet")
    local count3 = VORP.getItemCount(_source, "ironore")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 3 and count2 >= 2 and count3 >= 4 then
         
        VORP.subItem(_source, "wood", 3)
        VORP.subItem(_source, "pelet", 2)
        VORP.subItem(_source, "ironore", 4)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_MELEE_HATCHET_HUNTER", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Machado de Caçador Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '3 Madeira, 2 Pele Tratada, 4 Ferro', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING wc_ancient
RegisterServerEvent('wc_ancient')
AddEventHandler('wc_ancient', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "pelet")
    local count3 = VORP.getItemCount(_source, "ironore")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 1 and count2 >= 1 and count3 >= 1 then
         
        VORP.subItem(_source, "wood", 1)
        VORP.subItem(_source, "pelet", 1)
        VORP.subItem(_source, "ironore", 3)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_MELEE_CLEAVER", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Cleaver Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '1 Madeira, 1 Pele tratada, 3 Ferro', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING wc_ancient
RegisterServerEvent('wc_ta')
AddEventHandler('wc_ta', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "wood")
    local count2 = VORP.getItemCount(_source, "pelet")
    local count3 = VORP.getItemCount(_source, "ironore")
    local count3 = VORP.getItemCount(_source, "feather")

    local ammoList = {
    ["AMMO_TOMAHAWK_ANCIENT"] = 1
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 4 and count2 >= 3 and count3 >= 5 and count4 >= 3 then
         
        VORP.subItem(_source, "wood", 4)
        VORP.subItem(_source, "pelet", 3)
        VORP.subItem(_source, "ironore", 5)
        VORP.subItem(_source, "feather", 3)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_THROWN_TOMAHAWK_ANCIENT", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Tomahawk Ancient Construido', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '', 4500)
        print('noitemsrequired')
    end      
end)

RegisterServerEvent('indiani:checkgroup')
AddEventHandler('indiani:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Nordic" or Character.job=="Nordici" then
        TriggerClientEvent('indiani:checkgroupcl', _source)
    end
  
end)
