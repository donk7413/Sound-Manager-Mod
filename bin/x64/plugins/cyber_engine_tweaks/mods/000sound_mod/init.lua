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


return SoundManager