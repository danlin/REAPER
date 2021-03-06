--[[
################################################################################
# 
# Copyright (c) 2014-2017 Ultraschall (http://ultraschall.fm)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
################################################################################
]]
 

-- Print Message to console (debugging)
function Msg(val)
  reaper.ShowConsoleMsg(tostring(val).."\n")
end

------------------------------------------------------
-- Open a URL in a browser - OS agnostic
------------------------------------------------------
function open_url(url)
  
  local OS=reaper.GetOS()
  if OS=="OSX32" or OS=="OSX64" then
  	os.execute("open ".. url)
  else
  	os.execute("start ".. url)
  end
end

------------------------------------------------------
-- Open a info windows for cut & paste
------------------------------------------------------
function open_info(msg, title)

		type = 0
		result = reaper.ShowMessageBox( msg, title, type )
end

------------------------------------------------------
-- Get Versions and return them as a table
------------------------------------------------------
function get_versions()

	local versionsTable = {}
	local versionItemsCount = tonumber(reaper.GetExtState("ultraschall_bom", "found_items"))  -- number of entrie
	if versionItemsCount and versionItemsCount > 0 then -- there are any items
		for i = 1, versionItemsCount, 1 do
			versionsTable[i] = reaper.GetExtState("ultraschall_bom", "item_"..tostring(i))
		end
	else
		open_info("There are parts of the ULTRASCHALL install missing.\n\nULTRASCHALL wil NOT work properly until you fix this.\n\nPlease check the installation guide on http://ultraschall.fm/install/","Ultraschall Configuration Problem")  -- Fehleranzeige hier
	end	
	return versionsTable
end

------------------------------------------------------
-- Build menu string from table
------------------------------------------------------
function build_menu(table)

	local menuString = "Version Check:||"
	for i, item in ipairs(table) do 
		menuString = menuString.."!"..item.."|"
	end
	return menuString
end

------------------------------------------------------
--	Getting the values of startscreen and updatecheck
------------------------------------------------------
function check_values()
	
	local startscreen
	local updatecheck

	startscreen = reaper.GetExtState("ultraschall_start", "startscreen")
	
	if GUI.Val("checkers")[1] == true  and startscreen == "0" then			-- ckeckbox is activated
		reaper.SetExtState("ultraschall_start", "startscreen", "1", true)
	elseif GUI.Val("checkers")[1] == false and startscreen == "1" then		-- ckeckbox is deactivated
		reaper.SetExtState("ultraschall_start", "startscreen", "0", true)
	end

	updatecheck = reaper.GetExtState("ultraschall_update", "update_check")
	
	if GUI.Val("checkers2")[1] == true  and updatecheck == "0" then			-- ckeckbox is activated
		reaper.SetExtState("ultraschall_update", "update_check", "1", true)
	elseif GUI.Val("checkers2")[1] == false and updatecheck == "1" then		-- ckeckbox is deactivated
		reaper.SetExtState("ultraschall_update", "update_check", "0", true)
	end

end

------------------------------------------------------
--	Show the GUI menu item
------------------------------------------------------
function show_menu(str)
		
	gfx.x, gfx.y = GUI.mouse.x, GUI.mouse.y
	selectedMenu = gfx.showmenu(str)
	return selectedMenu

end


------------------------------------------------------
--	End of functions
------------------------------------------------------


-- Grab all of the functions and classes from our GUI library

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
GUI = dofile(script_path .. "ultraschall_gui_lib.lua")

---- Window settings and user functions ----

GUI.name = "Ultraschall 3"
GUI.w, GUI.h = 680, 415

------------------------------------------------------
-- position always in the center of the screen
------------------------------------------------------

l, t, r, b = 0, 0, GUI.w, GUI.h
__, __, screen_w, screen_h = reaper.my_getViewport(l, t, r, b, l, t, r, b, 1)
GUI.x, GUI.y = (screen_w - GUI.w) / 2, (screen_h - GUI.h) / 2




	-- body
	---- GUI Elements ----
	
GUI.elms = {
	
--     name          = element type          x      y    w    h     caption               ...other params...
	logo			= GUI.Pic:new(			240,10, 0, 0, 1, script_path.."us.png"),
	label           = GUI.Lbl:new(          165,  160,               "Ultraschall 3.0.3 - Miedinger - was successfully installed.", 0),
	label2           = GUI.Lbl:new(          135,  220,               "Visit the Podcast menu to explore the user interface and features.", 0),
	label3           = GUI.Lbl:new(          210,  240,               "Use Project templates for a quick setup.", 0),
	label4           = GUI.Lbl:new(          265,  290,               "If you need assistance:", 0),
	checkers      = GUI.Checklist:new(     20, 380, 240, 30,      "", "Show this Screen on Start", 4),
	checkers2      = GUI.Checklist:new(     405, 380, 240, 30,      "", "Automatically check for updates", 4),
	tutorials      	= GUI.Btn:new(          30, 320, 190, 40,      "Tutorials", open_url, "http://ultraschall.fm/tutorials/"),
	twitter      	= GUI.Btn:new(          242, 320, 190, 40,      "Twitter", open_url, "https://twitter.com/ultraschall_fm"),
	forum      		= GUI.Btn:new(          455, 320, 190, 40,      "Userforum", open_url, "https://sendegate.de/c/ultraschall"),
}


versionsTable = get_versions()
version_items = build_menu(versionsTable)
GUI.elms.versions  = GUI.Btn:new(          276, 185, 120, 24,      " Show Details", show_menu, version_items)

-- open_info(build_info(versionsTable),"Version Info for cut & paste")

-- Version check:||!Ultraschall REAPER Extension 3.0.3|!Ultraschall REAPER Theme 3.0.3|#UltraschallHub 1.0.1|!Ultraschall Soundboard 3.0.0|#StudioLink Plug-in 16.12.0|!StudioLink OnAir Plug-in 17.02.1|!LAME MP3 Encoder 3.98.3|!SWS REAPER Extension 2.8.8|>REAPER 5.35|<REAPER 5.40 available||Copy to clipboard


---- Put all of your own functions and whatever here ----

if reaper.GetExtState("ultraschall_start", "startscreen") == "1" then
	GUI.Val("checkers",true)
end

if reaper.GetExtState("ultraschall_update", "update_check") == "1" then
	GUI.Val("checkers2",true)
end

GUI.func = check_values
GUI.freq = 0


GUI.Init()
GUI.Main()
