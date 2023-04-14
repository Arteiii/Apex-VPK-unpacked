#if UI
global function Date_Night_PopulateAboutText

string function GetPlaylist()
{
	if ( IsLobby() )
		return Lobby_GetSelectedPlaylist()
	else
		return GetCurrentPlaylistName()

	unreachable
}

array< aboutGamemodeDetailsTab > function Date_Night_PopulateAboutText()
{
	array< aboutGamemodeDetailsTab > tabs
	aboutGamemodeDetailsTab tab1
	array< aboutGamemodeDetailsData > tab1Rules

	                                              
	tab1.tabName = 	"#DATE_NIGHT_TAB_NAME"

	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#DATE_NIGHT_1_HEADER", "#DATE_NIGHT_1_BODY", $"rui/hud/gametype_icons/datenight/about_datenight_couples" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#DATE_NIGHT_2_HEADER", "#DATE_NIGHT_2_BODY", $"rui/hud/gametype_icons/datenight/about_datenight_heal" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#DATE_NIGHT_3_HEADER", "#DATE_NIGHT_3_BODY", $"rui/hud/gametype_icons/datenight/about_datenight_weapon" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

#endif      