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

is_new,name,sec,cmd,rel,res,val = reaper.get_action_context()
state = reaper.GetToggleCommandStateEx(sec, cmd)  				

ID_1 = reaper.NamedCommandLookup("_RSce49af5f20cf11dbd67253ac11a080128f9b4066") -- Setup Button
ID_2 = reaper.NamedCommandLookup("_RSd47a4eb6d422aceefc2f6832ff964664629f759a") -- Record Button
ID_3 = reaper.NamedCommandLookup("_RS69d065307828c966a95426bd6d8185812ff5248d") -- Edit Button
ID_4 = reaper.NamedCommandLookup("_RS55e62d69c6626960acc095ae9e3bd606c6bee9f6") -- Story Button


if state <= 0 then 												
	reaper.SetToggleCommandState(sec, cmd, 1)
end  

reaper.SetExtState("ultraschall_gui", "views", cmd, true)
reaper.SetExtState("ultraschall_gui", "sec", sec, true)

reaper.SetToggleCommandState(sec, ID_1, 0)
reaper.SetToggleCommandState(sec, ID_2, 0)
reaper.SetToggleCommandState(sec, ID_4, 0)


-- reaper.RefreshToolbar2(sec, ID_1)
-- reaper.RefreshToolbar2(sec, ID_2)
-- reaper.RefreshToolbar2(sec, ID_3)
-- reaper.RefreshToolbar2(sec, ID_4)
reaper.Main_OnCommand(40456,0) 	--(re)load Screenset

-- Msg(cmd)
-- Msg(ID_2)

-- state = reaper.GetToggleCommandStateEx(sec, cmd)
-- SetToggleCommandState(sec, cmd, state<=0?1:0);

