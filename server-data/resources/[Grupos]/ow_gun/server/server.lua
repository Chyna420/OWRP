VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


-- CRAFTING gun
RegisterServerEvent('wc_da_bp')
AddEventHandler('wc_da_bp', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "folha")
    local count2 = VORP.getItemCount(_source, "tinta")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 then
         
        VORP.subItem(_source, "folha", 1)
        VORP.subItem(_source, "tinta", 2)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.addItem(_source, "doubleactionbp", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'O manual está pronto.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '', 4500)
        print('noitemsrequired')
    end      
end)

--Schofieldbp
RegisterServerEvent('wc_sf_bp')
AddEventHandler('wc_sf_bp', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "folha")
    local count2 = VORP.getItemCount(_source, "tinta")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 then
         
        VORP.subItem(_source, "folha", 1)
        VORP.subItem(_source, "tinta", 2)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.addItem(_source, "schofieldbp", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'O manual está pronto.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '', 4500)
        print('noitemsrequired')
    end      
end)

--laçobp
RegisterServerEvent('wc_la_bp')
AddEventHandler('wc_la_bp', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "folha")
    local count2 = VORP.getItemCount(_source, "tinta")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 then
         
        VORP.subItem(_source, "folha", 1)
        VORP.subItem(_source, "tinta", 2)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.addItem(_source, "lacobp", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'O manual está pronto.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, '', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE NORMALI
RegisterServerEvent('wc_darevolver')
AddEventHandler('wc_darevolver', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "doubleactionbp")
    local count2 = VORP.getItemCount(_source, "corporevolver")
    local count3 = VORP.getItemCount(_source, "ironore")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
    
    if count >= 1 and count2 >= 1 and count3 >= 0 then
         
        VORP.subItem(_source, "doubleactionbp", 1)
        VORP.subItem(_source, "corporevolver", 1)
        VORP.subItem(_source, "ironore", 0)
        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_DOUBLEACTION", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve um DoubleAction Revolver', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 1 doubleaction bp 1 corpo de revolver', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE AVVELENATE
RegisterServerEvent('wc_sfrevolver')
AddEventHandler('wc_sfrevolver', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "schofieldbp")
    local count2 = VORP.getItemCount(_source, "corporevolver")
    local count3 = VORP.getItemCount(_source, "wood")

    local ammoList = {
    ["ammo_bullet_revolver"] = 5
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 0 and count2 >= 0 and count3 >= 0 then
         
        VORP.subItem(_source, "schofieldbp", 0)
        VORP.subItem(_source, "corporevolver", 0)
        VORP.subItem(_source, "wood", 0)
        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_SCHOFIELD", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve uma Schofield revolver', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 1 shocfieldbp 1 corpor de revolver ', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_laço')
AddEventHandler('wc_laço', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "lacobp")
    local count2 = VORP.getItemCount(_source, "corda")

    local ammoList = {
    ["AMMO_TOMAHAWK"] = 1
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 1 and count2 >= 2 then
         
        VORP.subItem(_source, "lacobp", 1)
        VORP.subItem(_source, "corda", 2)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_LASSO", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve um Laço', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 1 laçobp e 2 corda', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_al')
AddEventHandler('wc_al', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "bauxita")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 2 then
         
        VORP.subItem(_source, "bauxita", 2)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "aluminio", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve Alumínio', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 2 bauxitas', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_pol')
AddEventHandler('wc_pol', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "chumbo")
    local count2 = VORP.getItemCount(_source, "prata")
    local count3 = VORP.getItemCount(_source, "copperore")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 99 and count2 >= 99 and count3 >= 99 then
         
        VORP.subItem(_source, "chumbo", 99)
        VORP.subItem(_source, "prata", 99)
        VORP.subItem(_source, "copperore", 99)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "polvora", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve Pólvora', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Não podes utilizar pólvora por agora', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_cr')
AddEventHandler('wc_cr', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "ironore")
    local count2 = VORP.getItemCount(_source, "aluminio")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 0 and count2 >= 0 then
         
        VORP.subItem(_source, "ironore", 2)
        VORP.subItem(_source, "aluminio", 3)

        
        TriggerClientEvent("progressbar:startGun", _source)

        Wait(20000)

        VORP.createWeapon(_source, "corporevolver", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Obteve Corpo de revolver', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Precisas de 3 Ferro, 1 Alumínio, 2 Madeira', 4500)
        print('noitemsrequired')
    end      
end)

RegisterServerEvent('gun:checkgroup')
AddEventHandler('gun:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Nordic" or Character.job=="Nordic" then
        TriggerClientEvent('gun:checkgroupcl', _source)
    end
  
end)