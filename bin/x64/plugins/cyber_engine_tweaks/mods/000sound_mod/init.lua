print("Sound Manager : loaded")

SoundManager = {}





function SoundManager.PlaySound(file,path,channel)
	
	
		
		if(channel == "env") then
			io.open("env.txt","w"):close()
			
			local f = assert(io.open("env.txt", "w"))
			local filepath = path.."\\"..file
			print(filepath)
			f:write(filepath)
			f:close()
		end
		
		
		if(channel == "music") then
			io.open("music.txt","w"):close()
			
			local f = assert(io.open("music.txt", "w"))
			local filepath = path..'\\'..file
			print(filepath)
			f:write(filepath)
			f:close()
		end
		
		if(channel == "sound") then
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
			io.open("pauseenv.txt","w"):close()
			
			
		end
		
		
		if(channel == "music") then
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