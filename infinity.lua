local lunar = {}
lunar.gs = {}


lunar.theme = { -- light
	main_container = Color3.fromRGB(249, 249, 255),
	separator_color = Color3.fromRGB(223, 219, 228),

	text_color = Color3.fromRGB(96, 96, 96),

	category_button_background = Color3.fromRGB(223, 219, 228),
	category_button_border = Color3.fromRGB(200, 196, 204),

	checkbox_checked = Color3.fromRGB(114, 214, 112),
	checkbox_outer = Color3.fromRGB(198, 189, 202),
	checkbox_inner = Color3.fromRGB(249, 239, 255),

	slider_color = Color3.fromRGB(114, 214, 112),
	slider_background = Color3.fromRGB(198, 188, 202),
	slider_text = Color3.fromRGB(112, 112, 112),

	textbox_background = Color3.fromRGB(198, 189, 202),
	textbox_background_hover = Color3.fromRGB(215, 206, 227),
	textbox_text = Color3.fromRGB(112, 112, 112),
	textbox_text_hover = Color3.fromRGB(50, 50, 50),
	textbox_placeholder = Color3.fromRGB(178, 178, 178),

	dropdown_background = Color3.fromRGB(198, 189, 202),
	dropdown_text = Color3.fromRGB(112, 112, 112),
	dropdown_text_hover = Color3.fromRGB(50, 50, 50),
	dropdown_scrollbar_color = Color3.fromRGB(198, 189, 202),
}
lunar.dark_theme = { -- dark
	main_container = Color3.fromRGB(32, 32, 33),
	separator_color = Color3.fromRGB(63, 63, 65),

	text_color = Color3.fromRGB(206, 206, 206),

	category_button_background = Color3.fromRGB(63, 62, 65),
	category_button_border = Color3.fromRGB(72, 71, 74),

	checkbox_checked = Color3.fromRGB(177, 177, 177),
	checkbox_outer = Color3.fromRGB(84, 81, 86),
	checkbox_inner = Color3.fromRGB(132, 132, 136),

	slider_color = Color3.fromRGB(177, 177, 177),
	slider_background = Color3.fromRGB(88, 84, 90),
	slider_text = Color3.fromRGB(177, 177, 177),

	textbox_background = Color3.fromRGB(103, 103, 106),
	textbox_background_hover = Color3.fromRGB(137, 137, 141),
	textbox_text = Color3.fromRGB(195, 195, 195),
	textbox_text_hover = Color3.fromRGB(232, 232, 232),
	textbox_placeholder = Color3.fromRGB(135, 135, 138),

	dropdown_background = Color3.fromRGB(88, 88, 91),
	dropdown_text = Color3.fromRGB(195, 195, 195),
	dropdown_text_hover = Color3.fromRGB(232, 232, 232),
	dropdown_scrollbar_color = Color3.fromRGB(118, 118, 121),
}

setmetatable(lunar.gs, {
	__index = function(_, service)
		return game:GetService(service)
	end,
	__newindex = function(t, i)
		t[i] = nil
		return
	end
})


local mouse = lunar.gs["Players"].LocalPlayer:GetMouse()

function lunar:Create(class, properties)
	local object = Instance.new(class)

	for prop, val in next, properties do
		if object[prop] and prop ~= "Parent" then
			object[prop] = val
		end
	end

	return object
end

function lunar:addShadow(object, transparency)
	local shadow = self:Create("ImageLabel", {
		Name = "Shadow",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 4),
		Size = UDim2.new(1, 6, 1, 6),
		Image = "rbxassetid://1316045217",
		ImageTransparency = transparency and true or 0.5,
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(10, 10, 118, 118)
	})

	shadow.Parent = object
end

function lunar.new(isdark)
	local lunarObject = {}
	local self2 = lunarObject
	local self = lunar

	if self.gs["CoreGui"]:FindFirstChild("Lunar") then
		warn("lunar:", "instance already exists in coregui!")
		
		return
	end

	local theme = lunar.theme

	if isdark == true then theme = lunar.dark_theme end

	local toggled = true
	local typing = false
	local firstcat = false

	local lunarData
	lunarData = {
		UpConnection = nil,
		ToggleKey = Enum.KeyCode.Home,
	}

	self2.ChangeToggleKey = function(NewKey)
		lunarData.ToggleKey = NewKey
		self2.tip.Text = "Press '".. string.sub(tostring(NewKey), 14) .."' to hide this menu"

		if lunarData.UpConnection then
			lunarData.UpConnection:Disconnect()
		end

		lunarData.UpConnection = lunar.gs["UserInputService"].InputEnded:Connect(function(Input)
			if Input.KeyCode == lunarData.ToggleKey and not typing then
				toggled = not toggled

				if toggled then
					self2.container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
				else
					self2.container:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Sine", 0.5, true)
				end
			end
		end)
	end

	lunarData.UpConnection = lunar.gs["UserInputService"].InputEnded:Connect(function(Input)
		if Input.KeyCode == lunarData.ToggleKey and not typing then
			toggled = not toggled

			if toggled then
				self2.container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
			else
				self2.container:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Sine", 0.5, true)
			end
		end
	end)

	self2.userinterface = self:Create("ScreenGui", {
		Name = "Lunar",
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		ResetOnSpawn = false,
	})

	self2.container = self:Create("Frame", {
		Draggable = true,
		Active = true,
		Name = "Container",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 0,
		BackgroundColor3 = theme.main_container,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 800, 0, 500),
		ZIndex = 2
	})

	self2.container.Draggable = true
	self2.container.Active = true

	self2.sidebar = self:Create("Frame", {
		Name = "Sidebar",
		BackgroundColor3 = Color3.new(0.976471, 0.937255, 1),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.new(0.745098, 0.713726, 0.760784),
		Size = UDim2.new(0, 120, 1, -30),
		Position = UDim2.new(0, 0, 0, 30),
		ZIndex = 2,
	})

	self2.categories = self:Create("Frame", {
		Name = "Categories",
		BackgroundColor3 = Color3.new(0.976471, 0.937255, 1),
		ClipsDescendants = true,
		BackgroundTransparency = 1,
		BorderColor3 = Color3.new(0.745098, 0.713726, 0.760784),
		Size = UDim2.new(1, -120, 1, -30),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 30),
		ZIndex = 2,
	})
	self2.categories.ClipsDescendants = true

	self2.topbar = self:Create("Frame", {
		Name = "Topbar",
		ZIndex = 2,
		Size = UDim2.new(1,0,0,30),
		BackgroundTransparency = 2
	})

	self2.tip = self:Create("TextLabel", {
		Name = "TopbarTip",
		ZIndex = 2,
		Size = UDim2.new(1, -30, 0, 30),
		Position = UDim2.new(0, 30, 0, 0),
		Text = "Press '".. string.sub(tostring(self.ToggleKey), 14) .."' to hide this menu",
		Font = Enum.Font.GothamSemibold,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		TextColor3 = theme.text_color,
	})

	local separator = self:Create("Frame", {
		Name = "Separator",
		BackgroundColor3 = theme.separator_color,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 118, 0, 30),
		Size = UDim2.new(0, 1, 1, -30),
		ZIndex = 6,
	})
	separator.Parent = self2.container
	separator = nil

	local separator = self:Create("Frame", {
		Name = "Separator",
		BackgroundColor3 = theme.separator_color,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 30),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 6,
	})
	separator.Parent = self2.container
	separator = nil

	local uipagelayout = self:Create("UIPageLayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Vertical,
		TweenTime = 0.7,
		EasingStyle = Enum.EasingStyle.Quad,
		EasingDirection = Enum.EasingDirection.InOut,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	uipagelayout.Parent = self2.categories
	uipagelayout = nil

	local uipadding = self:Create("UIPadding", {
		PaddingTop = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 2)
	})
	uipadding.Parent = self2.sidebar
	uipadding = nil

	local uilistlayout = self:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	uilistlayout.Parent = self2.sidebar
	uilistlayout = nil

	function self2:Category(name)
		local category = {}

		category.button = lunar:Create("TextButton", {
			Name = name,
			BackgroundColor3 = theme.category_button_background,
			BackgroundTransparency = 1,
			BorderMode = Enum.BorderMode.Inset,
			BorderColor3 = theme.category_button_border,
			Size = UDim2.new(1, -4, 0, 25),
			ZIndex = 2,
			AutoButtonColor = false,
			Font = Enum.Font.GothamSemibold,
			Text = name,
			TextColor3 = theme.text_color,
			TextSize = 14
		})

		category.container = lunar:Create("ScrollingFrame", {
			Name = name,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 2,
			CanvasSize = UDim2.new(0, 0, 0, 0)
		})

		category.hider = lunar:Create("Frame", {
			Name = "Hider",
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = theme.main_container,
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 5
		})

		category.L = lunar:Create("Frame", {
			Name = "L",
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 0, 5),
			Size = UDim2.new(0.5, -20, 1, -5),
			ZIndex = 2
		})

		category.R = lunar:Create("Frame", {
			Name = "R",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -10, 0, 5),
			Size = UDim2.new(0.5, -20, 1, -5),
			ZIndex = 2
		})

		local uilistlayout = lunar:Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		uilistlayout.Parent = category.L
		uilistlayout = nil

		local uilistlayout = lunar:Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		uilistlayout.Parent = category.R
		uilistlayout = nil

		category.button.MouseEnter:Connect(function()
			lunar.gs["TweenService"]:Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
		end)
		category.button.MouseLeave:Connect(function()
			lunar.gs["TweenService"]:Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)
		category.button.MouseButton1Down:Connect(function()
			for _, categoryf in next, self2.userinterface["Container"]["Categories"]:GetChildren() do
				if categoryf:IsA("ScrollingFrame") then
					if categoryf ~= category.container then
						lunar.gs["TweenService"]:Create(categoryf.Hider, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
					end
				end
			end

			lunar.gs["TweenService"]:Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
			lunar.gs["TweenService"]:Create(category.hider, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()

			self2.categories["UIPageLayout"]:JumpTo(category.container)
		end)
		category.button.MouseButton1Up:Connect(function()
			lunar.gs["TweenService"]:Create(category.button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)

		category.container.Parent = self2.categories
		category.button.Parent = self2.sidebar
		category.R.Parent = category.container
		category.L.Parent = category.container
		category.hider.Parent = category.container

		local function calculateSector()
			local R = #category.R:GetChildren() - 1
			local L = #category.L:GetChildren() - 1

			if L > R then
				return "R"
			else
				return "L"
			end
		end

		function category:Sector(name)
			local sector = {}

			sector.frame = lunar:Create("Frame", {
				Name = name,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 25),
				ZIndex = 2
			})

			sector.container = lunar:Create("Frame", {
				Name = "Container",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 22),
				Size = UDim2.new(1, -5, 1, -30),
				ZIndex = 2
			})

			sector.title = lunar:Create("TextLabel", {
				Name = "Title",
				Text = name,
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -5, 0, 25),
				ZIndex = 2,
				Font = Enum.Font.GothamSemibold,
				TextColor3 = theme.text_color,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
			})

			local uilistlayout = lunar:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			uilistlayout.Changed:Connect(function()
				sector.frame.Size = UDim2.new(1, 0, 0, sector.container["UIListLayout"].AbsoluteContentSize.Y + 25)
				sector.container.Size = UDim2.new(1, 0, 0, sector.container["UIListLayout"].AbsoluteContentSize.Y)
			end)
			uilistlayout.Parent = sector.container
			uilistlayout = nil

			function sector:Cheat(kind, name, callback, data)
				local cheat = {}
				cheat.value = nil

				cheat.frame = lunar:Create("Frame", {
					Name = name,
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 25),
					ZIndex = 2,
				})

				cheat.label = lunar:Create("TextLabel", {
					Name = "Title",
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					Font = Enum.Font.Gotham,
					TextColor3 = theme.text_color,
					TextSize = 13,
					Text = name,
					TextXAlignment = Enum.TextXAlignment.Left
				})

				cheat.container	= lunar:Create("Frame", {
					Name = "Container",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 150, 0, 22),
					ZIndex = 2,
				})
				
				if kind then
					if string.lower(kind) == "checkbox" then
						if data then
							if data.enabled then
								cheat.value = true
							end
						end

						cheat.checkbox = lunar:Create("Frame", {
							Name = "Checkbox",
							AnchorPoint = Vector2.new(1, 0),
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(1, 0, 0, 0),
							Size = UDim2.new(0, 25, 0, 25),
							ZIndex = 2,
						})

						cheat.outerbox = lunar:Create("ImageLabel", {
							Name = "Outer",
							AnchorPoint = Vector2.new(1, 0.5),
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(0, 20, 0, 20),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.checkbox_outer,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.06,
						})

						cheat.checkboxbutton = lunar:Create("ImageButton", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Name = "CheckboxButton",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(0, 14, 0, 14),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.checkbox_inner,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.04
						})

						if data then
							if data.enabled then
								lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
								lunar.gs["TweenService"]:Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
							end
						end

						cheat.checkboxbutton.MouseEnter:Connect(function()
							local lightertheme = Color3.fromRGB((theme.checkbox_outer.R * 255) + 20, (theme.checkbox_outer.G * 255) + 20, (theme.checkbox_outer.B * 255) + 20)
							lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = lightertheme}):Play()
						end)
						cheat.checkboxbutton.MouseLeave:Connect(function()
							if not cheat.value then
								lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
							else
								lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
							end
						end)
						cheat.checkboxbutton.MouseButton1Down:Connect(function()
							if cheat.value then
								lunar.gs["TweenService"]:Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
							else
								lunar.gs["TweenService"]:Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
							end
						end)
						cheat.checkboxbutton.MouseButton1Up:Connect(function()
							cheat.value = not cheat.value

							if callback then
								local s, e = pcall(function()
									callback(cheat.value)
								end)

								if not s then warn("error: ".. e) end
							end

							if cheat.value then
								lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_checked}):Play()
							else
								lunar.gs["TweenService"]:Create(cheat.outerbox, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_outer}):Play()
								lunar.gs["TweenService"]:Create(cheat.checkboxbutton, TweenInfo.new(0.2), {ImageColor3 = theme.checkbox_inner}):Play()
							end
						end)

						cheat.checkboxbutton.Parent = cheat.outerbox
						cheat.outerbox.Parent = cheat.container
					elseif string.lower(kind) == "dropdown" then
						if data then
							if data.default then
								cheat.value = data.default
							elseif data.options then
								cheat.value = data.options[1]
							else
								cheat.value = "None"
							end
						end

						cheat.dropped = false

						cheat.dropdown = lunar:Create("ImageButton", {
							Name = "Dropdown",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.dropdown_background,
							ImageTransparency = 0.5,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.02
						})

						cheat.selected = lunar:Create("TextLabel", {
							Name = "Selected",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 10, 0, 0),
							Size = UDim2.new(1, -35, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = tostring(cheat.value),
							TextColor3 = theme.dropdown_text,
							TextSize = 13,
							TextXAlignment = Enum.TextXAlignment.Left
						})

						cheat.list = lunar:Create("ScrollingFrame", {
							Name = "List",
							BackgroundColor3 = theme.dropdown_background,
							BackgroundTransparency = 0.5,
							BorderSizePixel = 0,
							Position = UDim2.new(0, 0, 1, 0),
							Size = UDim2.new(1, 0, 0, 100),
							ZIndex = 3,
							BottomImage = "rbxassetid://967852042",
							MidImage = "rbxassetid://967852042",
							TopImage = "rbxassetid://967852042",
							ScrollBarThickness = 4,
							VerticalScrollBarInset = Enum.ScrollBarInset.None,
							ScrollBarImageColor3 = theme.dropdown_scrollbar_color
						})

						local uilistlayout = lunar:Create("UIListLayout", {
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 2)
						})
						uilistlayout.Parent = cheat.list
						uilistlayout = nil
						local uipadding = lunar:Create("UIPadding", {
							PaddingLeft = UDim.new(0, 2)
						})
						uipadding.Parent = cheat.list
						uipadding = nil

						for _, value in next, data.options do
							local button = lunar:Create("TextButton", {
								BackgroundColor3 = Color3.new(1, 1, 1),
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 20),
								ZIndex = 3,
								Font = Enum.Font.Gotham,
								Text = value,
								TextColor3 = theme.dropdown_text,
								TextSize = 13
							})

							button.Parent = cheat.list

							button.MouseEnter:Connect(function()
								lunar.gs["TweenService"]:Create(button, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text_hover}):Play()
							end)
							button.MouseLeave:Connect(function()
								lunar.gs["TweenService"]:Create(button, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text}):Play()
							end)
							button.MouseButton1Click:Connect(function()
								if cheat.dropped then
									cheat.value = value
									cheat.selected.Text = value

									cheat.fadelist()
									
									if callback then
										local s, e = pcall(function()
											callback(cheat.value)
										end)

										if not s then warn("error: ".. e) end
									end
								end
							end)
						end

						lunar.gs["TweenService"]:Create(cheat.list, TweenInfo.new(0), {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, cheat.list["UIListLayout"].AbsoluteContentSize.Y), ScrollBarImageTransparency = 1, BackgroundTransparency = 1}):Play()

						for _, button in next, cheat.list:GetChildren() do
							if button:IsA("TextButton") then
								lunar.gs["TweenService"]:Create(button, TweenInfo.new(0), {TextTransparency = 1}):Play()
							end
						end

						function cheat.fadelist()
							cheat.dropped = not cheat.dropped

							if cheat.dropped then
								for _, button in next, cheat.list:GetChildren() do
									if button:IsA("TextButton") then
										lunar.gs["TweenService"]:Create(button, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
									end
								end

								lunar.gs["TweenService"]:Create(cheat.list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.clamp(cheat.list["UIListLayout"].AbsoluteContentSize.Y, 0, 150)), Position = UDim2.new(0, 0, 1, 0), ScrollBarImageTransparency = 0, BackgroundTransparency = 0.5}):Play()
							else
								for _, button in next, cheat.list:GetChildren() do
									if button:IsA("TextButton") then
										lunar.gs["TweenService"]:Create(button, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
									end
								end

								lunar.gs["TweenService"]:Create(cheat.list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), ScrollBarImageTransparency = 1, BackgroundTransparency = 1}):Play()
							end
						end

						cheat.dropdown.MouseEnter:Connect(function()
							lunar.gs["TweenService"]:Create(cheat.selected, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text_hover}):Play()
						end)
						cheat.dropdown.MouseLeave:Connect(function()
							lunar.gs["TweenService"]:Create(cheat.selected, TweenInfo.new(0.1), {TextColor3 = theme.dropdown_text}):Play()
						end)
						cheat.dropdown.MouseButton1Click:Connect(function()
							cheat.fadelist()
						end)

						cheat.selected.Parent = cheat.dropdown
						cheat.dropdown.Parent = cheat.container
						cheat.list.Parent = cheat.container
					elseif string.lower(kind) == "textbox" then

						local placeholdertext = data and data.placeholder

						cheat.background = lunar:Create("ImageLabel", {
							Name = "Background",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.textbox_background,
							ImageTransparency = 0.5,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.02
						})

						cheat.textbox = lunar:Create("TextBox", {
							Name = "Textbox",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							Text = "",
							TextColor3 = theme.textbox_text,
							PlaceholderText = placeholdertext or "Value",
							TextSize = 13,
							TextXAlignment = Enum.TextXAlignment.Center
						})

						cheat.background.MouseEnter:Connect(function()
							lunar.gs["TweenService"]:Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text_hover}):Play()
						end)
						cheat.background.MouseLeave:Connect(function()
							lunar.gs["TweenService"]:Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text}):Play()
						end)
						cheat.textbox.Focused:Connect(function()
							typing = true

							lunar.gs["TweenService"]:Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.textbox_background_hover}):Play()
						end)
						cheat.textbox.FocusLost:Connect(function()
							typing = false

							lunar.gs["TweenService"]:Create(cheat.background, TweenInfo.new(0.2), {ImageColor3 = theme.textbox_background}):Play()
							lunar.gs["TweenService"]:Create(cheat.textbox, TweenInfo.new(0.1), {TextColor3 = theme.textbox_text}):Play()

							cheat.value = cheat.textbox.Text

							if callback then
								local s, e = pcall(function()
									callback(cheat.value)
								end)

								if not s then warn("error: "..e) end
							end
						end)

						cheat.background.Parent = cheat.container
						cheat.textbox.Parent = cheat.container
					elseif string.lower(kind) == "slider" then
						cheat.value = 0

						local suffix = data.suffix or ""
						local minimum = data.min or 0
						local maximum = data.max or 1
						
						local moveconnection
						local releaseconnection

						cheat.sliderbar = lunar:Create("ImageButton", {
							Name = "Sliderbar",
							AnchorPoint = Vector2.new(1, 0.5),
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 0, 6),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.slider_background,
							ImageTransparency = 0.5,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.02,
						})

						cheat.numbervalue = lunar:Create("TextLabel", {
							Name = "Value",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.5, 5, 0.5, 0),
							Size = UDim2.new(1, 0, 0, 13),
							ZIndex = 2,
							Font = Enum.Font.Gotham,
							TextXAlignment = Enum.TextXAlignment.Left,
							Text = "",
							TextTransparency = 1,
							TextColor3 = theme.slider_text,
							TextSize = 13,
						})

						cheat.visiframe = lunar:Create("ImageLabel", {
							Name = "Frame",
							BackgroundColor3 = Color3.new(1, 1, 1),
							BackgroundTransparency = 1,
							Size = UDim2.new(0.5, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://3570695787",
							ImageColor3 = theme.slider_color,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(100, 100, 100, 100),
							SliceScale = 0.02
						})

						cheat.sliderbar.MouseButton1Down:Connect(function()
							local size = math.clamp(mouse.X - cheat.sliderbar.AbsolutePosition.X, 0, 150)
							local percent = size / 150

							cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100
							cheat.numbervalue.Text = tostring(cheat.value) .. suffix

							if callback then
								local s, e = pcall(function()
									callback(cheat.value)
								end)

								if not s then warn("error: ".. e) end
							end

							lunar.gs["TweenService"]:Create(cheat.visiframe, TweenInfo.new(0.1), {
								Size = UDim2.new(size / 150, 0, 1, 0),
								ImageColor3 = Color3.new(theme.slider_color.R, theme.slider_color.G - 0.1, theme.slider_color.B)
							}):Play()

							lunar.gs["TweenService"]:Create(cheat.numbervalue, TweenInfo.new(0.1), {
								Position = UDim2.new(size / 150, 5, 0.5, 0),
								TextTransparency = 0
							}):Play()

							moveconnection = mouse.Move:Connect(function()
								local size = math.clamp(mouse.X - cheat.sliderbar.AbsolutePosition.X, 0, 150)
								local percent = size / 150

								cheat.value = math.floor((minimum + (maximum - minimum) * percent) * 100) / 100
								cheat.numbervalue.Text = tostring(cheat.value) .. suffix

								if callback then
									local s, e = pcall(function()
										callback(cheat.value)
									end)

									if not s then warn("error: ".. e) end
								end

								lunar.gs["TweenService"]:Create(cheat.visiframe, TweenInfo.new(0.1), {
									Size = UDim2.new(size / 150, 0, 1, 0),
									ImageColor3 = Color3.new(theme.slider_color.R, theme.slider_color.G - 0.1, theme.slider_color.B)
								}):Play()

								lunar.gs["TweenService"]:Create(cheat.numbervalue, TweenInfo.new(0.1), {
									Position = UDim2.new(size / 150, 5, 0.5, 0),
									TextTransparency = 0
								}):Play()
							end)

							releaseconnection = lunar.gs["UserInputService"].InputEnded:Connect(function(Mouse)
								if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then

									lunar.gs["TweenService"]:Create(cheat.visiframe, TweenInfo.new(0.1), {
										ImageColor3 = theme.slider_color
									}):Play()

									lunar.gs["TweenService"]:Create(cheat.numbervalue, TweenInfo.new(0.1), {
										TextTransparency = 1
									}):Play()

									moveconnection:Disconnect()
									moveconnection = nil
									releaseconnection:Disconnect()
									releaseconnection = nil
								end
							end)
						end)

						cheat.visiframe.Parent = cheat.sliderbar
						cheat.numbervalue.Parent = cheat.sliderbar
						cheat.sliderbar.Parent = cheat.container
					end
				end


				cheat.frame.Parent = sector.container
				cheat.label.Parent = cheat.frame
				cheat.container.Parent = cheat.frame

				return cheat
			end

			sector.frame.Parent = category[calculateSector()]
			sector.container.Parent = sector.frame
			sector.title.Parent = sector.frame

			return sector
		end

		return category
	end

	self:addShadow(self2.container, 0)

	self2.categories.ClipsDescendants = true
	self2.userinterface.Parent = self.gs["CoreGui"]
	self2.container.Parent = self2.userinterface
	self2.categories.Parent = self2.container
	self2.sidebar.Parent = self2.container
	self2.topbar.Parent = self2.container
	self2.tip.Parent = self2.topbar

	return self2, lunarData
end

return lunar
