-- TCA: The Classic Addon -- (c) 2019 moorea@ymail.com
-- Covered by the GNU General Public License version 3 (GPLv3)
-- NO WARRANTY
-- (contact the author if you need a different license)
--
if TCA == nil then
  -- create table/namespace for most of this addon state
  -- and functions (tcaSaved containing the rest)
  TCA = {}
end

TCA.debug = 1

function TCA.Print(...)
  DEFAULT_CHAT_FRAME:AddMessage(...)
end

function TCA.Debug(msg)
  if TCA.debug == 1 then
    TCA.Print("TCA DBG: " .. msg, 0, 0.4, 1)
  end
end

function TCA.Help(msg)
  TCA.Print("TCA: " .. msg ..
              "\n/tca help -- this message\n/tca config -- open config\n/tca save x -- saves x\n/tca test -- show saved")
end

function TCA.Test(msg)
  TCA.Debug("Called test: " .. msg)
  TCA.Init() -- temp hack
  TCA.Print("TCA: test saved is \"" .. tcaSave.test .. "\".")
end

function TCA.Save(msg)
  TCA.Debug("Called save: " .. msg)
  TCA.Print("TCA: saving!")
  TCA.Init() -- temp hack
  tcaSave.test = msg
end

TCA.subcmd = {["s"] = TCA.Save, ["t"] = TCA.Test}

function TCA.Slash(arg)
  TCA.Debug("Called slash command, args: " .. arg)
  if #arg == 0 then
    TCA.Help("commands")
    return
  end
  TCA.Debug("/tca " .. arg)
  local cmd = string.lower(string.sub(arg, 1, 1))
  local posRest = string.find(arg, " ")
  local rest = ""
  if not (posRest == nil) then
    rest = string.sub(arg, posRest + 1)
  end
  local funct = TCA.subcmd[cmd]
  if funct == nil then
    TCA.Help("unknown command " .. arg)
  else
    funct(rest)
  end
end

SlashCmdList["TCA_Slash_Command"] = TCA.Slash

SLASH_TCA_Slash_Command1 = "/tca"
-- SLASH_TCA_Slash_Command2 = "/TheClassicAddon"

TCA.first = 1

TCA.manifestVersion = GetAddOnMetadata("TCA", "Version")

function TCA.Init()
  TCA.Debug("Init() called.")
  if not (TCA.first == 1) then
    return
  end
  TCA.first = 0
  -- saved vars handling
  if tcaSave == nil then
    tcaSave = {}
    TCA.Print("Welcome to TCA: type \"/tca help\" for help")
    tcaSave.test = "saved"
    tcaSave.paused = 2
    tcaSave.version = TCA.manifestVersion
    tcaSave.revision = "@project-revision@"
  else
    if tcaSave.paused == 1 then
      TCA.Print("TCA is paused.")
    else
      TCA.Print("TCA loaded. Test saved: \"" .. tcaSave.test .. "\".")
    end
  end
  -- end save vars
end

TCA.Debug("TCA (re)loaded v" .. TCA.manifestVersion .. " (@project-version@ @project-revision@)")
