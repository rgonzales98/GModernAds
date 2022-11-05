--CONFIG START--

NoAdsGroups = { "VIP", "VIP+" } -- Groups that dont see the ads when they die

-- Simply Add more lines and put the link for the website it opens... make sure it has http:// at the begining
CustomCommands = { 
	  ["!goog"] = "http://google.com",
	  ["!ytube"] = "http://youtube.com",
}

AdvType = { 
	  ["type"] = "custom", -- TYPES: motdgd, pinion and custom     (custom allows you to put your own url for the ads)
	  ["url"] = "http://google.com", -- the url for the ads if type is custom
	  ["delay"] = 280, -- How much time to wait between deaths to show the ads again
	  ["forced"] = 3, -- How long should the person be forced to watch the adv
	  ["killpage"] = false, -- The page stays open in the back after they click close if this is set to false
	  ["killseconds"] = 10, -- if killpage is set to true how long after they click on close should the page disapear
}

MotdgdId = "" -- ID for Motdgd if type is set to motdgd
PinionId = "" -- ID for Pinion if type is set to pinion
