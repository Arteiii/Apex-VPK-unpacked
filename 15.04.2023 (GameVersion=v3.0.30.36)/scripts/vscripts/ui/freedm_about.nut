#if UI
global function FreeDM_PopulateAboutText

string function GetPlaylist()
{
	if ( IsLobby() )
		return Lobby_GetSelectedPlaylist()
	else
		return GetCurrentPlaylistName()

	unreachable
}

array< aboutGamemodeDetailsTab > function FreeDM_PopulateAboutText()
{
	array< aboutGamemodeDetailsTab > tabs
	string playlistUiRules = GetPlaylist_UIRules()
	if ( !GameModeHasRules() || playlistUiRules != GAMEMODE_FREEDM )
		return tabs

	if( GetPlaylistVarBool( GetPlaylist(), "freedm_gun_game_active", false ) )
		return GunGame_PopulateAboutText()

	return tabs
}

array< aboutGamemodeDetailsTab > function GunGame_PopulateAboutText()
{
	array< aboutGamemodeDetailsTab > tabs
	aboutGamemodeDetailsTab tab1
	array< aboutGamemodeDetailsData > tab1Rules

	                                              
	tab1.tabName = "#GAMEMODE_RULES_OVERVIEW_TAB_NAME"
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#GUNGAME_RULES_WEAPON_HEADER", "#GUNGAME_RULES_WEAPON_BODY", $"rui/hud/gametype_icons/freedm/about_gungame_weapon" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#GUNGAME_RULES_SQUAD_HEADER", "#GUNGAME_RULES_SQUAD_BODY", $"rui/hud/gametype_icons/freedm/about_gungame_squad" ) )
	tab1Rules.append( UI_GameModeRulesDialog_BuildDetailsData( "#GUNGAME_RULES_KNIFE_HEADER", "#GUNGAME_RULES_KNIFE_BODY", $"rui/hud/gametype_icons/freedm/about_gungame_knife" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

#endif      