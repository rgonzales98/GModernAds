util.AddNetworkString('ModernAdsMOTD_OpenMOTD');

local Player = FindMetaTable('Player')

function ModernAdsCustom_ChatCommand( ply, text, public )
	if CustomCommands[text] then
		ply:ModernAdsShowMOTD(CustomCommands[text], 1, false, true, 10)
    end	
end

hook.Add( "PlayerSay", "ModernAdsCustomChatCommand", ModernAdsCustom_ChatCommand );

ServerIP = "";
ServerPort = 0;
ModernAdsVer = "1.1";
ModernAdsCounter = {};

--Get Servers IP
local function GetServerIP()
        local hostip = GetConVarString( "hostip" )
        hostip = tonumber( hostip )
        
        local ip = {}
        ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )
        ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )
        ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )
        ip[ 4 ] = bit.band( hostip, 0x000000FF )
        
        return table.concat( ip, "." )
end

function Player:ModernAdsShowMOTD(Url, Seconds, Ads, GetRidOfSoundAds, KillSoundSeconds)
    net.Start('ModernAdsMOTD_OpenMOTD');
    net.WriteString(Url);
    net.WriteInt(Seconds, 32);
	net.WriteBit(Ads);
	net.WriteBit(GetRidOfSoundAds);
	net.WriteInt(KillSoundSeconds, 32);
	net.WriteString(GetServerIP());
	net.WriteString(ServerPort);
    net.Send(self);
end

local function AdPlugin_InitPost( )
        ServerIP = GetServerIP();
        ServerPort = GetConVarString( "hostport" );
		local NewVersion = ""; 
		http.Fetch( "http://5.152.206.182/versioncheck/modernads.php?version=".. ModernAdsVer .."",
			function( body, len, headers, code )
				NewVersion = body;
			end,
			function( error )
			end
		);
		if NewVersion == "uptodate" then
			print( "**MODERN ADS IS UP TO DATE**" )
		else
			print(NewVersion)
		end
end


local function AdPlugin_FirstSpawn( ply )
    ModernAdsCounter[ply:UserID()] = -1;
end


function AdPlugin_PlayerDisconnected( ply )
	   timer.Stop("modernadsp" .. ply:UserID());
end

function AdPlugin_PlayerDeath( victim, inflictor, attacker )
    if ModernAdsCounter[victim:UserID()] == -1 then
        DisplayMOTD(victim, AdvType["forced"]);
        ModernAdsCounter[victim:UserID()] = 1;
        timer.Create( "modernadsp" .. victim:UserID() , AdvType["delay"], 0, function()
                ModernAdsCounter[victim:UserID()] = 0;
            end);
    end

    if ModernAdsCounter[victim:UserID()] == 0 then
        ModernAdsCounter[victim:UserID()] = 1;
         timer.Create( "modernadsp" .. victim:UserID() , AdvType["delay"], 0, function()
                ModernAdsCounter[victim:UserID()] = 0;
            end);
        DisplayMOTD(victim, AdvType["forced"]);
    end
end

function DisplayMOTD(player, time)
	-- Checks For Groups
	if table.HasValue( NoAdsGroups, player:GetUserGroup() ) then
		
	else
		if AdvType["type"] == "motdgd" then
			player:ModernAdsShowMOTD("http://motdgd.com/motd/?user=" .. MotdgdId .. "&fv=1&ip=" .. ServerIP .. "&pt=" .. ServerPort .. "&gm=garrysmod&st=" .. player:SteamID() .. "&v=2.07&sec=10", time, true, AdvType["killpage"], AdvType["killseconds"])
		elseif AdvType["type"] == "pinion" then
			player:ModernAdsShowMOTD("http://motd.pinion.gg/motd/".. PinionId .."/gmod/motd.html", time, true, AdvType["killpage"], AdvType["killseconds"])
		elseif AdvType["type"] == "custom" then
			player:ModernAdsShowMOTD(AdvType["url"], time, true, AdvType["killpage"], AdvType["killseconds"])
		else	
			
		end
	end
end


hook.Add( "InitPostEntity", "AdPlugin_InitPostEntity", AdPlugin_InitPost );
hook.Add( "PlayerInitialSpawn", "AdPlugin_PlayerInitialSpawn", AdPlugin_FirstSpawn );
hook.Add( "PlayerDisconnected", "AdPlugin_PlayerDisconnected", AdPlugin_PlayerDisconnected )
hook.Add( "PlayerDeath", "AdPlugin_PlayerDeath", AdPlugin_PlayerDeath );