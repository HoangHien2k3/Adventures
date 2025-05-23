-- 《Service》 --
local _Ws = game:GetService("Workspace")
local _Plrs = game:GetService("Players")
local _StG = game:GetService("StarterGui")


-- 《Modules》 --
local Modules = {}

Modules.bringpart = function(name)
  for i, v in pairs(_Ws:GetDescendants()) do
    if v:IsA("BasePart") or v:IsA("Part") and v.Name == name then
      --local PPart = Instance.new("Part", v)
      --PPart.Name = "PrimaryPart"
      --v:SetPrimaryPartCFrame(_Plrs.LocalPlayer.Character.HumanoidRootPart)
      v.CFrame = CFrame.new(_Plrs.LocalPlayer.Character.HumanoidRootPart.Position)
    end
  end
end

Modules.countplayers = function()
  for i, v in pairs(_Plrs:GetPlayers()) do
    print("Player: " .. i .. ", Name: " .. v.DisplayName)
    return i
  end
end

Modules.notify = function(tl, txt)
  _StG:SetCore("SendNotification", {
      Title = tl,
      Text = txt,
      Duration = 1,
    })
end

return Modules
