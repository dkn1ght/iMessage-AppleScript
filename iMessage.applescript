tell application "Messages"
	set csvData to read "/Users/beiduofen-yanfabu02/Downloads/Apple-ID-AppleScript-master/appleids.csv"
	set csvEntries to paragraphs of csvData
	repeat with i from 1 to count csvEntries
		set myUser to (csvEntries's item i)'s text
		display dialog myUser
		
		set myArray to my theSplit(myUser, ",")
		count of myArray
		item 1 of myArray
		set x to item 3 of myArray
		display dialog x
		
		set myMessageP1 to "：你在"
		set myPlatform to (csvEntries's item i)'s text
		set myMessageP2 to "的欠款已逾期，请在收到通知后处理账单，如未处理将对你的联系人进行电话或短信通知，请须知！案件处理客服电话："
		set myNumber to (csvEntries's item i)'s text
		set resultingString to myUser & myMessageP1 & myPlatform & myMessageP2 & myNumber
		set phone to (csvEntries's item i)'s text
		set myid to get id of first service
		set theBuddy to buddy phone of service id myid
		send resultingString to theBuddy

		delay 1 --延时一秒，不然取不到已发达的内容
		set FailNum to (get count chat)
		if FailNum > 100 then
			repeat with j from 1 to FailNum
				set phone to (get name of chat (FailNum - j))
				set DelMsg to "iMessage;-;" & phone
				if exists (text chat id DelMsg) then
					delete text chat id DelMsg
				end if
			end repeat
		end if
	end repeat
end tell
on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit