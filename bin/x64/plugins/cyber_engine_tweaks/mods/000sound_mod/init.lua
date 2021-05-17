

SoundManager = {}
SoundManager.Version = 6
SoundManager.MasterVolume = -1
SoundManager.SfxVolume = -1
SoundManager.DialogueVolume = -1
SoundManager.MusicVolume = -1
SoundManager.CarRadioVolume = -1

registerForEvent("onInit", function()
local MasterVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MasterVolume")
	SoundManager.MasterVolume = MasterVolume:GetValue()
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
	SoundManager.SfxVolume = SfxVolume:GetValue()
	
	local DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
	SoundManager.DialogueVolume = DialogueVolume:GetValue()
	
	local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
	SoundManager.MusicVolume = MusicVolume:GetValue()
	
	local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
	SoundManager.CarRadioVolume = CarRadioVolume:GetValue()


print("Sound Manager v."..SoundManager.Version.." : loaded")
end)
function SoundManager.PlaySound(file,path,channel,volume)
	
	
		
		if(channel == "env") then
			
			
			
			
			
			io.open("env.json","w"):close()
			
			local f = assert(io.open("env.json", "w"))
			
			local obj = {}
			obj.path = path.."\\"..file
			obj.volume = volume
			
			
			local stringg = json.encode(obj)
		
			f:write(stringg)
			f:close()
		end
		
		
		if(channel == "music") then
			
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(0)
			
			
			
			
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(0)
			
			
			io.open("music.json","w"):close()
			
			local f = assert(io.open("music.json", "w"))
			local obj = {}
			obj.path = path.."\\"..file
			obj.volume = volume
			
			
			local stringg = json.encode(obj)
		
			f:write(stringg)
			f:close()
		end
		
		if(channel == "sound") then
			
		
			
			io.open("sound.json","w"):close()
			
			local f = assert(io.open("sound.json", "w"))
			local obj = {}
			obj.path = path.."\\"..file
			obj.volume = volume
			
			
			local stringg = json.encode(obj)
		
			f:write(stringg)
			f:close()
		end
		
		
		
	
	
end



function SoundManager.Pause(channel)
	
	
		
		if(channel == "env") then
		
		
			
			
			io.open("pauseenv.txt","w"):close()
			
			
		end
		
		
		if(channel == "music") then
			
			
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			
			
			
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			
		
		
		
			io.open("pausemusic.txt","w"):close()
			
		end
		
		if(channel == "sound") then
			
			
			
			
		
		
		
			io.open("pausesound.txt","w"):close()
			
		end
		
		
		
	
	
end


function SoundManager.Resume(channel)
	
	
		
		if(channel == "env") then
			
			
			
			
			
			os.remove("pauseenv.txt")
			
		end
		
		
		if(channel == "music") then
			
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(0)
			
			
			
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(0)
			
				os.remove("pausemusic.txt")
		end
		
		if(channel == "sound") then
			
			
				os.remove("pausesound.txt")
		end
		
		
		
	
	
end


function SoundManager.Stop(channel)
	
	
		
		if(channel == "env") then
			
		
			os.remove("pauseenv.txt")
				io.open("stopenv.txt","w"):close()
		end
		
		
		if(channel == "music") then
			
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			
			
		
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			
					os.remove("pausemusic.txt")
				io.open("stopmusic.txt","w"):close()
		end
		
		if(channel == "sound") then
		
			
			
				os.remove("pausesound.txt")
				io.open("stopsound.txt","w"):close()
		end
		
		
		
	
	
end



function SoundManager.IsPlaying(channel)
	
local bool = false
	
		
		if(channel == "env") then
			
			
			local f = io.open("env.json")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
			
		end
		
		if(channel == "music") then
			
			
			local f = io.open("music.json")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
			
		end
		
		if(channel == "sound") then
			local f = io.open("sound.json")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
		end
		
		return bool
	
	
end



function SoundManager.SetSoundSettingValue(volumTag,value)
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", volumTag)
	SoundManager.SfxVolume = SfxVolume:GetValue()
	SfxVolume:SetValue(value)
	
end


function SoundManager.GetSoundSettingValue(volumTag)
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", volumTag)
	return SfxVolume:GetValue()
end

return SoundManager