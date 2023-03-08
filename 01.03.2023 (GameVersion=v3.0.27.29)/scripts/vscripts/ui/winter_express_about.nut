#if UI
global function WinterExpress_PopulateAboutText

string function GetPlaylist()
{
	if ( IsLobby() )
		return Lobby_GetSelectedPlaylist()
	else
		return GetCurrentPlaylistName()

	unreachable
}

array< aboutGamemodeDetailsTab > function WinterExpress_PopulateAboutText()
{
	array< aboutGamemodeDetailsTab > tabs
	aboutGamemodeDetailsTab tab1

	array< aboutGamemodeDetailsData > tab1Rules

	                                              
	tab1.tabName = 	"#GAMEMODE_RULES_OVERVIEW_TAB_NAME"
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#WINTER_EXPRESS_RULES_ABOUT_HEADER", "#WINTER_EXPRESS_RULES_ABOUT_BODY", $"rui/hud/gametype_icons/ltm/about_winterexpress_aboard" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#WINTER_EXPRESS_RULES_TRAIN_HEADER", "#WINTER_EXPRESS_RULES_TRAIN_BODY", $"rui/hud/gametype_icons/ltm/about_winterexpress_train" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#WINTER_EXPRESS_RULES_FRAY_HEADER", "#WINTER_EXPRESS_RULES_FRAY_BODY", $"rui/hud/gametype_icons/ltm/about_winterexpress_fray" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

#endif      