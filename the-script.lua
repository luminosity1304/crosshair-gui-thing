local RunService=game:GetService("RunService")

getgenv().Cross={Enabled=true,Size=14,Gap=4,Thickness=2.5,Color=Color3.fromRGB(0,255,140),Dot=true}

local Presets={
    ["Classic +"]={Size=14,Gap=4,Dot=true},
    ["Clean Box"]={Size=14,Gap=0,Dot=false},
    ["Dot Only"]={Size=0,Gap=0,Dot=true},
    ["Small Cross"]={Size=8,Gap=3,Dot=false},
    ["Big Cross"]={Size=22,Gap=7,Dot=false}
}

local Lines={Drawing.new("Line"),Drawing.new("Line"),Drawing.new("Line"),Drawing.new("Line")}
local Dot=Drawing.new("Circle")

local function Update()
    local c=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)
    local s,g,t=Cross.Size,Cross.Gap,Cross.Thickness
    
    for _,v in Lines do v.Visible=false end
    Dot.Visible=false
    if not Cross.Enabled then return end
    
    if s>0 then
        Lines[1].Visible=true Lines[1].From=Vector2.new(c.X-s,c.Y) Lines[1].To=Vector2.new(c.X-g,c.Y)
        Lines[2].Visible=true Lines[2].From=Vector2.new(c.X+g,c.Y) Lines[2].To=Vector2.new(c.X+s,c.Y)
        Lines[3].Visible=true Lines[3].From=Vector2.new(c.X,c.Y-s) Lines[3].To=Vector2.new(c.X,c.Y-g)
        Lines[4].Visible=true Lines[4].From=Vector2.new(c.X,c.Y+g) Lines[4].To=Vector2.new(c.X,c.Y+s)
        for _,v in Lines do v.Color=Cross.Color v.Thickness=t v.Transparency=1 end
    end
    
    if Cross.Dot then
        Dot.Visible=true Dot.Position=c Dot.Radius=t Dot.Color=Cross.Color Dot.Filled=true Dot.Transparency=1
    end
    
    if Cross.Gap==0 and not Cross.Dot and s>0 then
        local b=s
        Lines[1].From=Vector2.new(c.X-b,c.Y-b) Lines[1].To=Vector2.new(c.X+b,c.Y-b)
        Lines[2].From=Vector2.new(c.X+b,c.Y-b) Lines[2].To=Vector2.new(c.X+b,c.Y+b)
        Lines[3].From=Vector2.new(c.X+b,c.Y+b) Lines[3].To=Vector2.new(c.X-b,c.Y+b)
        Lines[4].From=Vector2.new(c.X-b,c.Y+b) Lines[4].To=Vector2.new(c.X-b,c.Y-b)
    end
end

local sg=Instance.new("ScreenGui",game.CoreGui)
local m=Instance.new("Frame",sg)
m.Size=UDim2.new(0,280,0,360)m.Position=UDim2.new(0,15,0,15)m.BackgroundColor3=Color3.fromRGB(22,22,28)m.Active=true m.Draggable=true
Instance.new("UICorner",m).CornerRadius=UDim.new(0,12)

local t=Instance.new("TextLabel",m)
t.Size=UDim2.new(1,0,0,45)t.BackgroundColor3=Color3.fromRGB(0,170,255)t.Text="XENO CROSSHAIR"t.TextColor3=Color3.new(1,1,1)t.Font=Enum.Font.GothamBold t.TextSize=20

local tog=Instance.new("TextButton",m)
tog.Size=UDim2.new(0,240,0,50)tog.Position=UDim2.new(0,20,0,60)tog.BackgroundColor3=Color3.fromRGB(0,220,100)tog.Text="DISABLE"tog.TextColor3=Color3.new(1,1,1)tog.Font=Enum.Font.GothamBold
Instance.new("UICorner",tog).CornerRadius=UDim.new(0,10)

tog.MouseButton1Click:Connect(function()
    Cross.Enabled=not Cross.Enabled
    tog.Text=Cross.Enabled and "DISABLE" or "ENABLE"
    tog.BackgroundColor3=Cross.Enabled and Color3.fromRGB(0,220,100) or Color3.fromRGB(255,50,50)
    Update()
end)

local y=130
for n,p in pairs(Presets)do
    local b=Instance.new("TextButton",m)
    b.Size=UDim2.new(0,240,0,45)b.Position=UDim2.new(0,20,0,y)b.BackgroundColor3=Color3.fromRGB(45,45,55)b.Text=n b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.Gotham
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        Cross.Size=p.Size Cross.Gap=p.Gap Cross.Dot=p.Dot Update()
    end)
    y=y+55
end

RunService.RenderStepped:Connect(Update)
Update()
