-- Originally Created by Peython & Josh. I just fixed it for all paid exploits.
-- Works on ProtoSmasher, Synapse, Sirhurt, Sentinel, Calamari (not sure) 

_G.output = warn -- kewls

do
local mt = getrawmetatable(game)
local i, n = mt.__index, mt.__namecall
do local w = (setreadonly or changereadonly or make_writeable or fullaccess)(mt, false) end -- Josh is just kewl

local game = game
local HttpService = game.HttpService
local GetObjects = game.GetObjects
local HttpGet = game.HttpGet

local Responder = function(FunctionType, link, ...) -- This is called with the type of function(GetObjects/HttpGet/Index) and link. It can be modified to do whatever you want.
	if FunctionType == 'HttpGet' or FunctionType == 'HttpGetAsync' or FunctionType == 'GetAsync' then -- GET
		_G.output(FunctionType.." :: "..link) -- This can be changed to do what you want with the link (copy to clipboard etc.).
		--return HttpGet(game, link, true)
		return "" -- Set this to return the string you want when HttpGet is called.
	elseif FunctionType == 'HttpPost' or FunctionType == 'HttpPostAsync' or FunctionType == 'PostAsync' then -- POST
		_G.output(FunctionType.." :: "..link)
		return ""
	elseif FunctionType == 'GetObjects' then -- GetObjects
		_G.output(FunctionType.." :: "..link)
		return setmetatable({}, {__index = function(ObjectTable, arg) return Responder('Index', link, arg) end}) -- Recieves the index when GetObjects calls the table.
	elseif FunctionType == 'Index' then
		local ExtraArgs = {...}
		_G.output('GetObjects Link: '..link..' :: Attempt to index: '..ExtraArgs[1])
		return {} -- This is the GetObjects table that will be returned.
	end
	
	return nil -- Should never happen, but it can't hurt.
end

mt.__index = newcclosure(function(self, k) -- __index
    if self == game then
		if k == 'HttpGet' or k == 'HttpGetAsync' or k == 'HttpPost' or k == 'HttpPostAsync' or k == 'GetObjects' then
			return newcclosure(function(...)
				local link = get_namecall_method() or getnamecallmethod()
				return Responder(k, link)
			end)
		end
	elseif self == HttpService then
		if k == 'GetAsync' or k == 'PostAsync' then
			return newcclosure(function(...)
				local link = get_namecall_method() or getnamecallmethod()
				return Responder(k, link)
			end)
		end
    end
    return i(self, k)
end)
mt.__namecall = newcclosure(function(self, ...) -- __namecall
    local m = get_namecall_method() or getnamecallmethod()
    if self == game then
		if m == 'HttpGet' or m == 'HttpGetAsync' or m == 'HttpPost' or m == 'HttpPostAsync' or m == 'GetObjects' then
			local link = table.remove({...}, 1)
			return Responder(m, link)
		end
	elseif self == HttpService then 
		if m == 'GetAsync' or m == 'PostAsync' then
			local link = table.remove({...}, 1)
			return Responder(m, link)
		end
	end
    return n(self, ...)
end)

_G.output('Loaded HTTP Spy Successfully!\nCreated by Peyton and Josh @ V3rmillion - Fixed by CreativeHell')
end
