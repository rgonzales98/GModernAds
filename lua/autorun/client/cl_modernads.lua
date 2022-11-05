ModAdsPage = nil
ModAdsButton = nil
ModAdsDHtml = nil

net.Receive('ModernAdsMOTD_OpenMOTD', function(length)

        local url = net.ReadString()
        local seconds = net.ReadInt(32);
		local Ads = net.ReadBit()
		local GetRidOfSoundAds = net.ReadBit()
		local KillSoundSeconds = net.ReadInt(32);
		local getip = net.ReadString()
		local getport = net.ReadString()
		ModAdsPage = ModAdsPage or vgui.Create( "HTML" )

		ModAdsDHtml = ModAdsDHtml or vgui.Create("DHTML", ModAdsPage );
        ModAdsButton = ModAdsButton or vgui.Create("DHTML", ModAdsPage);

		ModAdsDHtml.SetParent( ModAdsPage );
        ModAdsButton.SetParent( ModAdsPage );
		ModAdsDHtml:AddFunction( "window", "open", function( param )
                ModAdsDHtml:SetVisible( true );
                ModAdsButton:SetVisible( true );
                ModAdsDHtml:OpenURL( param );
        end)
        ModAdsButton:AddFunction( "modernads", "close", function( param )
                ModAdsDHtml:SetVisible( false );
                ModAdsButton:SetVisible( false );
				if Ads == true then
					if GetRidOfSoundAds == true then
						if KillSoundSeconds >= 1 then
							timer.Simple( KillSoundSeconds, function() 
								ModAdsDHtml:OpenURL("about:blank")
							end )
						end
					end
				else
					ModAdsDHtml:OpenURL("about:blank")
				end
         end)

        -- Close button.
        ModAdsButton:SetSize( ScrW(), 60 )
        ModAdsButton:Center()
        ModAdsButton:SetPos( 0, ScrH()-60 )
        ModAdsButton:MakePopup()
        
		--Close Button URL
		if getip == "" then
			getip = LocalPlayer():SteamID()
		end
        ModAdsButton:OpenURL( "http://5.152.206.182/modernads/?seconds=" .. seconds .. "&ip=" .. getip .. "&port=" .. getport .. "" )
		
        -- Opening Url
        ModAdsDHtml:SetSize( ScrW(), ScrH()-60 )
        ModAdsDHtml:Center()
        ModAdsDHtml:SetPos( 0, 0 )
        ModAdsDHtml:MakePopup()
		
        ModAdsDHtml:OpenURL( url )
        ModAdsDHtml.DoClick = function() ModAdsDHtml:SetVisible( false ) end
        ModAdsDHtml:SetVisible( true )
        ModAdsButton:SetVisible( true )
end)