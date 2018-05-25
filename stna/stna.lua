_addon.name = 'STNA'
_addon.version = '1.07'
_addon.author = 'Nitrous (Shiva) edited by Landsoul (Quetzalcoatl)'
_addon.command = 'stna'

require('tables')
require('sets')
res = require('resources')

windower.register_event('load', function()
    statSpell = { 
        paralysis='Paralyna',
        curse='Cursna',
        doom='Cursna',
        silence='Silena',
        plague='Viruna',
        diseased='Viruna',
        petrification='Stona',
        poison='Poisona',
        blindness='Blindna',
        slow='Erase',
        Elegy='Erase',
        bind='Erase',
        Bio='Erase',
        ['Defense Down']='Erase',
        ['Magic Def. Down']='Erase'

    }
    --You may change this priority as you see fit this is my personal preference		
    priority = T{}
    priority[1] = 'doom'
    priority[2] = 'curse'
    priority[3] = 'petrification'
    priority[4] = 'plague'
    priority[5] = 'paralysis'
    priority[6] = 'Defense Down'
    priority[7] = 'Magic Def. Down'
    priority[8] = 'slow'
    priority[9] = 'Elegy'
    priority[10] = 'blindness'
    priority[11] = 'bind'
    priority[12] = 'Bio'
    priority[13] = 'silence'
    priority[14] = 'poison'
    priority[15] = 'diseased'
	
    statusTable = S{}
end)

windower.register_event('addon command', function(...)
    if statusTable ~= nil then
        local player = windower.ffxi.get_player()
        for i = 1, 15 do
            if statusTable:contains(priority[i]) then
                windower.send_command('send @others /ma "'..statSpell[priority[i]]..'" '..player['name'])
                if priority[i] == 'Doom' then
                    windower.send_command('input /item "Holy Water" '..player['name'])  --Auto Holy water for doom
                end
                return
            end
        end
        windower.add_to_chat(55,"You are not afflicted by a debuff.")
    end
end)

windower.register_event('gain buff', function(id)
    local name = res.buffs[id].english
    if priority:contains(name) and not statusTable:contains(name) then
        statusTable:add(name)
    end
end)


windower.register_event('lose buff', function(id)
    local name = res.buffs[id].english
    if statusTable:contains(name) then
        statusTable:remove(name)
    end
end)
