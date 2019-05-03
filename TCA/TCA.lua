-- TCA: The Classic Addon -- (c) 2019 moorea@ymail.com
-- Covered by the GNU General Public License version 3 (GPLv3)
-- NO WARRANTY
-- (contact the author if you need a different license)

if TCA == nil then
    -- create table/namespace for most of this addon state
    -- and functions (tcaSaved containing the rest)
    TCA = {};
end
  
  
TCA.debug = 1;

function TCA.Print(...)
	DEFAULT_CHAT_FRAME:AddMessage(...);
end

function TCA.Debug(msg)
    if TCA.debug == 1 then
       TCA.Print("TCA DBG: "..msg,0,1,0);
    end
end

function TCA.Help(msg) 
	TCA.Print("TCA: "..msg.."\n/tca help -- this message\n/tca config -- open config");
end
 
function TCA.Slash(arg)
    TCA.Debug("Called slash command, args: "..arg);
    if #arg == 0 then
	    TCA.Help("commands");
	    return;
    end
    TCA.Debug("/tca "..arg);
end

SlashCmdList["TCA_Slash_Command"] = TCA.Slash;

SLASH_TCA_Slash_Command1 = "/tca";
-- SLASH_TCA_Slash_Command2 = "/TheClassicAddon";

