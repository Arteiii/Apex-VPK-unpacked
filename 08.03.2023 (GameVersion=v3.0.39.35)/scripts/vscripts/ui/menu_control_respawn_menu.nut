                        

global function InitControlSpawnMenu
global function UI_OpenControlSpawnMenu
global function UI_CloseControlSpawnMenu
global function UI_IsSpawnMapOpen

global function SetSpawnButtonTooltipData
global function Control_SetAllButtonsDisabled
global function Control_SetAllButtonsEnabled
global function Control_RemoveAllButtonSpawnIcons

global function Control_Respawn_SetKillerInfo
global function Control_UI_SpawnMenu_SetExpPercentAmountsForSpawns

global function SetWaypointDataForUI
global function SetLastLocalPingObjIDForUI
global function ClearWaypointDataForUI

global function ControlSpawnMenu_SetLoadoutAndLegendSelectMenuIsEnabled
global function ControlSpawnMenu_UpdatePlayerLoadout

const string CONTROL_SFX_SELECT_INVALID_SPAWN = "Ctrl_Spawn_Invalid_1p"
const string CONTROL_SFX_SELECT_INVALID_SIDEMENU = "UI_Menu_Deny"
const string CONTROL_SFX_SELECT_VALID_SPAWN = "UI_Menu_Accept"
const string CONTROL_SFX_SELECT_VALID_SIDEMENU = "UI_Menu_Accept"
const asset RESPAWN_BEACON_ICON = $"rui/hud/gametype_icons/survival/dna_station"

struct DeathRecapDamageData
{
	                          
	int   attackerEHandle     	                  
	int   victimEHandle       	                  
	int   damageSourceID      	                  
	int   damageType          	                       
	int   totalDamage         	                 
	int   hitCount            	                 
	int   headShotBits        	                 
	float healthFrac          	                     
	float shieldFrac          	                     
	float blockTime           	                         

	                      
	int   gladCardSlotIndex                                                     
	asset customImage                                                                                        
	int   index                                                                                       

	string damageSourceName
	string attackerNamer
	string victimName
	asset weaponIcon
	bool isMainWeapon
}

struct ControlSpawnButtonData
{
	int waypointEHI
	bool isVisible
	bool isSelectedForSpawn
	int waypointTeamUsage

	int objID
	int waypointType
	float xPosScreenSpace
	float yPosScreenSpace

	string tooltipNameInfo

	float capturePercentage

	int currentControllingTeam
	int currentOwner
	int neutralPointOwnership
	int localPlayerAlliance
	bool hasEmphasis

	int team0PlayersOnObj
	int team1PlayersOnObj

	int numTeamPings
}


struct
{
	var menu
	float menuOpenTime
	float spawnButtonClickedTime

	array<var> spawnButtons
	table< var, ToolTipData > buttonTooltipData
	var respawnStatus
	var spawnHeader
	var loadoutButton
	var legendButton

	table< int, ControlSpawnButtonData > EHItoWaypointData
	table< var, ControlSpawnButtonData > buttonToWaypointData
	var deathRecapButton
	table< ControlSpawnButtonData, var > waypointDataToButton
	bool hasMenuBeenOpened = false
	DeathRecapDamageData deathRecap

	bool scoreboardOpened = false
	bool lastScoreboardOpened = false
	bool isLateJoinPlayer = false

	int expRewardForSpawnOnObjective = 0
	int expRewardForSpawnOnBase = 0

	bool areLoadoutAndLegendSelectMenuButtonsEnabled = true

	bool inputRegistered = false
	var focusedSpawnButton = null

	int lastLocalPingObjID = -1
	bool isSpawnOnCentralDisabled = false
}
file

void function InitControlSpawnMenu( var newMenuArg )                                               
{
	var menu = GetMenu( "ControlSpawnSelector" )
	file.menu = menu

	RegisterSignal( "ControlSpawnMenuUpdate" )
	RegisterSignal( "ControlSpawnMenuClosed" )

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, OnControlSpawnMenu_Open )
	AddMenuEventHandler( menu, eUIEvent.MENU_NAVIGATE_BACK, OnControlSpawnMenu_NavBack )
	AddMenuEventHandler( menu, eUIEvent.MENU_SHOW, OnControlSpawnMenu_Show )
	AddMenuEventHandler( menu, eUIEvent.MENU_HIDE, OnControlSpawnMenu_Hide )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, OnControlSpawnMenu_Close )
	AddMenuEventHandler( menu, eUIEvent.MENU_PRECLOSE, OnControlSpawnMenu_PreClose )

	AddUICallback_UIShutdown( OnControlMenuShutdown )
	AddUICallback_OnResolutionChanged( ControlSpawnMenu_ResolutionChanged )

	for( int i = 0; i<8; i++ )
	{
		var spawnButton = Hud_GetChild( menu, "SpawnSelectButton" + i )
		Hud_AddEventHandler( spawnButton, UIE_CLICK, OnSpawnButtonClick )
		Hud_AddEventHandler( spawnButton, UIE_MIDDLECLICK, ControlSpawnMenu_OnPingButtonClick )
		Hud_AddEventHandler( spawnButton, UIE_GET_FOCUS, OnSpawnButtonGetFocus )
		Hud_AddEventHandler( spawnButton, UIE_LOSE_FOCUS, OnSpawnButtonLoseFocus )

		CreateSpawnButtonToolTip( spawnButton )
		file.spawnButtons.append( spawnButton )
	}

	file.deathRecapButton = Hud_GetChild( menu, "DeathRecap" )
	file.respawnStatus = Hud_GetChild( menu, "RespawnStatus" )
	file.spawnHeader = Hud_GetChild( menu, "SpawnHeader" )
	file.loadoutButton = Hud_GetChild( menu, "LoadoutButton" )
	file.legendButton = Hud_GetChild( menu, "LegendButton" )

	Hud_AddEventHandler( file.loadoutButton, UIE_CLICK, ControlSpawnMenu_OpenLoadoutMenu )
	Hud_AddEventHandler( file.legendButton, UIE_CLICK, ControlSpawnMenu_OpenCharacterSelect )
}


void function OnControlSpawnMenu_Open()
{
	AddMenuFooterOption( file.menu, LEFT, BUTTON_START, true, "#CONTROL_SHOW_SCOREBOARD_GAMEPAD", "#CONTROL_SHOW_SCOREBOARD", ControlSpawnMenu_OpenScoreboard, CanOpenScoreboard )
	AddMenuFooterOption( file.menu, LEFT, BUTTON_START, true, "#CONTROL_HIDE_SCOREBOARD_GAMEPAD", "#CONTROL_HIDE_SCOREBOARD", ControlSpawnMenu_CloseScoreboard, CanCloseScoreboard )
	AddMenuFooterOption( file.menu, RIGHT, BUTTON_DPAD_UP, true, "#MODE_DETAILS_GAMEPAD", "#MODE_DETAILS", ControlSpawnMenu_OpenGameModeDetails )

	#if PC_PROG
		AddMenuFooterOption( file.menu, RIGHT, KEY_ENTER, true, "", "", UI_OnButton_Enter )
	#endif

	RegisterCallbacks()
	file.lastScoreboardOpened = false
	file.hasMenuBeenOpened = true

	if ( IsFullyConnected() )
		file.isSpawnOnCentralDisabled = !Control_IsSpawningOnObjectiveBAllowed()
	
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", true )
#endif

	RunClientScript( "UICallback_UpdateTeammateInfo", Hud_GetChild( file.menu, "TeammateInfo0" ), true )
	RunClientScript( "UICallback_UpdateTeammateInfo", Hud_GetChild( file.menu, "TeammateInfo1" ), true )
	RunClientScript( "UICallback_Control_UpdatePlayerInfo", file.legendButton )
}


void function RegisterCallbacks()
{
	if( !file.inputRegistered )
	{
		RegisterButtonPressedCallback( MOUSE_WHEEL_UP, UI_ControlMenu_MouseWheelUp )
		RegisterButtonPressedCallback( MOUSE_WHEEL_DOWN, UI_ControlMenu_MouseWheelDown )
		RegisterButtonPressedCallback( KEY_TAB, ControlSpawnMenu_ToggleScoreboard )
		RegisterButtonPressedCallback( BUTTON_START, ControlSpawnMenu_ToggleScoreboard )
		RegisterButtonPressedCallback( KEY_F2, ControlSpawnMenu_OpenGameModeDetails )
		RegisterButtonPressedCallback( BUTTON_X, ControlSpawnMenu_OpenLoadoutMenu)
		RegisterButtonPressedCallback( BUTTON_Y, ControlSpawnMenu_OpenCharacterSelect)
		RegisterButtonPressedCallback( BUTTON_SHOULDER_RIGHT, ControlSpawnMenu_OnPingButtonClick)
		file.inputRegistered = true
	}
}

void function DeregisterCallbacks()
{
	if( file.inputRegistered )
	{
		DeregisterButtonPressedCallback( MOUSE_WHEEL_UP, UI_ControlMenu_MouseWheelUp )
		DeregisterButtonPressedCallback( MOUSE_WHEEL_DOWN, UI_ControlMenu_MouseWheelDown )
		DeregisterButtonPressedCallback( KEY_TAB, ControlSpawnMenu_ToggleScoreboard )
		DeregisterButtonPressedCallback( BUTTON_START, ControlSpawnMenu_ToggleScoreboard )
		DeregisterButtonPressedCallback( KEY_F2, ControlSpawnMenu_OpenGameModeDetails )
		DeregisterButtonPressedCallback( BUTTON_X, ControlSpawnMenu_OpenLoadoutMenu )
		DeregisterButtonPressedCallback( BUTTON_Y, ControlSpawnMenu_OpenCharacterSelect )
		DeregisterButtonPressedCallback( BUTTON_SHOULDER_RIGHT, ControlSpawnMenu_OnPingButtonClick)
		file.inputRegistered = false
	}
}

void function OnControlSpawnMenu_Show()
{
	RegisterCallbacks()
	if( file.scoreboardOpened )
		ControlSpawnMenu_OpenScoreboard( null )                                                          

	UpdateSpawnButtons()
	UpdateDeathRecap()
	UpdateJIP()

	if ( IsFullyConnected() && IsUsingLoadoutSelectionSystem() )
		ControlSpawnMenu_UpdatePlayerLoadout()
		
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", true )
#endif
}

void function OnControlSpawnMenu_Hide()
{
	DeregisterCallbacks()
	
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", false )
#endif	
}

void function OnControlSpawnMenu_Close()
{
	ClearMenuFooterOptions( file.menu )
	DeregisterCallbacks()
	ClearAllWaypointData()
	ControlSpawnMenu_CloseScoreboard( null )
	file.hasMenuBeenOpened = false
	file.areLoadoutAndLegendSelectMenuButtonsEnabled = true
	
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", false )
#endif
}


void function OnControlSpawnMenu_PreClose()
{
	RunClientScript( "UICallback_Control_OnMenuPreClosed" )
}


void function OnControlSpawnMenu_NavBack()
{
	if( file.scoreboardOpened )
		ControlSpawnMenu_ToggleScoreboard( KEY_TAB )
	else
		OpenSystemMenu()
}


void function UI_OpenControlSpawnMenu( bool checkLastScoreboardOpened, int bestSpawnWaypointEHI )
{
	if( checkLastScoreboardOpened )
		file.scoreboardOpened = file.lastScoreboardOpened

	if ( GetActiveMenu() != file.menu && MenuStack_GetLength() != 0 )
		CloseActiveMenu()

	if ( !MenuStack_Contains( file.menu ) )
	{
		AdvanceMenu( file.menu )
		file.menuOpenTime = UITime()
	}

                                                                                                                                                           
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", true )
#endif

	                                                               
	thread UI_SetCursorToBestSpawnLocation_Thread( bestSpawnWaypointEHI )
}

                                                                                             
const float SET_CURSOR_POSITION_DELAY = 0.1
const float RUI_WIDTH = 1920.0
const float RUI_HEIGHT = 1080.0
void function UI_SetCursorToBestSpawnLocation_Thread( int bestSpawnWaypointEHI )
{
	                                                                                                                        
	wait SET_CURSOR_POSITION_DELAY

	                                                               
	if ( bestSpawnWaypointEHI in file.EHItoWaypointData )
	{
		ControlSpawnButtonData buttonData = file.EHItoWaypointData[ bestSpawnWaypointEHI ]

		                                                                              
		if ( buttonData.waypointTeamUsage == eControlSpawnWaypointUsage.FRIENDLY_TEAM )
		{
			                                                                                                             
			vector hudSize = <Hud_GetWidth( file.menu ), Hud_GetHeight( file.menu ), 0.0>
			float xScale = hudSize.x / RUI_WIDTH
			float yScale = hudSize.y / RUI_HEIGHT

			float x = buttonData.xPosScreenSpace / xScale
			float y = buttonData.yPosScreenSpace / yScale
			SetCursorPosition( <x, y, 0> )
		}
	}
}

void function UI_CloseControlSpawnMenu()
{
	Signal( uiGlobal.signalDummy, "ControlSpawnMenuClosed" )

	                                                                                                                                      
	LoadoutSelectionMenu_CloseLoadoutMenu()

	if ( GetActiveMenu() == file.menu && MenuStack_GetLength() != 0 )
	{
		CloseActiveMenu()
	}
#if NX_PROG
	SetConVarBool( "nx_is_control_spawn_menu_open", false )
#endif
}

bool function UI_IsSpawnMapOpen()
{
	if ( MenuStack_Contains( file.menu ) )
		return true

	return false
}


void function UI_ControlMenu_MouseWheelUp( var button )
{
	if ( !IsFullyConnected() )
		return

	if ( GetActiveMenu() != GetParentMenu( file.menu ) )
		return

	if ( IsLobby() )
		return

	RunClientScript( "UICallback_ControlMenu_MouseWheelUp" )
}


void function UI_ControlMenu_MouseWheelDown( var button )
{
	if ( !IsFullyConnected() )
		return

	if ( GetActiveMenu() != GetParentMenu( file.menu ) )
		return

	if ( IsLobby() )
		return

	RunClientScript( "UICallback_ControlMenu_MouseWheelDown" )
}


void function OnControlMenuShutdown()
{

}


void function ControlSpawnMenu_ResolutionChanged()
{
	if ( IsFullyConnected()  && Control_IsModeEnabled() )
	{
		RunClientScript( "UICallback_Control_OnResolutionChanged" )
	}
}


void function ControlSpawnMenu_OpenCharacterSelect( var button )
{
	if ( !file.areLoadoutAndLegendSelectMenuButtonsEnabled )
	{
		EmitUISound( CONTROL_SFX_SELECT_INVALID_SIDEMENU )
		return
	}
	else if ( UITime() > file.menuOpenTime + 0.1 )
	{
	bool isTryingToViewProfile = ScoreboardMenu_IsTryingToViewProfileOfPlayerInScoreboard()

	                                                    
	if( isTryingToViewProfile )
	{
		return
	}

        if ( GetActiveMenu() != file.menu && MenuStack_GetLength() != 0 )
            CloseActiveMenu()

        if ( !MenuStack_Contains( file.menu ) )
        {
            AdvanceMenu( file.menu )
            file.menuOpenTime = UITime()
        }

		EmitUISound( CONTROL_SFX_SELECT_VALID_SIDEMENU )

		RunClientScript( "Control_OpenCharacterSelect" )
	}
}

void function ControlSpawnMenu_ToggleScoreboard( var button )
{
	if( file.hasMenuBeenOpened )
	{
		if( file.scoreboardOpened )
			ControlSpawnMenu_CloseScoreboard( null )
		else
			ControlSpawnMenu_OpenScoreboard( null )
	}
}

void function ControlSpawnMenu_OpenScoreboard( var button )
{
	file.scoreboardOpened = true
	ShowPanel( GetPanel( "ControlRespawn_GenericScoreboardPanel" ) )
	UI_SetScoreboardAnimateIn(  GetPanel( "ControlRespawn_GenericScoreboardPanel" ) )

	Hud_Hide( file.spawnHeader )
	Hud_Hide( file.deathRecapButton )
	Hud_Show( file.respawnStatus )
	foreach( spawnButton in file.spawnButtons )
	{
		Hud_Hide( spawnButton )
	}

	UpdateFooterOptions()
}

void function ControlSpawnMenu_CloseScoreboard( var button )
{
	HidePanel( GetPanel( "ControlRespawn_GenericScoreboardPanel" ) )

	Hud_Show( file.spawnHeader )
	Hud_Show( file.deathRecapButton )
	Hud_Hide( file.respawnStatus )
	foreach( spawnButton in file.spawnButtons )
	{
		Hud_Show( spawnButton )
	}
	file.scoreboardOpened = false

	UpdateDeathRecap()
	UpdateFooterOptions()
}

void function UI_OnButton_Enter( var button )
{
	var chatbox = Hud_GetChild( file.menu, "RespawnChatBox" )

	if ( !HudChat_HasAnyMessageModeStoppedRecently() )
		Hud_StartMessageMode( chatbox )

	Hud_SetVisible( chatbox, true )
}

void function ControlSpawnMenu_OpenGameModeDetails(var button)
{
	if ( !IsFullyConnected() )
		return
	AdvanceMenu( GetMenu( "FeatureTutorialDialog" ) )
}

void function ControlSpawnMenu_OpenLoadoutMenu( var button )
{
	if ( !file.areLoadoutAndLegendSelectMenuButtonsEnabled || !IsUsingLoadoutSelectionSystem() )
	{
		EmitUISound( CONTROL_SFX_SELECT_INVALID_SIDEMENU )
		return
	}
	else
	{
		EmitUISound( CONTROL_SFX_SELECT_VALID_SIDEMENU )
		file.lastScoreboardOpened = file.scoreboardOpened
		LoadoutSelectionMenu_RequestOpenLoadoutMenu( button )
	}
}

void function CreateSpawnButtonToolTip( var button )
{
	ToolTipData toolTipData
	toolTipData.titleText = ""
	toolTipData.descText = ""
	toolTipData.actionHint1 = ""

	Hud_SetToolTipData( button, toolTipData )
	file.buttonTooltipData[ button ] <- toolTipData
}

void function UpdateDeathRecap()
{
	                 

	var blockRui = Hud_GetRui( file.deathRecapButton )
	if ( file.deathRecap.totalDamage == -1 )
	{
		                                                                                 
		RuiSetBool( blockRui, "display", false )
		Hud_Hide( file.deathRecapButton )
		return
	}
	if( !file.scoreboardOpened )
		Hud_Show( file.deathRecapButton )

	DeathRecapDamageData damageBlock = file.deathRecap

	if ( ! EEHHasValidScriptStruct( damageBlock.victimEHandle ) )
	{
		                                                                                          
		                                                                                        
		                                                 
		Warning( "Could not find victimEHandle key %d in eehScriptStructMap", damageBlock.victimEHandle )
		RuiSetBool( blockRui, "display", false )
		Hud_Hide( file.deathRecapButton )
		return
	}

	bool damageDealt = false

	RuiSetImage( blockRui, "weaponIcon", damageBlock.weaponIcon )
	RuiSetBool( blockRui, "mainWeapon", file.deathRecap.isMainWeapon )

	RuiSetString( blockRui, "damageSourceName", damageBlock.damageSourceName )

	RuiSetBool( blockRui, "selected", false )                                                
	RuiSetInt( blockRui, "totalDamage", damageBlock.totalDamage )
	RuiSetInt( blockRui, "hitCount", damageBlock.hitCount )
	RuiSetInt( blockRui, "headShotBits", damageBlock.headShotBits )
	RuiSetString( blockRui, "playerName", damageDealt ? damageBlock.victimName : damageBlock.attackerNamer )
	RuiSetBool( blockRui, "dealt", damageDealt )

	RuiSetBool( blockRui, "knockdown", false )
	RuiSetFloat( blockRui, "updateTime", UITime() )


	RuiSetBool( blockRui, "display", true )
}

void function UpdateJIP()
{
	var rui = Hud_GetRui( file.spawnHeader )

	RuiSetBool( rui, "isJIP", file.isLateJoinPlayer )
}

void function UpdateSpawnButtons()
{
	if ( !IsFullyConnected() )
		return

	if ( GetActiveMenu() != GetParentMenu( file.menu ) )
		return

	if ( IsLobby() )
		return

	var spawnHeader = Hud_GetChild( file.menu, "SpawnHeader" )
	RunClientScript( "UICallback_Control_SpawnHeaderUpdated", spawnHeader, ClientTime() )

	Control_SetAllButtonsEnabled()

	RunClientScript( "UICallback_Control_LaunchSpawnMenuProcessThread" )
	thread ControlSpawnMenu_ProcessWaypointDataThread()
}


void function Control_SetAllButtonsDisabled()
{
	Control_RemoveAllButtonSpawnIcons()
	foreach( button in file.spawnButtons )
	{
		Hud_SetEnabled( button, false )
	}
}

bool function CanOpenScoreboard()
{
	return !file.scoreboardOpened
}
bool function CanCloseScoreboard()
{
	return file.scoreboardOpened
}


void function Control_SetAllButtonsEnabled()
{
	foreach( button in file.spawnButtons )
	{
		Hud_SetEnabled( button, true )
	}
}

void function Control_Respawn_SetKillerInfo( int attackerEHandle = -1, int victimEHandle = -1, int damageSourceID = -1, int damageType = -1, int totalDamage = -1, int hitCount = -1, int headShotBits = -1, float healthFrac = -1.0, float shieldFrac = -1.0, float blockTime = -1.0, string damageSourceName = "", string attackerNamer = "", string victimName = "", asset weaponIcon = $"", bool isMainWeapon = false )
{
	file.deathRecap.attackerEHandle = attackerEHandle
	file.deathRecap.victimEHandle   = victimEHandle
	file.deathRecap.damageSourceID  = damageSourceID
	file.deathRecap.damageType      = damageType
	file.deathRecap.totalDamage     = totalDamage
	file.deathRecap.hitCount        = hitCount
	file.deathRecap.headShotBits    = headShotBits
	file.deathRecap.healthFrac      = healthFrac
	file.deathRecap.shieldFrac      = shieldFrac
	file.deathRecap.blockTime       = blockTime
	file.deathRecap.damageSourceName= damageSourceName
	file.deathRecap.attackerNamer	= attackerNamer
	file.deathRecap.victimName		= victimName
	file.deathRecap.weaponIcon		= weaponIcon
	file.deathRecap.isMainWeapon	= isMainWeapon
}

                                                                                
void function Control_UI_SpawnMenu_SetExpPercentAmountsForSpawns( int spawnOnObjectivePercent, int spawnOnBasePercent, bool isLateJoinPlayer )
{
	if ( spawnOnObjectivePercent >= 0 && spawnOnObjectivePercent <= 100 )
		file.expRewardForSpawnOnObjective = spawnOnObjectivePercent

	if ( spawnOnBasePercent >= 0 && spawnOnBasePercent <= 100 )
		file.expRewardForSpawnOnBase = spawnOnBasePercent

	file.isLateJoinPlayer = isLateJoinPlayer
}

void function ControlSpawnMenu_OnPingButtonClick( var button )
{
	if ( file.focusedSpawnButton == null )
		return

	bool buttonExists = false
	foreach( spawnButton in file.spawnButtons )
	{
		if( file.focusedSpawnButton == spawnButton && file.focusedSpawnButton in file.buttonToWaypointData)
		{
			if( Control_IsSpawnWaypointIndexAnObjective( file.buttonToWaypointData[file.focusedSpawnButton].objID ) )
				buttonExists = true
		}
	}
	if( !buttonExists )
		return

	if ( !(file.focusedSpawnButton in file.buttonToWaypointData) )
	{
		printf( "CONTROL: clicked on spawn button with no associated waypointData" )
		return
	}
	ControlSpawnButtonData data = file.buttonToWaypointData[ file.focusedSpawnButton ]

                         
		RunClientScript( "Control_PingObjectiveFromObjID", data.objID )
       
}

const float CONTROL_DOUBLECLICK_PROTECTION_TIME = 1.0
void function OnSpawnButtonClick( var button )
{
	                                                           
	if ( !(button in file.buttonToWaypointData) )
	{
		printf( "CONTROL: clicked on spawn button with no associated waypointData" )
		EmitUISound( CONTROL_SFX_SELECT_INVALID_SPAWN )
		return
	}

	ControlSpawnButtonData data = file.buttonToWaypointData[ button ]
	                                                                                
	if ( data.waypointTeamUsage != eControlSpawnWaypointUsage.FRIENDLY_TEAM )
	{
		printf( "CONTROL: clicked on spawn button that is not available for spawn ( not usable )" )
		EmitUISound( CONTROL_SFX_SELECT_INVALID_SPAWN )
		return
	}

	                                                                    
	if ( UITime() <= file.spawnButtonClickedTime + CONTROL_DOUBLECLICK_PROTECTION_TIME )
		return

	file.spawnButtonClickedTime = UITime()
	Hud_SetEnabled( button, false )
	EmitUISound( CONTROL_SFX_SELECT_VALID_SPAWN )

	RunClientScript( "UICallback_Control_SpawnButtonClicked", data.waypointType )

	                                                                                                                                                                  
	Control_RemoveAllButtonSpawnIcons()
	data.isSelectedForSpawn = true

	var rui = Hud_GetRui( button )
	RuiSetBool( rui, "isSelectedForSpawn", true )

	foreach ( spawnButton in file.spawnButtons )
	{
		var thisRui = Hud_GetRui( spawnButton )
		RuiSetBool( thisRui, "isAnySpawnSelected", true )
	}

	vector hudSize = <Hud_GetWidth( file.menu ), Hud_GetHeight( file.menu ), 0.0>
	RuiSetFloat2( Hud_GetRui( file.spawnHeader), "selectedPointScreenspace", < data.xPosScreenSpace  / hudSize.x, data.yPosScreenSpace / hudSize.y, 0 > )
}

                                                                                             
void function Control_RemoveAllButtonSpawnIcons()
{
	foreach ( spawnButton in file.spawnButtons )
	{
		var rui = Hud_GetRui( spawnButton )
		RuiSetBool( rui, "isSelectedForSpawn", false )
		RuiSetBool( rui, "isAnySpawnSelected", false )

		if ( spawnButton in file.buttonToWaypointData )
		{
			ControlSpawnButtonData data = file.buttonToWaypointData[ spawnButton ]
			data.isSelectedForSpawn = false
		}
	}
}

void function OnSpawnButtonGetFocus( var button )
{
	file.focusedSpawnButton = button

	UpdateFooterOptions()
}


void function OnSpawnButtonLoseFocus( var button )
{
	file.focusedSpawnButton = null

	UpdateFooterOptions()

}


bool function CanShowAttackPing()
{
	if ( file.focusedSpawnButton == null )
		return false

	return !IsFocusedSpawnPointPingedByLocalPlayer() && IsSpawnButtonFocused( true )
}

bool function CanShowDefendPing()
{
	if ( file.focusedSpawnButton == null )
		return false

	return !IsFocusedSpawnPointPingedByLocalPlayer() && IsSpawnButtonFocused( false )
}

bool function CanShowCancelPing()
{
	if ( file.focusedSpawnButton == null )
		return false

	return IsFocusedSpawnPointPingedByLocalPlayer()
}

bool function IsFocusedSpawnPointPingedByLocalPlayer()
{
	foreach( button in file.spawnButtons )
	{
		if( file.focusedSpawnButton == button && file.focusedSpawnButton in file.buttonToWaypointData)
		{
			ControlSpawnButtonData data = file.buttonToWaypointData[file.focusedSpawnButton]
			if( Control_IsSpawnWaypointIndexAnObjective( file.lastLocalPingObjID ) && data.objID == file.lastLocalPingObjID )
				return true
		}
	}

	return false
}

bool function IsSpawnButtonFocused( bool isAttack )
{
	foreach( button in file.spawnButtons )
	{
		if( file.focusedSpawnButton == button && file.focusedSpawnButton in file.buttonToWaypointData)
		{
			ControlSpawnButtonData data = file.buttonToWaypointData[file.focusedSpawnButton]
			if( Control_IsSpawnWaypointIndexAnObjective( data.objID ) && data.localPlayerAlliance != ALLIANCE_NONE)
			{
				if ( isAttack )
				{
					if( data.localPlayerAlliance != data.currentOwner )
						return true
				}
				else
				{
					if( data.localPlayerAlliance == data.currentOwner )
						return true
				}
			}
		}
	}

	return false
}

                                                                                                                                                                                                           
void function SetWaypointDataForUI( int waypointEHI,
									bool isVisible,
									int waypointTeamUsage,
									int waypointType,
									float xPos,
									float yPos,
									string tooltipNameInfo,
									float capturePercentage = 0.0,
									int currentControllingTeam = ALLIANCE_NONE,
									int currentOwner = ALLIANCE_NONE,
									int neutralPointOwnership = ALLIANCE_NONE,
									int localPlayerAlliance = ALLIANCE_NONE,
									bool hasEmphasis = false,
									int team0PlayersOnObj = 0,
									int team1PlayersOnObj = 0,
									int numTeamPings = 0
									)
{
	ControlSpawnButtonData data
	if ( waypointEHI in file.EHItoWaypointData )
		data = file.EHItoWaypointData[ waypointEHI ]

	data.waypointEHI = waypointEHI
	data.isVisible = isVisible
	data.waypointTeamUsage = waypointTeamUsage
	data.objID = GetObjectiveIDFromWaypointType( waypointType )
	data.waypointType = waypointType
	data.xPosScreenSpace = xPos
	data.yPosScreenSpace = yPos
	data.tooltipNameInfo = tooltipNameInfo

	data.capturePercentage = capturePercentage
	data.currentControllingTeam = currentControllingTeam
	data.currentOwner = currentOwner
	data.neutralPointOwnership = neutralPointOwnership
	data.localPlayerAlliance = localPlayerAlliance
	data.hasEmphasis = hasEmphasis
	data.team0PlayersOnObj = team0PlayersOnObj
	data.team1PlayersOnObj = team1PlayersOnObj
	data.numTeamPings = numTeamPings
	file.EHItoWaypointData[ waypointEHI ] <- data
}

                                                          
                                                    
int function GetObjectiveIDFromWaypointType( int waypointType )
{
	int objectiveID = -1
	switch( waypointType )
	{
		case eControlWaypointTypeIndex.OBJECTIVE_A:
		case eControlWaypointTypeIndex.OBJECTIVE_B:
		case eControlWaypointTypeIndex.OBJECTIVE_C:
			objectiveID = waypointType
			break
		default:
			objectiveID = -1
			break
	}

	return objectiveID
}

void function SetLastLocalPingObjIDForUI( int lastLocalPingObjID )
{
	if( file.lastLocalPingObjID != lastLocalPingObjID )
	{
		file.lastLocalPingObjID = lastLocalPingObjID
		UpdateFooterOptions()
	}
	else
		file.lastLocalPingObjID = lastLocalPingObjID
}

void function ClearAllWaypointData()
{
	file.buttonToWaypointData.clear()
	file.waypointDataToButton.clear()
	file.EHItoWaypointData.clear()
}


void function ClearWaypointDataForUI( int waypointEHI )
{
	if ( waypointEHI in file.EHItoWaypointData )
	{
		ControlSpawnButtonData waypointData = file.EHItoWaypointData[ waypointEHI ]
		if ( waypointData in file.waypointDataToButton )
		{
			var button = file.waypointDataToButton[ waypointData ]
			if ( button in file.buttonToWaypointData )
				delete file.buttonToWaypointData[ button ]
			delete file.waypointDataToButton[ waypointData ]
		}
		delete file.EHItoWaypointData[ waypointEHI ]
	}
}

void function ControlSpawnMenu_ProcessWaypointDataThread()
{
	Signal( uiGlobal.signalDummy, "ControlSpawnMenuUpdate" )
	EndSignal( uiGlobal.signalDummy, "ControlSpawnMenuUpdate" )
	EndSignal( uiGlobal.signalDummy, "ControlSpawnMenuClosed" )
	EndSignal( uiGlobal.signalDummy, "CleanupInGameMenus" )

	while ( MenuStack_Contains( file.menu ) )
	{
		if(!file.scoreboardOpened)
		{
			                         
			foreach( button in file.spawnButtons )
			{
				if ( !( button in file.buttonToWaypointData ) )
				{
					Hud_Hide( button )
				}
			}

			                                                    
			foreach( handle, waypointData in file.EHItoWaypointData )
			{
				                                                                                                                                         
				if ( !( waypointData in file.waypointDataToButton ) )
				{
					                                                                   
					foreach( button in file.spawnButtons )
					{
						                                                
						if ( !( button in file.buttonToWaypointData ) )
						{
							                                                                          
							file.waypointDataToButton[ waypointData ] <- button
							file.buttonToWaypointData[ button ] <- waypointData
							break
						}
					}
				}
			}

			                                                 
			foreach( button, waypointData in file.buttonToWaypointData )
			{
				if ( waypointData.isVisible )
					Hud_Show( button )
				else
					Hud_Hide( button )

				vector hudSize = <Hud_GetWidth( file.menu ), Hud_GetHeight( file.menu ), 0.0>
				                                                       
				                                                                                                                                                                
				Hud_SetEnabled( button, waypointData.isVisible )

				                                                     
				Hud_SetPos( button, waypointData.xPosScreenSpace - (22.5  * (hudSize.x / 1920) ), waypointData.yPosScreenSpace - (22.5  * (hudSize.y / 1080) ))

				var spawnHeader = Hud_GetChild( file.menu, "SpawnHeader" )
				var spawnHeaderRui
				if ( spawnHeader != null )
					spawnHeaderRui = Hud_GetRui( spawnHeader )

				var rui = Hud_GetRui( button )
				if ( rui != null )
				{
					switch( waypointData.waypointType )
					{
						                                                    
						case eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_A:
						case eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_B:
							RuiSetImage( rui, "centerImage", CONTROL_WAYPOINT_BASE_ICON )
							RuiSetBool( rui, "shouldShowObjective", false )
							RuiSetBool( rui, "shouldAddNonObjectiveSpawnWings", true )
							RuiSetInt( rui, "numTeamPings", 0 )
							if ( spawnHeaderRui != null )
							{
								if ( Control_IsSpawnWaypointHomebaseForAlliance( waypointData.waypointType, waypointData.localPlayerAlliance ) )
									RuiSetFloat2( spawnHeaderRui, "baseSpawnScreenspace", <waypointData.xPosScreenSpace / hudSize.x, waypointData.yPosScreenSpace / hudSize.y, 0.0> )
								      
								                                                                                                                                                   
							}

							break

						case eControlWaypointTypeIndex.SQUAD_SPAWN:
							RuiSetImage( rui, "centerImage", CONTROL_WAYPOINT_PLAYER_ICON )
							RuiSetBool( rui, "shouldShowObjective", false )
							RuiSetBool( rui, "shouldAddNonObjectiveSpawnWings", false )
							break

						case eControlWaypointTypeIndex.OBJECTIVE_A:
						case eControlWaypointTypeIndex.OBJECTIVE_B:
						case eControlWaypointTypeIndex.OBJECTIVE_C:
							RuiSetBool( rui, "shouldShowObjective", true )
							RuiSetBool( rui, "shouldAddNonObjectiveSpawnWings", false )
							RuiSetString( rui, "objectiveName", waypointData.tooltipNameInfo )
							RuiSetInt( rui, "numTeamPings", waypointData.numTeamPings )
							if ( spawnHeaderRui != null )
							{
								if ( waypointData.waypointType == eControlWaypointTypeIndex.OBJECTIVE_B )                          
								{
									RuiSetFloat2( spawnHeaderRui, "centralSpawnScreenspace", <waypointData.xPosScreenSpace / hudSize.x, waypointData.yPosScreenSpace / hudSize.y, 0.0> )
									RuiSetBool( spawnHeaderRui, "canSpawnOnCentral", waypointData.waypointTeamUsage == eControlSpawnWaypointUsage.FRIENDLY_TEAM )
								}
								else if ( Control_IsSpawnWaypointFOBForAlliance( waypointData.waypointType, waypointData.localPlayerAlliance ) )                               
								{
									RuiSetFloat2( spawnHeaderRui, "fobSpawnScreenspace", <waypointData.xPosScreenSpace / hudSize.x, waypointData.yPosScreenSpace / hudSize.y, 0.0> )
									RuiSetBool( spawnHeaderRui, "canSpawnOnFOB", waypointData.waypointTeamUsage == eControlSpawnWaypointUsage.FRIENDLY_TEAM )
								}

								                                                                                                             
								RuiSetBool( spawnHeaderRui, "isSpawnOnCentralDisabled", file.isSpawnOnCentralDisabled )
							}
							break

						case eControlWaypointTypeIndex.MRB_SPAWN:
							RuiSetImage( rui, "centerImage", RESPAWN_BEACON_ICON )
							RuiSetBool( rui, "shouldShowObjective", false )
							RuiSetBool( rui, "shouldAddNonObjectiveSpawnWings", true )
							RuiSetBool( rui, "shouldShowTimer", true )
							RuiSetBool( rui, "shouldDisplayMRBIconBacking", false )                                                               
							RuiSetGameTime( rui, "timerEndTime", waypointData.capturePercentage )
							break
					}

					bool isUsable = waypointData.waypointTeamUsage == eControlSpawnWaypointUsage.FRIENDLY_TEAM ? true : false
					RuiSetBool( rui, "isUsable", isUsable )
					RuiSetInt( rui, "currentControllingTeam", waypointData.currentControllingTeam )
					RuiSetInt( rui, "currentOwner", waypointData.currentOwner )
					RuiSetInt( rui, "neutralPointOwnership", waypointData.neutralPointOwnership )
					RuiSetInt( rui, "yourTeamIndex", waypointData.localPlayerAlliance )
					RuiSetFloat( rui, "capturePercentage", waypointData.capturePercentage )
					RuiSetBool( rui, "hasEmphasis", waypointData.hasEmphasis )
					RuiSetInt( rui, "team0PlayersOnObj", waypointData.team0PlayersOnObj )
					RuiSetInt( rui, "team1PlayersOnObj", waypointData.team1PlayersOnObj )
				}

				SetSpawnButtonTooltipData( button )
			}
		}

		WaitFrame()
	}
}


void function SetSpawnButtonTooltipData( var button )
{
	if ( !( button in file.buttonToWaypointData ) )
		return

	ControlSpawnButtonData buttonData = file.buttonToWaypointData[ button ]

	ToolTipData toolTipData = file.buttonTooltipData[ button ]
	string finalNameInformation = buttonData.tooltipNameInfo

	                                                                                                         
	if ( !file.isLateJoinPlayer )
	{
		switch( buttonData.waypointType )
		{
			case eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_A:
			case eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_B:
				if ( file.expRewardForSpawnOnBase >= 100 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_BASE" )                                                    
				}
				else if ( file.expRewardForSpawnOnBase > 0 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_POINT", file.expRewardForSpawnOnBase )                                                          
				}
				else
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_BASE_NO_EXP" )                                    
				}
				break
			case eControlWaypointTypeIndex.OBJECTIVE_A:
			case eControlWaypointTypeIndex.OBJECTIVE_B:
			case eControlWaypointTypeIndex.OBJECTIVE_C:
				if ( file.expRewardForSpawnOnObjective >= 100 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_BASE" )                                                    
				}
				else if ( file.expRewardForSpawnOnObjective > 0 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_POINT", file.expRewardForSpawnOnObjective )                                                          
				}
				else
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_POINT_NO_EXP" )                                         
				}
				break
			case eControlWaypointTypeIndex.SQUAD_SPAWN:
				toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_SQUAD" )
				break
			case eControlWaypointTypeIndex.MRB_SPAWN:
				if ( file.expRewardForSpawnOnObjective >= 100 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_BASE" )                                                    
				}
				else if ( file.expRewardForSpawnOnObjective > 0 )
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_POINT", file.expRewardForSpawnOnObjective )                                                          
				}
				else
				{
					toolTipData.descText = Localize( "#CONTROL_RESPAWN_ON_MRB_NO_EXP" )                                   
				}
				break
			default:
				break
		}

	}
	else                                               
	{
		toolTipData.descText = Localize( "#CONTROL_RESPAWN_LATE_JOIN_PLAYER" )
	}

	toolTipData.titleText = Localize( "#CONTROL_RESPAWN_TITLE", finalNameInformation )
	toolTipData.actionHint1 = Localize( "#CONTROL_RESPAWN_ACTION" )

	int localPlayerAlliance = buttonData.localPlayerAlliance

	                                              
	bool isFOB = Control_IsPointAnFOB( buttonData.waypointType )
	bool isFOBForLocalPlayer = Control_IsSpawnWaypointFOBForAlliance( buttonData.waypointType, localPlayerAlliance )

	if ( buttonData.isSelectedForSpawn )                                        
	{
		toolTipData.descText  = Localize( "#CONTROL_RESPAWN_ALREADY_SELECTED_DESC" )
		toolTipData.actionHint1 = Localize( "#CONTROL_RESPAWN_ACTION_CANCEL" )
	}
	else if ( buttonData.waypointTeamUsage != eControlSpawnWaypointUsage.NOT_USABLE )                                                                                
	{
		if ( isFOB )                                                                                                              
		{
			if ( isFOBForLocalPlayer )
			{
				toolTipData.tooltipFlags = 0
			}
			else
			{
				toolTipData.titleText = Localize( "#CONTROL_RESPAWN_NOT_AVIALABLE_TITLE" )
				toolTipData.descText  = Localize( "#CONTROL_RESPAWN_NOT_AVAIL_ENEMY_HOME_POINT" )
				toolTipData.actionHint1 = ""
			}
		}
		else                                                                        
		{
			if ( localPlayerAlliance != buttonData.currentOwner && buttonData.waypointType != eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_A && buttonData.waypointType != eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_B )
			{
				toolTipData.titleText = Localize( "#CONTROL_RESPAWN_NOT_AVIALABLE_TITLE" )
				toolTipData.descText  = Localize( "#CONTROL_ENEMY_OBJ_DESC" )
			}
			else
			{
				toolTipData.tooltipFlags = 0
			}
		}
	}
	else if ( buttonData.waypointType != eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_A && buttonData.waypointType != eControlWaypointTypeIndex.HOMEBASE_ALLIANCE_B )                                                                                     
	{
		toolTipData.titleText = Localize( "#CONTROL_RESPAWN_NOT_AVIALABLE_TITLE" )
		if ( isFOB && !isFOBForLocalPlayer )
		{
			toolTipData.descText  = Localize( "#CONTROL_RESPAWN_NOT_AVAIL_ENEMY_HOME_POINT" )
		}
		else if ( buttonData.waypointType == eControlWaypointTypeIndex.OBJECTIVE_B && !Control_IsSpawningOnObjectiveBAllowed() )
		{
			toolTipData.descText  = Localize( "#CONTROL_BSPAWNS_DISABLED" )
		}
		else if ( buttonData.currentOwner == ALLIANCE_NONE )
		{
			toolTipData.descText  = Localize( "#CONTROL_EMPTY_OBJ_DESC" )
		}
		else if ( localPlayerAlliance != buttonData.currentOwner )
		{
			toolTipData.descText  = Localize( "#CONTROL_ENEMY_OBJ_DESC" )
		}
		else
		{
			toolTipData.descText  = Localize( "#CONTROL_RESPAWN_NOT_AVAIL_MISSING_HOME_POINT" )
		}

		toolTipData.actionHint1 = ""

	}
	else                                             
	{
		toolTipData.titleText = Localize( "#CONTROL_RESPAWN_NOT_AVIALABLE_TITLE" )
		toolTipData.descText  = Localize( "#CONTROL_RESPAWN_NOT_AVAIL_ENEMY_HOME" )
		toolTipData.actionHint1 = ""
	}
	toolTipData.actionHint2 = ""
	if ( Control_IsSpawnWaypointIndexAnObjective( buttonData.waypointType ) )                                       
	{
		if ( CanShowAttackPing() )
			toolTipData.actionHint2 = Localize( "#CONTROL_PING_OBJECTIVE_ATTACK" )
		else if ( CanShowDefendPing() )
			toolTipData.actionHint2 = Localize( "#CONTROL_PING_OBJECTIVE_DEFEND" )
		else
			toolTipData.actionHint2 = Localize( "#CONTROL_PING_OBJECTIVE_CANCEL" )
	}

	Hud_SetToolTipData( button, toolTipData )
	file.buttonTooltipData[ button ] <- toolTipData
}

void function ControlSpawnMenu_UpdatePlayerLoadout()
{
	if ( !IsFullyConnected() || ( IsFullyConnected() && !IsUsingLoadoutSelectionSystem() ) )
		return

	int loadoutIndex = LoadoutSelection_GetSelectedLoadoutSlotIndex_CL_UI()
	if ( loadoutIndex < 0 || loadoutIndex >= LOADOUTSELECTION_MAX_TOTAL_LOADOUT_SLOTS )
		return

	                               
	RunClientScript( "UICallback_LoadoutSelection_SetConsumablesCountRui", file.loadoutButton, loadoutIndex )

	                                               
	for ( int weaponIndex = 0; weaponIndex < LOADOUTSELECTION_MAX_WEAPONS_PER_LOADOUT; weaponIndex++ )
	{
		var weaponIcon = Hud_GetChild( file.menu, "CurrentLoadoutIconWeapon" + weaponIndex )
		RunClientScript( "UICallback_LoadoutSelection_BindWeaponRui", weaponIcon, loadoutIndex, weaponIndex )
	}

	                                                   
	for ( int consumableIndex = 0; consumableIndex < LOADOUTSELECTION_MAX_CONSUMABLES_PER_LOADOUT; consumableIndex++ )
	{
		var consumableIcon = Hud_GetChild( file.menu, "CurrentLoadoutIconConsumable" + consumableIndex )
		RunClientScript( "UICallback_LoadoutSelection_BindItemIcon", consumableIcon, loadoutIndex, -1, consumableIndex )
	}
}

                                                                                                                                        
                                               
void function ControlSpawnMenu_SetLoadoutAndLegendSelectMenuIsEnabled( bool isEnabled )
{
	if ( isEnabled )
	{
		file.areLoadoutAndLegendSelectMenuButtonsEnabled = true
	}
	else
	{
		file.areLoadoutAndLegendSelectMenuButtonsEnabled = false
		RunClientScript( "Control_CloseCharacterSelectOnlyIfOpen" )

		LoadoutSelectionMenu_CloseLoadoutMenu()
	}
}
      
