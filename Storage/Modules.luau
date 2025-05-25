-- 《Service》 --
local _Ws = game:GetService("Workspace")
local _Plrs = game:GetService("Players")
local _StG = game:GetService("StarterGui")

-- 《Modules》 --
local Modules = {}

Modules.bringpart = function(name, optionals)
  for i, v in pairs(game:GetDescendants()) do
    if (v:IsA("BasePart") or v:IsA("Part")) and v.Name == name then
      local player = _Plrs.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        v.CanCollide = false
        v.Anchored = optionals
        v.CFrame = CFrame.new(hrp.Position)
      end
    end
  end
end

Modules.countplayers = function()
  local count = 0
  for i, v in pairs(_Plrs:GetPlayers()) do
    print("Player: " .. v.Name .. ", DisplayName: " .. v.DisplayName)
    count = count + 1
  end
  return count
end

Modules.notify = function(tl, txt)
  _StG:SetCore("SendNotification", {
    Title = tl,
    Text = txt,
    Duration = 1,
  })
end

Modules.Input_E = function(data)
    local b = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
 
Modules.Output_E = function(data)
    local b = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

return Modules
