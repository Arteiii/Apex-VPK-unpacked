#if UI
global function NodeTracker_PopulateAboutText
global function NodeTracker_PopulateAboutTitle

string function GetPlaylist()
{
	if ( IsLobby() )
		return Lobby_GetSelectedPlaylist()
	else
		return GetCurrentPlaylistName()

	unreachable
}

string function NodeTracker_PopulateAboutTitle()
{
	return "#NODE_TRACKER_TITLE"
}

array< featureTutorialTab > function NodeTracker_PopulateAboutText()
{
	array< featureTutorialTab > tabs
	featureTutorialTab tab1
	featureTutorialTab tab2
	array< featureTutorialData > tab1Rules

	                                              
	tab1.tabName = 	"#NODE_TRACKER_TAB_TITLE"

	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#NODE_TRACKER_HEADER_01", 	"#NODE_TRACKER_BODY_01", 		$"rui/hud/gametype_icons/ltm/about_nodetracker_direction" ) )
	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#NODE_TRACKER_HEADER_02", 		"#NODE_TRACKER_BODY_02", 		$"rui/hud/gametype_icons/ltm/about_nodetracker_upload" ) )
	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#NODE_TRACKER_HEADER_03", 	"#NODE_TRACKER_BODY_03", 	$"rui/hud/gametype_icons/ltm/about_nodetracker_prize" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

#endif      