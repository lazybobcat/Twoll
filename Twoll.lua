--[[ ************************************
Twoll is a addon developped by Acacïa@Hyjal-EU
This addon replace some words or letters in your chat sentences in order to make you
speak like a troll.
You can modify it, without any guaranties, but please advertise me !
************************************ --]]

local rand
local TwollVersion = "0.4.2"

-- OnLoad fonction
function Twoll_OnLoad()
	-- Enterworld sentence
	Twoll.print("|cff5672ff>> Salut, mec ! Bienvenue suw Twoll ! /twoll pouw activer/d\195\169sactiver !|r");
	-- Hook the Blizzard's chat function
	hooksecurefunc('ChatEdit_ParseText',Twoll_ParseText);
	
	-- SLASH commands
	SLASH_Twoll1 = "/twoll"
	SLASH_Twoll2 = "/tw"
	SlashCmdList["Twoll"] = function(cmd, SubCmd)
		if (TwollActif == true) then
			TwollActif = false;
			TwollBoolActive = TwollActif;
			Twoll.print("Le langage Twoll est d\195\169sactiv\195\169 !");
		else
			TwollActif = true;
			TwollBoolActive = TwollActif;
			Twoll.print("Le langage Twoll est activ\195\169 !");
		end
	end
end


Twoll = {}

-- Fonctions pour envoyer un message au raid, groupe, wisp, etc...
-- Functions to send messages to group, raid, guild, etc..
function Twoll.guild(message)
	SendChatMessage(message, "guild")
	return 1
end

function Twoll.party(message)
	if GetNumPartyMembers() > 0 then
		SendChatMessage(message, "party")
		return 1
	end
end

function Twoll.raid(message)
	if GetNumRaidMembers() > 0 then
		SendChatMessage(message, "raid")
		return 1
	end
end

function Twoll.raidWarning(message)
	if (IsRaidLeader() or IsRaidOfficer()) or (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0) then
		SendChatMessage(message, "raid_warning")
		return 1
	end
end

function Twoll.yell(message)
	SendChatMessage(message, "yell")
	return 1
end

function Twoll.say(message)
	SendChatMessage(message, "say")
	return 1
end

function Twoll.wisp(message)
	if (UnitName('target') == nil) then
		return 1
	end
	SendChatMessage(message, "WHISPER", nil, UnitName("target"));
	return 1
end

function Twoll.print(message)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffffff"..message.."|r")
	return 1
end

--------------------------------------------------------------------
--------------------------------------------------------------------


function Twoll_ParseText(chatEntry, send)
     -- This function actually gets called every time the user hits a key. But the
     -- send flag will only be set when he hits return to send the message.
     if (send == 1) then
        local text = chatEntry:GetText(); -- Here's how you get the original text
        local newText = text;             -- here's where you can modify the text to your liking
        chatEntry:SetText( newText );     -- send the new text back to the UI
		
		if ((TwollActif == true) and (string.find(text, "|") == nil) and (text ~= "")) then
			
			rand = math.random(1,3)
			
			-- Regexes : modifying the message entered
			text = string.gsub( text, "âme", "mojo");
			text = string.gsub( text, "jean", "Vol'jean");
			text = string.gsub( text, "rr", "w");
			
			if (rand == 2) then
				text = string.gsub( text, "r([^%s,;?!])", "'w%1");
				text = string.gsub( text, "R([^%s,;?!])", "'W%1");
			elseif (rand == 3) then
				text = string.gsub( text, "r([^%s,;?!])", "'w%1");
				text = string.gsub( text, "R([^%s,;?!])", "'w%1");
			else
				text = string.gsub( text, "r([^%s,;?!])", "w%1");
				text = string.gsub( text, "R([^%s,;?!])", "W%1");
			end
			
			-- Random for twoll, guy !
			if ((string.find(text, "mec") == nil) and (string.find(text, "[!]"))) then
				text = string.gsub( text, "!", ", mec !");
			end
			
		end
		
		-- send the new text on the canal !
		chatEntry:SetText( text );
		
		-- Sound when the caracter laugh
		if (string.find(text, "lol") ~= nil or string.find(text, "mdw") ~= nil) then
			PlaySoundFile("Sound\\Character\\Troll\\TrollMaleLaugh01.wav");
		end
		
		-- Sound when the caracter emote
		if (string.find(text, "bonjour") ~= nil or string.find(text, "salut") ~= nil) then
			PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleHello01.wav");
		end
     end
 end
--[[   SOUND DATABASE

PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemalePissed01.wav") --halaine f
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemalePissed05.wav") --Canibalisme f
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleThankYou02.wav") --Merci f
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleYes03.wav") -- OUAIS ! f
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleHello01.wav") -- Bonjour
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleHello02.wav") -- Bonjour
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleHello03.wav") -- Bonjour
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleGoodbye01.wav") -- Au revoir
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleGoodbye02.wav") -- Au revoir
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalFemale\\TrollFemaleGoodbye03.wav") -- Au revoir


PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMalePissed01.wav") --halaine m
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMalePissed05.wav") --Canibalisme m
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleThankYou02.wav") --Merci m
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMmaleYes03.wav") -- OUAIS ! m
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleHello01.wav")
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleHello02.wav")
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleHello03.wav")

PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleGoodbye01.wav")
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleGoodbye02.wav")
PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleGoodbye03.wav")


--]]


SampleTrackerFunctions = { }

SampleTracker = CreateFrame("Frame", "TwollFrame2", UIParent)
SampleTracker:RegisterEvent("ADDON_LOADED")
SampleTracker:RegisterEvent("ACHIEVEMENT_EARNED")
SampleTracker:RegisterEvent("PLAYER_UNGHOST")
SampleTracker:SetScript("OnEvent", function(self, event, ...)
	rand = math.random(1,3)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9=...;
	if event == "ADDON_LOADED" and arg1 == "Twoll" then
		if (TwollBoolActive == false) then
			TwollActif = false;
		else
			TwollActif = true;
		end
		TwollBoolActive = TwollActif;
	elseif event == "ACHIEVEMENT_EARNED" then
		if TwollActif == true then
			PlaySoundFile("Sound\\Character\\Troll\\TrollVocalMale\\TrollMaleCongratulations01.wav");
			if rand == 1 then
				Twoll.guild("Livwez vous au Voodoo !");
			end
		end
	elseif event == "PLAYER_UNGHOST" then
		if ((rand == 1) and (TwollActif == true)) then
			Twoll.say("Continuez et \195\167a va bawder !");
		end
	else
		
	end
end)

