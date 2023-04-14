global function InitTDMRoundTransition
global function TDM_ShowScoreboard
global function TDM_HideScoreboard

struct
{
	var menu
	var scoreboard
	var screenBlur
}
file

void function InitTDMRoundTransition( var newMenuArg )
{
	var menu = newMenuArg
	file.menu = menu
	file.scoreboard = GetPanel( "TDM_ScoreboardPanel" )
	file.screenBlur = Hud_GetRui(Hud_GetChild( file.menu, "ScreenBlur" ) )
}

void function TDM_ShowScoreboard_Internal()
{
	CloseAllMenus()
	AdvanceMenu( file.menu )
	ShowPanel( file.scoreboard )
	RunClientScript("TDM_SetIsRoundTransition", true )
	RuiSetWallTimeWithNow( file.screenBlur, "animateStartTime" )
	UI_SetScoreboardAnimateIn( file.scoreboard, 0.25 )
}

void function TDM_ShowScoreboard()
{
	thread TDM_ShowScoreboard_Internal()
}

void function TDM_HideScoreboard()
{
	UI_SetScoreboardAnimateOut( file.scoreboard, 0.25 )
	RuiSetWallTimeBad( file.screenBlur, "animateStartTime" )

	thread function() : ()
	{
		EndSignal( uiGlobal.signalDummy, "LevelShutdown" )

		wait 10.0

		RunClientScript("TDM_SetIsRoundTransition", false )
	}()
}