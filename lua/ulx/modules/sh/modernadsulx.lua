function ulx.forceurl( calling_ply, target_plys, forcednumber, sendadsurl )
	
	for k,v in pairs( target_plys ) do 
		if forcednumber >= 0 then
			v:ModernAdsShowMOTD(sendadsurl, forcednumber, false, false, 10)
		end
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A opened a url for #T", target_plys )
	
end
local forceurl = ulx.command( "ModernAds", "ulx forceurl", ulx.forceurl, "!forceurl" )
forceurl:addParam{ type=ULib.cmds.PlayersArg }
forceurl:addParam{ type=ULib.cmds.NumArg, default=0, hint="Time Forced", ULib.cmds.optional }
forceurl:addParam{ type=ULib.cmds.StringArg, hint="URL" }
forceurl:defaultAccess( ULib.ACCESS_ADMIN )
forceurl:help( "Open A Url On A Player" )