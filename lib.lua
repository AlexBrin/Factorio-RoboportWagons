function HasElectricTrainInstalled()
    return HasModInstalled("ElectricTrain")
end

function HasSEInstalled()
    return HasModInstalled("space-exploration")
end

function HasModInstalled(mod)
    if mods then
        return mods[mod]
    end

    return game.active_mods[mod]
end

function table.count(self)
    if self == nil or self == {} then 
        return 0 
    end

    local i = 0
    for _ in pairs(self) do
        i = i + 1
    end

    return i
end

function format_number(number_string)
    local number = number_string:match('%d+%.?%d+')
	local append_suffix = number_string:match('%a+')
	
	local pre = ""
	local typ = ""
	
	if append_suffix:len() == 2 then
		pre =  append_suffix:sub(1, 1):upper()
		typ =  append_suffix:sub(2):upper()
	elseif append_suffix:len() == 1 then
		typ = append_suffix:upper()
	end

	
	if pre == "K" then
		number = number * 1000
	elseif pre == "M" then
		number = number * 1000000
	end
		
	if typ == "W" then
		number = number / 60
	end
	return number
end