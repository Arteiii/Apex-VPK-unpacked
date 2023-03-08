global function InitFiringRangeSettingsGeneralPanel

global function Firing_Range_SetIsRangeMaster
global function Firing_Range_SetGeneralSetting
global function Firing_Range_SetDummieSetting
                   
                                                  
      
struct
{
	var panel
	var contentPanelParent
	var contentPanel

	var scrollBar
	var scrollFrame

	array< var > buttons = []

	string FRSettings
	string CRSettings

	table< int, var > generalSettingsToHud
	table< int, var > dummieBehaviorSettingsToHud

	table< int, float > generalSettings
	table< int, float > dummieBehaviorSettings

	bool isRangeMaster = false
                    
                                         
                                            
       

	bool isOpened = false
} file

void function InitFiringRangeSettingsGeneralPanel( var panel )
{
	file.panel = panel

	file.contentPanelParent = Hud_GetChild( panel, "ModeOptionsPanel" )
	file.contentPanel = Hud_GetChild( file.contentPanelParent, "ContentPanel" )
	file.scrollBar = Hud_GetChild( file.contentPanelParent, "ScrollBar" )
	file.scrollFrame = Hud_GetChild( file.contentPanelParent, "ScrollFrame" )

	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, OnFiringRangeSettingsGeneralPanel_Show )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, OnFiringRangeSettingsGeneralPanel_Hide )

	SetupSettings()

	SettingsPanel_SetContentPanelHeight( file.contentPanel )
	ScrollPanel_InitPanel( file.contentPanelParent )
	ScrollPanel_InitScrollBar( file.contentPanelParent, file.scrollBar )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
	AddPanelFooterOption( panel, RIGHT, BUTTON_START, true, "#HINT_SYSTEM_MENU_GAMEPAD", "#HINT_SYSTEM_MENU_KB", TryOpenSystemMenu )

	#if DEV
		AddPanelFooterOption( panel, LEFT, BUTTON_STICK_LEFT, true, "#LEFT_STICK_DEV_MENU", "#DEV_MENU", OpenDevMenu )
	#endif
}

void function SetupSettings()
{
	file.generalSettingsToHud[ eFRSettingType.SHOWDYNSTATS ] <- Hud_GetChild( file.contentPanel, "SwitchDynamicStats" )
	file.generalSettingsToHud[ eFRSettingType.INFINITEMAGS ] <- Hud_GetChild( file.contentPanel, "SwitchInfiniteAmmo" )
	file.generalSettingsToHud[ eFRSettingType.SHOWHITMARKS ] <- Hud_GetChild( file.contentPanel, "SwitchHitIndicators" )
	file.generalSettingsToHud[ eFRSettingType.FRIENDLYFIRE ] <- Hud_GetChild( file.contentPanel, "SwitchFriendlyFire" )
	file.generalSettingsToHud[ eFRSettingType.TARGETSPEED ] <- Hud_GetChild( file.contentPanel, "SwitchTargetSpeed" )
	file.generalSettingsToHud[ eFRSettingType.FRDUMMIESHIELDLVL ] <- Hud_GetChild( file.contentPanel, "SwitchDummyShield" )

	file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorStayInPlace" )
	file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STRAFE ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorStrafe" )
	file.generalSettingsToHud[ eFRSettingType.FRDUMMIESPEED ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorStrafeSpeed" )
	file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorCanStand" )
	file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANCROUCH ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorCanCrouch" )
	file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.RANDINTERVALS ] <- Hud_GetChild( file.contentPanel, "SwitchBehaviorRandIntervals" )

	          
	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.SHOWDYNSTATS ], "#FRSETTING_SHOWDYNSTATS", "#FRSETTING_SHOWDYNSTATS_DESC", $"", false, false )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.SHOWDYNSTATS ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.SHOWDYNSTATS, btn ) } )

	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.INFINITEMAGS ], "#FRSETTING_INFINITEMAGS", "#FRSETTING_INFINITEMAGS_DESC", $"", false, false )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.INFINITEMAGS ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.INFINITEMAGS, btn ) } )

	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.SHOWHITMARKS ], "#FRSETTING_SHOWHITMARKS", "#FRSETTING_SHOWHITMARKS_DESC", $"", false, false )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.SHOWHITMARKS ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.SHOWHITMARKS, btn ) } )

	         
	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.FRIENDLYFIRE ], "#HUD_FRSETTING_FRIENDLYFIRE", "#HUD_FRSETTING_FRIENDLYFIRE_DESC", $"", false, true )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.FRIENDLYFIRE ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.FRIENDLYFIRE, btn ) } )

	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.TARGETSPEED ], "#FRSETTING_TARGETSPEED", "#FRSETTING_TARGETSPEED_DESC", $"", false, true  )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.TARGETSPEED ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.TARGETSPEED, btn ) } )

	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESHIELDLVL ], "#FRSETTING_DUMMIESHIELD", "#FRSETTING_DUMMIESHIELD_DESC", $"", false, true  )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESHIELDLVL ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.FRDUMMIESHIELDLVL, btn ) } )

	         
	SetupSettingsButton( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ], "#FRSETTING_DUMMIEINPLACE", "#FRSETTING_DUMMIEINPLACE_DESC", $"", false, true  )
	AddButtonEventHandler( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ], UIE_CHANGE, void function( var btn ){ Firing_Range_DummieSettingChanged( eDummieBehaviorType.STAYINPLACE, btn ) } )

	SetupSettingsButton( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STRAFE ] , "#FRSETTING_DUMMIESTRAFE", "#FRSETTING_DUMMIESTRAFE_DESC", $"", false, true  )
	AddButtonEventHandler( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STRAFE ],  UIE_CHANGE, void function( var btn ){ Firing_Range_DummieSettingChanged( eDummieBehaviorType.STRAFE, btn ) } )

	SetupSettingsButton( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESPEED ], "#FRSETTING_DUMMIESTRAFESPEED", "#FRSETTING_DUMMIESTRAFESPEED_DESC", $"", false, true  )
	AddButtonEventHandler( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESPEED ], UIE_CHANGE, void function( var btn ){ Firing_Range_GeneralSettingChanged( eFRSettingType.FRDUMMIESPEED, btn ) } )

	SetupSettingsButton( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ], "#FRSETTING_DUMMIESTAND", "#FRSETTING_DUMMIESTAND_DESC", $"", false, true  )
	AddButtonEventHandler( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ], UIE_CHANGE, void function( var btn ){ Firing_Range_DummieSettingChanged( eDummieBehaviorType.CANSTAND, btn ) } )

	SetupSettingsButton( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANCROUCH ], "#FRSETTING_DUMMIECROUCH", "#FRSETTING_DUMMIECROUCH_DESC", $"", false, true  )
	AddButtonEventHandler( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANCROUCH ], UIE_CHANGE, void function( var btn ){ Firing_Range_DummieSettingChanged( eDummieBehaviorType.CANCROUCH, btn ) } )

	SetupSettingsButton( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.RANDINTERVALS ], "#FRSETTING_DUMMIERANDOM", "#FRSETTING_DUMMIERANDOM_DESC", $"", false, true  )
	AddButtonEventHandler( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.RANDINTERVALS ], UIE_CHANGE, void function( var btn ){ Firing_Range_DummieSettingChanged( eDummieBehaviorType.RANDINTERVALS, btn ) } )
}
const string BUTTONTEXT_INDENT = "    "                    

void function OnFiringRangeSettingsGeneralPanel_Show( var panel )
{
	file.isOpened = true
	RunClientScript( "FRSettings_Client_Update" )

                    
                        
                          
                                                                                      

                                                                                                       
                                                                                                     
                                                                                                     

                                                                                                   
                                                                                                            
                                                                                                   

                                                                                          
                                                                                         
                                                                                                 
                                                                                                     

                      
   
                                                                                                                           
                                                                                                    

                                                                                                                         
                                                                                                  

                                                                                                                         
                                                                                                  

                                                                                 
                                                                                                

                                                                                            
                                                                                                         

                                                                                                 
                                                                                                
   
       

	ScrollPanel_SetActive( file.contentPanelParent, true )

	SettingsPanel_SetContentPanelHeight( file.contentPanel )
	ScrollPanel_Refresh( file.contentPanelParent )

	UpdateDetails()
}

void function OnFiringRangeSettingsGeneralPanel_Hide( var panel )
{
	ScrollPanel_SetActive( file.contentPanelParent, false )
	file.isOpened = false
}

void function UpdateDetails()
{
	int partySize = GetTeamSize( GetTeam() )
	bool isAlone = partySize <= 1
	Hud_SetEnabled( file.generalSettingsToHud[ eFRSettingType.FRIENDLYFIRE ], file.isRangeMaster && !isAlone )
	Hud_SetEnabled( file.generalSettingsToHud[ eFRSettingType.TARGETSPEED ], file.isRangeMaster )
	Hud_SetEnabled( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESHIELDLVL ], file.isRangeMaster )

	                                                                      
	bool stayStill = int( Hud_GetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ] ) ) == 1
	bool canStrafe = int( Hud_GetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STRAFE ] ) ) == 1

	if( file.isRangeMaster && !canStrafe && !stayStill )
		Hud_SetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ], string( 1 ) )

	Hud_SetEnabled( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STAYINPLACE ], file.isRangeMaster && canStrafe )
	Hud_SetEnabled( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.STRAFE ], file.isRangeMaster )
	Hud_SetEnabled( file.generalSettingsToHud[ eFRSettingType.FRDUMMIESPEED ], file.isRangeMaster && canStrafe )

	                                                            
	bool canStand = int( Hud_GetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ] ) ) == 1
	bool canCouch = int( Hud_GetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANCROUCH ] ) ) == 1

	if( file.isRangeMaster && !canCouch && !canStand )
		Hud_SetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ], string( 1 ) )

	Hud_SetEnabled( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANSTAND ], file.isRangeMaster && canCouch )
	Hud_SetEnabled( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.CANCROUCH ], file.isRangeMaster )
	Hud_SetEnabled( file.dummieBehaviorSettingsToHud[ eDummieBehaviorType.RANDINTERVALS ], file.isRangeMaster )
}

void function Firing_Range_SetIsRangeMaster( bool value )
{
	file.isRangeMaster = value

	UpdateDetails()
}

void function Firing_Range_SetGeneralSetting( int setting, float value )
{
	if( setting in file.generalSettings && file.generalSettings[ setting ] == value )
		return

	if( setting in file.generalSettingsToHud )
	{
		if( file.isRangeMaster && !( setting in file.generalSettings ))
		{
			Hud_SetDialogListSelectionValue( file.generalSettingsToHud[ setting ], string( value ) )
		}
		else if( !file.isRangeMaster && ( !( setting in file.generalSettings ) || value != file.generalSettings[ setting ] ) )
		{
			Hud_SetDialogListSelectionValue( file.generalSettingsToHud[ setting ], string( value ) )
		}
	}

	file.generalSettings[ setting ] <- value
	UpdateDetails()
}

void function Firing_Range_SetDummieSetting( int setting, float value )
{
	if( setting in file.dummieBehaviorSettings && file.dummieBehaviorSettings[ setting ] == value )
		return

	if( setting in file.dummieBehaviorSettingsToHud )
	{
		if( file.isRangeMaster && !( setting in file.dummieBehaviorSettings ))
		{
			Hud_SetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ setting ], string( value ) )
		}
		else if( !file.isRangeMaster && ( !( setting in file.dummieBehaviorSettings ) || value != file.dummieBehaviorSettings[ setting ] ) )
		{
			Hud_SetDialogListSelectionValue( file.dummieBehaviorSettingsToHud[ setting ], string( value ) )
		}
	}

	file.dummieBehaviorSettings[ setting ] <- value
	UpdateDetails()
}
                   
                                                                            
 
                                                                                          
        

                                               
  
                                                                     
   
                                                                                               
   
                                                                                                                                
   
                                                                                               
   
  

                                             
                
 
      

void function Firing_Range_GeneralSettingChanged( int setting, var btn )
{
	if( !file.isOpened )
		return

	int index = Hud_GetDialogListSelectionIndex( btn )
	int indexValue = int( Hud_GetDialogListSelectionValue( btn ) )
	bool boolValue = bool( index )

	switch( setting )
	{
		case eFRSettingType.SHOWDYNSTATS:
			file.generalSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_DynStats", boolValue )
			break
		case eFRSettingType.INFINITEMAGS:
			file.generalSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_InfiniteReloads", boolValue )
			break
		case eFRSettingType.SHOWHITMARKS:
			file.generalSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_HitMarks", boolValue )
			break
		default:
			break
	}

	UpdateDetails()
	                                       
	if( !file.isRangeMaster )
		return

	switch( setting )
	{
		case eFRSettingType.FRIENDLYFIRE:
			file.generalSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_FriendlyFire", boolValue )
			break
		case eFRSettingType.TARGETSPEED:
			file.generalSettings[ setting ] <- float( indexValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_TargetSpeed_Change", indexValue )
			break
		case eFRSettingType.FRDUMMIESPEED:
			file.generalSettings[ setting ] <- float( indexValue )
			Remote_ServerCallFunction( "UCB_SV_FRDummie_Speed_Change", indexValue )
			break
		case eFRSettingType.FRDUMMIESHIELDLVL:
			file.generalSettings[ setting ] <- float( indexValue )
			Remote_ServerCallFunction( "UCB_SV_FRDummie_ShieldLevel_Change", indexValue )
			break
		default:
			break
	}

	UpdateDetails()
}

void function Firing_Range_DummieSettingChanged( int setting, var btn )
{
	if( !file.isOpened )
		return


	int index = Hud_GetDialogListSelectionIndex( btn )
	bool boolValue = bool( index )

	                   
	if( !file.isRangeMaster )
		return

	switch( setting )
	{
		case eDummieBehaviorType.STAYINPLACE:
			file.dummieBehaviorSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_BehaviorBools", eDummieBehaviorType.STAYINPLACE, boolValue )
			break
		case eDummieBehaviorType.STRAFE:
			file.dummieBehaviorSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_BehaviorBools", eDummieBehaviorType.STRAFE, boolValue )
			break
		case eDummieBehaviorType.CANSTAND:
			file.dummieBehaviorSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_BehaviorBools", eDummieBehaviorType.CANSTAND, boolValue )
			break
		case eDummieBehaviorType.CANCROUCH:
			file.dummieBehaviorSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_BehaviorBools", eDummieBehaviorType.CANCROUCH, boolValue )
			break
		case eDummieBehaviorType.RANDINTERVALS:
			file.dummieBehaviorSettings[ setting ] <- float( boolValue )
			Remote_ServerCallFunction( "UCB_SV_FRSetting_BehaviorBools", eDummieBehaviorType.RANDINTERVALS, boolValue )
			break
		default:
			break
	}

	UpdateDetails()
}

                                      
void function SetUpOptionsButton( var button, FiringRangeOption option )
{
	HudElem_SetRuiArg( button, "buttonText", option.name )

	if( !file.buttons.contains( button ) )
	{
		                                                                     
		AddButtonEventHandler( button, UIE_CLICK,             
			void function( var button ) : ( option )
			{
				if(option.onChangeCallback != null )
					option.onChangeCallback( button )
			} )
	}

	ToolTipData toolTipData
	toolTipData.titleText = option.name
	toolTipData.descText = option.description
	Hud_SetToolTipData( button, toolTipData )

	file.buttons.append( button )
}
                   
                                                   
 
                                                                                                                                  
 

                                                   
 
                                                                                                                                  
 

                                                   
 
                                                                                                                                  
 

                                                    
 
                                                                                                                                   
 

                                                   
 
                                                                                                             
 

                                          
 
                                                                
 

                                                   
 
                                                                  
 

      

void function TryOpenSystemMenu( var panel )
{
	if ( InputIsButtonDown( BUTTON_START ) )
		return

	OpenSystemMenu()
}
