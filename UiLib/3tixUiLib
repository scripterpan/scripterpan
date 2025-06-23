local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))() 
  local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()

  local main = lib:Load({
      Title = 'Cool Title',
      ToggleButton = "RBXID or GetCustomasset",
	  BindGui = Enum.KeyCode.RightControl,
  })

  local Main = main:AddTab("Main")
  main:SelectTab()

  local MainSection = Main:AddSection({Title = "Section Name", Description = "Description", Defualt = false , Locked = false})
  local GroupButtons =   MainSection:AddGroupButton()

  GroupButtons:AddButton({
    Title = "Print Woah",
    Callback = function()
    print("Woah")
    end,
  })
  GroupButtons:AddButton({
    Title = "Print Woah2",
    Variant = "Outline",
    Callback = function()
    print("Woah2")
    end,
  })
  MainSection:AddParagraph({Title = "Hello There",Description = "HI"})

  MainSection:AddToggle("ConfigToStoreName", {
    Title = "Toggle",
    Default = false,
    Description = "lol",
    Callback = function(isEnabled)
      print(isEnabled)
    end,
  })

MainSection:AddDropdown("EpicDropDownName", {
    Title = "Dropdown",
    Description = "",
    Options = {"Option1","Option2","Option3","Option4","Option5","Option6","Option7",},
    Default = "",
    PlaceHolder = "Search Name",
    Multiple = true,
    Callback = function(balls)
        table.foreach(balls,print)
    end
})

MainSection:AddColorpicker("Color", {
    Title = "ColorPicker",
    Default = Color3.new(1.000000, 1.000000, 1.000000),
    Callback = function(selectedColor)
        print(selectedColor)
    end,
})

MainSection:AddSlider("EpixSlider", {
    Title = "Cool-Slider",
    Description = "",
    Default = 15,
    Min = 0,
    Max = 255,
    Increment = 1,
    Callback = function(value)
      print(value)
    end,
})

MainSection:AddButton({
	Title = "Open Dialog",
	Callback = function()
	lib:Dialog({
    Title = "Hello",
    Content = "Test",
    Buttons = {
        {
            Title = "Test",
            Variant = "Primary",
            Callback = function(value)
                print(3)
            end,
        },
		{
            Title = "Test2",
            Variant = "Ghost",
            Callback = function(value)
                print(32)
            end,
        }
    }
})
end,
})

MainSection:AddBind("JumpKeybind", {
    Title = "Jump",
    Default = Enum.KeyCode.Space,
    Callback = function() print("Pressed") end
})


MainSection:AddTextbox({
    Title = "Textbox",
    Default = "",
    Description = "Hello!",
    PlaceHolder = "PlaceHolder",
    TextDisappear = false,
    Callback = function(value)
        print(Value)
    end
})

local Config = main:AddTab("Config")
FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Config/GameName")
FlagsManager:InitSaveSystem(Config)

lib:Notification('Hello', 'Hello, Thanks for using 3itx-UI-Lib',3)
