print("Sound Manager : loaded")

SoundManager = {}
SoundManager.MasterVolume = -1
SoundManager.SfxVolume = -1
SoundManager.DialogueVolume = -1
SoundManager.MusicVolume = -1
SoundManager.CarRadioVolume = -1




function SoundManager.PlaySound(file,path,channel)
	
	
		
		if(channel == "env") then
			if(SoundManager.DialogueVolume == -1) then
			local DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
			SoundManager.DialogueVolume = SfxVolume:GetValue()
			DialogueVolume:SetValue(0)
			end
			
			if(SoundManager.SfxVolume == -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SoundManager.SfxVolume = SfxVolume:GetValue()
			SfxVolume:SetValue(0)
			end
			
			
			
			
			io.open("env.txt","w"):close()
			
			local f = assert(io.open("env.txt", "w"))
			local filepath = path.."\\"..file
			print(filepath)
			f:write(filepath)
			f:close()
		end
		
		
		if(channel == "music") then
			if(SoundManager.MusicVolume == -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			SoundManager.MusicVolume = MusicVolume:GetValue()
			MusicVolume:SetValue(0)
			end
			
			
			if(SoundManager.CarRadioVolume == -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			SoundManager.CarRadioVolume = CarRadioVolume:GetValue()
			CarRadioVolume:SetValue(0)
			end
			
			io.open("music.txt","w"):close()
			
			local f = assert(io.open("music.txt", "w"))
			local filepath = path..'\\'..file
			print(filepath)
			f:write(filepath)
			f:close()
		end
		
		if(channel == "sound") then
			if(SoundManager.MusicVolume == -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			SoundManager.MusicVolume = MusicVolume:GetValue()
			MusicVolume:SetValue(0)
			end
			
			if(SoundManager.CarRadioVolume == -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			SoundManager.CarRadioVolume = CarRadioVolume:GetValue()
			CarRadioVolume:SetValue(0)
			end
			
			if(SoundManager.SfxVolume == -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SoundManager.SfxVolume = SfxVolume:GetValue()
			SfxVolume:SetValue(0)
			end
			
			io.open("sound.txt","w"):close()
			
			local f = assert(io.open("sound.txt", "w"))
			local filepath = path.."\\"..file
			print(filepath)
			f:write(filepath)
			f:close()
		end
		
		
		
	
	
end



function SoundManager.Pause(channel)
	
	
		
		if(channel == "env") then
		
			if(SoundManager.DialogueVolume ~= -1) then
			local DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
			DialogueVolume:SetValue(SoundManager.DialogueVolume)
			end
			
			if(SoundManager.SfxVolume ~= -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(SoundManager.SfxVolume)
			end
			
			io.open("pauseenv.txt","w"):close()
			
			
		end
		
		
		if(channel == "music") then
			
			if(SoundManager.MusicVolume ~= -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			end
			
			if(SoundManager.CarRadioVolume ~= -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			end
		
		
		
			io.open("pausemusic.txt","w"):close()
			
		end
		
		if(channel == "sound") then
			
			if(SoundManager.MusicVolume ~= -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			end
			
			if(SoundManager.CarRadioVolume ~= -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			end
			
			if(SoundManager.SfxVolume ~= -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(SoundManager.SfxVolume)
			end
		
		
		
			io.open("pausesound.txt","w"):close()
			
		end
		
		
		
	
	
end


function SoundManager.Resume(channel)
	
	
		
		if(channel == "env") then
			
			if(SoundManager.DialogueVolume ~= -1) then
			local DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
			DialogueVolume:SetValue(0)
			end
			
			if(SoundManager.SfxVolume ~= -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(0)
			end
			
			
			os.remove("pauseenv.txt")
			
		end
		
		
		if(channel == "music") then
			if(SoundManager.MusicVolume ~= -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(0)
			end
			
			if(SoundManager.CarRadioVolume ~= -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(0)
			end
				os.remove("pausemusic.txt")
		end
		
		if(channel == "sound") then
			if(SoundManager.MusicVolume == -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(0)
			end
			
			if(SoundManager.CarRadioVolume == -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(0)
			end
			
			if(SoundManager.SfxVolume == -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(0)
			end
				os.remove("pausesound.txt")
		end
		
		
		
	
	
end


function SoundManager.Stop(channel)
	
	
		
		if(channel == "env") then
			if(SoundManager.DialogueVolume ~= -1) then
			local DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
			DialogueVolume:SetValue(SoundManager.DialogueVolume)
			SoundManager.DialogueVolume = -1
			end
			
			if(SoundManager.SfxVolume ~= -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(SoundManager.SfxVolume)
			SoundManager.SfxVolume = -1
			end
			
			os.remove("pauseenv.txt")
				io.open("stopenv.txt","w"):close()
		end
		
		
		if(channel == "music") then
			if(SoundManager.MusicVolume ~= -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			SoundManager.MusicVolume = -1
			end
			
			if(SoundManager.CarRadioVolume ~= -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			SoundManager.CarRadioVolume = -1
			end
					os.remove("pausemusic.txt")
				io.open("stopmusic.txt","w"):close()
		end
		
		if(channel == "sound") then
			if(SoundManager.MusicVolume ~= -1) then
			local MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
			MusicVolume:SetValue(SoundManager.MusicVolume)
			SoundManager.MusicVolume = -1
			end
			
			if(SoundManager.CarRadioVolume ~= -1) then
			local CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
			CarRadioVolume:SetValue(SoundManager.CarRadioVolume)
			SoundManager.CarRadioVolume = -1
			end
			
			if(SoundManager.SfxVolume ~= -1) then
			local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
			SfxVolume:SetValue(SoundManager.SfxVolume)
			SoundManager.SfxVolume = -1
			end
				os.remove("pausesound.txt")
				io.open("stopsound.txt","w"):close()
		end
		
		
		
	
	
end



function SoundManager.IsPlaying(channel)
	
local bool = false
	
		
		if(channel == "env") then
			
			
			local f = io.open("env.txt")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
			
		end
		
		if(channel == "music") then
			
			
			local f = io.open("music.txt")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
			
		end
		
		if(channel == "sound") then
			local f = io.open("sound.txt")
			local lines = f:read("*a")
				
			if(lines ~= "") then
			
				bool = true
				
			
			end
		end
		
		return bool
	
	
end


return SoundManager