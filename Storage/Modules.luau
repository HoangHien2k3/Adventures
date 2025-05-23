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

return Modules
