-- neat-contacts
-- Apple Contacts cleanup tool

-- If you've ever synced your Contacts with Facebook,
-- there's a chance that you got a really screwed up
-- Contacts as a result. This will help you clean
-- up your Contacts.

-- Three tools:
-- 1) Delete all birthdays (so they don't pop up in Mac/iPhone and stay there)
-- 2) Delete all Facebook fields
-- 3) Delete all Homepages for people that start with "fb://"

-- How to use it:
-- 1) BACKUP YOUR CONTACTS! File > Export > Contacts Archive...
-- 2) Figure out for which people you want to make the change.
--    You can leave it as it is to change everyone, or you can
--    do it for a specific person (maybe to just try it out).
-- 3) Decide which of these tools you want to use.
-- 4) For the tools that you don't want to use, simply delete them.
-- 5) Run the script.

-- Credits:
-- Facebook field deleter adapted from
-- http://macscripter.net/viewtopic.php?id=38956&p=2

tell application "Contacts"
	-- Define the changeset:
	
	-- We can either do all people:
	set peopleToChange to people
	
	-- Only do a specific person (uncomment this below):
	-- set peopleToChange to people whose (first name) contains "John" and (last name) contains "Smith"
	
	-- For all people that match:
	repeat with thisPerson in peopleToChange
		
		
		
		-- START EDITING WHAT YOU WANT THE SCRIPT TO DO HERE --
		-- Delete the tools you don't want
		-- There are three tools:
		-- 
		-- 1) Delete birthdays
		-- 2) Delete Facebook contact field
		-- 3) Delete home pages for people that start with fb://
		
		
		
		-- START -- 1) Delete birthday for each person
		
		delete birth date of thisPerson
		
		-- END -- 1) Delete birthday for each person
		
		
		
		-- START -- Delete Facebook contact field for each person
		
		set SocialProfileList to (every social profile of thisPerson whose service name contains "Facebook")
		if SocialProfileList ­ {} then
			delete (url of every social profile of thisPerson)
			delete (user name of social profile of thisPerson)
			
			-- We have to repeat this again because sometimes
			-- Applescript converts a username into a URL
			-- And doesn't fully delete it
			delete (url of every social profile of thisPerson)
			delete (user name of social profile of thisPerson)
		end if
		
		-- END -- Delete Facebook contact field for each person
		
		
		
		-- START -- Delete "home pages" that look like fb://profile/12345
		
		set homePageList to (every url of thisPerson whose value contains "fb://")
		if SocialProfileList ­ {} then
			delete (every url of thisPerson whose value contains "fb://")
		end if
		
		-- END -- Delete "home pages" that look like fb://profile/12345
		
		
		log "OK - " & (first name of thisPerson) & " " & (last name of thisPerson)
		
		save
		
	end repeat
end tell