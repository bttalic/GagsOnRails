
 
 def videolink_format(videolink)

     if (videolink.include?("youtube") && videolink.include?("v="))==false
      puts("Invalid video link")
	  puts(videolink.include?("youtube"))
	  puts(videolink.include?("v="))
    end
	puts(videolink.include?("youtube"))
	  puts(videolink.include?("v="))
	  puts ((videolink.include?("youtube") && videolink.include?("v="))==false)
end

videolink="http://www.youtube.com/watch?v=vwyN_pU2FXc"
videolink_format(videolink)