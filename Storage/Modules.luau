-- 《Service》 --
local _Ws = game:GetService("Workspace")
local _Plrs = game:GetService("Players")
local _StG = game:GetService("StarterGui")
local _CG = game:GetService("CoreGui")
local _TxtCS = game:GetService("TextChatService")
local _DefCS = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")

local _CurrentCamera = _Ws.CurrentCamera

-- 《Modules》 --
_G.StuffInStorage = {}
local Modules = {}

Modules.RandomString = function(length : Number)
    local chars = "abcdefghijklmnopqrstuvwxyz0123456789"
    local randomString = ""
    
    for i = 1, length do
        local randomIndex = math.random(1, #chars)
        randomString = randomString .. chars:sub(randomIndex, randomIndex)
    end
    
    return randomString
end

Modules.CorrectName = function(plr_name : String)
    for i, v in ipairs(_Plrs:GetPlayers()) do
        if string.lower(v.Name):sub(1, #plr_name) == string.lower(plr_name) or
        string.lower(v.DisplayName):sub(1, #plr_name) == string.lower(plr_name) then
            return v
        end
    end
    print("[Output Result]: " .. v.Name .. "| " .. v.DisplayName)
    return nil
end

Modules.BringPart = function(name : String, optionals : Boolean)
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

Modules.CountPlayers = function()
  local count = 0
  for i, v in pairs(_Plrs:GetPlayers()) do
    print("Player: " .. v.Name .. ", DisplayName: " .. v.DisplayName)
    count = count + 1
  end
  return count
end

Modules.Chatted = function(_string : String)
    local _string = tostring(_string)
    if _DefCS then
        _DefCS.SayMessageRequest:FireServer(_string, "All")
    elseif _TxtCS then
        local _x = _TxtCS.TextChannels.RBXGeneral
        if _x then
            _x:SendAsync(_string)
        end
    end
end

Modules.Notification = function(tl : String, txt : String)
  _StG:SetCore("SendNotification", {
    Title = tl,
    Text = txt,
    Duration = 1,
  })
end

Modules.ButtonNotification = function(title : String, text : String, duration : Number, btnText1 : String, btnText2 : String, script : Function)
    _StG:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
        Button1 = btnText1,
        Callback = function()
            script()
        end,
        Button2 = btnText2,
    })
end

Modules.DevConsole = function()
    if _CG:FindFirstChild("DeveloperConsole") == nil then
        _StG:SetCore("DevConsoleVisible", true)
    end
end

Modules.ViewPlayer = function(plrs : String)
    if _Plrs[plrs] and _Plrs[plrs].Character and _Plrs[plrs].Character:FindFirstChild("HumanoidRootPart") then
        _CurrentCamera.CameraSubject = _Plrs[plrs].Character.Humanoid or _Plrs[plrs].Character.HumanoidRootPart
    end
end

Modules.TP = function(local_plr : String, plr_name : String)
    if _Plrs[plr_name] and _Plrs[plr_name].Character and _Plrs[plr_name].Character:FindFirstChild("HumanoidRootPart") then
        _Plrs[local_plr].Character:SetPrimaryPartCFrame(_Plrs[plr_name].Character.HumanoidRootPart)
    else
        print("[Output-Teleportation]: " .. plr_name .. " does not exist a humanoidrootpart!")
    end
end

Modules.B64Encode_Input = function(data : String)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    --local b = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん'
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
 
Modules.B64Decode_Input = function(data : String)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    --local b = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん'
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
