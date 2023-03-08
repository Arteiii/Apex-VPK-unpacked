#if UI
global function TDM_PopulateAboutText

string function GetPlaylist()
{
	if ( IsLobby() )
		return Lobby_GetSelectedPlaylist()
	else
		return GetCurrentPlaylistName()

	unreachable
}

array< aboutGamemodeDetailsTab > function TDM_PopulateAboutText()
{
	array< aboutGamemodeDetailsTab > tabs
	aboutGamemodeDetailsTab tab1

	array< aboutGamemodeDetailsData > tab1Rules

	                                              
	tab1.tabName = 	"#GAMEMODE_RULES_OVERVIEW_TAB_NAME"
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#TDM_RULES_ABOUT_HEADER", "#TDM_RULES_ABOUT_BODY", $"rui/hud/gametype_icons/ltm/about_tdm_fight" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#TDM_RULES_ARMED_HEADER", "#TDM_RULES_ARMED_BODY", $"rui/hud/gametype_icons/ltm/about_tdm_armed" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#TDM_RULES_FROSTY_HEADER", "#TDM_RULES_FROSTY_BODY", $"rui/hud/gametype_icons/ltm/about_tdm_frosty" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

#endif      