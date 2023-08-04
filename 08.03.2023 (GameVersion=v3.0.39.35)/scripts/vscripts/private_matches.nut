global function PrivateMatch_Init
global function IsPrivateMatchLobby
global function PrivateMatch_RegisterNetworking

#if SERVER || CLIENT
global function PrivateMatch_GetMaxTeamsForSelectedGamemode
#endif

#if SERVER
                                              
                                               
                                                  

                 
                                       

                                                               
                                                           
                                                            
                                                                      

                                                        
                                                     
                                                      
                                                      
                                                         
                                                        
                                                          
                                                              

#endif


#if CLIENT
global function PrivateMatch_ClientFrame
global function PrivateMatch_GetPlayerTeamStats
global function PrivateMatch_GetTeamName

global function ServerCallback_EnableGameStatusMenu
global function ServerCallback_PrivateMatch_SquadEliminated
global function PrivateMatch_OpenGameStatusMenu
global function PrivateMatch_SortPlayersByName
global function PrivateMatch_ToggleSurveyRing

global function PrivateMatch_ClientOnSquadEliminated
#if DEV
global function DEV_ShowSpectatorButtonHints
#endif     
#endif

#if UI
global function PrivateMatch_CreateMatchEndEarlyDialog
global function PrivateMatch_SetSelectedPlaylist
#endif

global const string MAX_PLAYERS_PLAYLIST_VAR = "max_players"
global const string MAX_TEAMS_PLAYLIST_VAR = "max_teams"
global const int PRIVATEMATCH_ISREADY_BIT = 1
global const int PRIVATEMATCH_ISPRELOADING_BIT = 2

global const string CUSTOM_AIM_ASSIST_CONVAR_NAME = "sv_private_assist_style_override"
global const string GLOBAL_AIM_ASSIST_CONVAR_NAME = "sv_tournament_assist_style_override"
global const string CUSTOM_ANONYMOUS_MODE_CONVAR_NAME = "sv_tournament_anonymous_mode"
global const string OBSERVER_PRESET_TEAM_CONVAR_NAME = "cl_observer_preset_team"
global const string OBSERVER_PRESET_PLAYERSLOT_CONVAR_NAME = "cl_observer_preset_playerSlot"
global const string OBSERVER_PRESET_PLAYERHASH_CONVAR_NAME = "cl_observer_preset_playerHash"

const string WAYPOINTTYPE_PLAYERTEAMSTATS = "team_stats"

const int WP_STRING_INDEX_PLAYERNAME = 0
const int WP_STRING_INDEX_TEAMNAME = 1

const int WP_INT_INDEX_PLAYERINDEX = 0
const int WP_INT_INDEX_PLACEMENT = 1
const int WP_INT_INDEX_TEAMINDEX = 2
const int WP_INT_INDEX_PLAYERKILLS = 3
const int WP_INT_INDEX_PLAYERDAMAGE = 4
const int WP_INT_INDEX_SURVIVALTIME = 5
const int WP_INT_INDEX_PLAYERASSISTS = 6

global const int TEAM_SPECTATOR_MAX_PLAYERS = 10

const asset PM_CHAMPION_SCREEN = $"ui/private_match_champion_screen.rpak"

           
const float PM_OBSERVER_HIGHLIGHT_TOGGLE_DEBOUNCE = 0.5

global struct RosterStruct
{
	var           headerPanel
	var           framePanel
	var           listPanel
	int           teamIndex
	int           teamSize
	int           teamDisplayNumber
	array<entity> playerRoster

	array<var>      _listButtons

	array<PrivateMatchStatsStruct> playerPlacementData
}

struct
{
	string		selectedPlaylist = ""
	int			playlistMaxTeams
	int			playlistTeamSize
	int			lastObserverCommand = -1
	PrivateMatchChatConfigStruct chatConfig
	
	table< int, PrivateMatchStatsStruct > privateMatchStats

	array<int> teamFinalPlacementArray = []

	bool 		cachedAimAssistOverride = false

	table signalDummy = {}
	array <var> buttonHints = []
	bool buttonHintsCreated = false
	bool buttonHintsHidden = true
} file



void function PrivateMatch_Init()
{
	if ( !IsPrivateMatch() && !IsPrivateMatchLobby() )
		return

	array<string> privateMatchPlaylists = GetVisiblePlaylistNames( true )

	#if SERVER
		                                                           
		                                                                                      
		                                                                        
		                                                                                              

		                                                           

		                                                                                 
	#endif         

	#if CLIENT
		Waypoints_RegisterCustomType( WAYPOINTTYPE_PLAYERTEAMSTATS, InstancePlayerTeamStats )
		AddOnSpectatorTargetChangedCallback( OnSpectatorTargetChanged )
		AddFreeCamSpectateStartedCallback( OnSpectatorModeChanged )
		AddFreeCamSpectateEndedCallback( OnSpectatorModeChanged )
		RegisterConCommandTriggeredCallback( "toggle_obs_ring_survey", PrivateMatch_ToggleSurveyRing )
		AddCallback_GameStateEnter( eGameState.Playing, OnSpectatorStarted )
		AddCallback_GameStateEnter( eGameState.Resolution, PrivateMatch_OnResolution )
		AddFirstPersonSpectateStartedCallback( OnFPSSpectatorStarted )
		AddThirdPersonSpectateStartedCallback( OnTPSSpectatorStarted )
		AddFreeCamSpectateStartedCallback( OnFreecamSpectatorStarted )
	#endif
		
	#if CLIENT || SERVER
	
		              
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchKickPlayer", "entity" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchSetPlayerTeam", "entity", "int", TEAM_UNASSIGNED, TEAM_MULTITEAM_LAST )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchToggleAimAssist" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchToggleAnonymousMode" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchSetTeamName", "int", 0, INT_MAX, "string" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchSetPlaylist", "int", 0, GetPlaylistCount() - 1 )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchSetAdminConfig", "int", 0, ACM_COUNT, "bool" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchEndMatchEarly" )
	
		                 
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchChangeObserverTarget", "entity" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchToggleSurveyRing" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchRefreshSurveyRing" )
		Remote_RegisterServerFunction( "ClientCallback_PrivateMatchReportObserverTargetChanged" )
	#endif

	int maxTeams
}

void function PrivateMatch_RegisterNetworking()
{
	RegisterNetworkedVariable( "lastSquadEliminated", SNDC_GLOBAL, SNVT_INT, -1 )

	Remote_RegisterClientFunction( "ServerCallback_EnableGameStatusMenu", "bool" )
	Remote_RegisterClientFunction( "ServerCallback_PrivateMatch_SquadEliminated", "int", TEAM_INVALID, 60, "int", 0, 60 )


	#if CLIENT || SERVER
		RegisterNetworkedVariable( NV_OBSERVER_SURVERY_RING_ENABLED, SNDC_PLAYER_GLOBAL, SNVT_BOOL, false )
	#endif

	#if CLIENT
		AddCallback_OnGameStateChanged( PrivateMatch_OnGameStateChanged )
		RegisterNetVarIntChangeCallback( "lastSquadEliminated", PrivateMatch_ClientOnSquadEliminated )
	#endif
}

#if CLIENT
                                                                                        
string function PrivateMatch_GetTeamName( int teamIndex )
{
	Assert( teamIndex > TEAM_INVALID )                                 
	string teamName = GameRules_GetTeamName( teamIndex )
	string defaultTeamName = ( AllianceProximity_IsUsingAlliances() )?Localize( "#TEAM_NUMBERED", AllianceProximity_GetAllianceFromTeam( teamIndex ) + 1 ) :Localize( "#TEAM_NUMBERED", teamIndex - 1 )

	return teamName != "" ? teamName : defaultTeamName
}

int function PrivateMatch_SortPlayersByName( entity a, entity b )
{
	if ( a.GetPlayerName() > b.GetPlayerName() )
		return 1

	if ( a.GetPlayerName() < b.GetPlayerName() )
		return -1

	return 0
}

void function PrivateMatch_ClientFrame()
{
	PerfStart( PerfIndexClient.PrivateLobbyThread )
	array<entity> players = GetPlayerArrayIncludingSpectators()

	table< int, array< entity > > teamPlayersMap
	foreach ( player in players )
	{
		if ( !(player.GetTeam() in teamPlayersMap) )
			teamPlayersMap[player.GetTeam()] <- []

		teamPlayersMap[player.GetTeam()].append( player )
	}

	foreach ( teamIndex, teamRoster in teamPlayersMap )
	{
		teamPlayersMap[teamIndex].sort( PrivateMatch_SortPlayersByName )
	}

	PrivateMatch_TeamRosters_Update( teamPlayersMap )

	PerfEnd( PerfIndexClient.PrivateLobbyThread )
}

void function InstancePlayerTeamStats( entity wp )
{
	PrivateMatchStatsStruct privateMatchStats
	privateMatchStats.platformUid = wp.GetWaypointGroupName()
	privateMatchStats.playerName = wp.GetWaypointString( WP_STRING_INDEX_PLAYERNAME )
	privateMatchStats.teamName = wp.GetWaypointString( WP_STRING_INDEX_TEAMNAME )
	privateMatchStats.teamPlacement = wp.GetWaypointInt( WP_INT_INDEX_PLACEMENT )
	privateMatchStats.teamNum = wp.GetWaypointInt( WP_INT_INDEX_TEAMINDEX )
	privateMatchStats.kills = wp.GetWaypointInt( WP_INT_INDEX_PLAYERKILLS )
	privateMatchStats.damageDealt = wp.GetWaypointInt( WP_INT_INDEX_PLAYERDAMAGE )
	privateMatchStats.survivalTime = wp.GetWaypointInt( WP_INT_INDEX_SURVIVALTIME )
	privateMatchStats.assists = wp.GetWaypointInt( WP_INT_INDEX_PLAYERASSISTS )

	int playerIndex = wp.GetWaypointInt( WP_INT_INDEX_PLAYERINDEX )
	file.privateMatchStats[playerIndex] <- privateMatchStats
}


PrivateMatchStatsStruct ornull function PrivateMatch_GetPlayerTeamStats( int playerIndex )
{
	if ( !(playerIndex in file.privateMatchStats) )
		return null

	return file.privateMatchStats[playerIndex]
}

void function ServerCallback_EnableGameStatusMenu( bool doEnable )
{
	RunUIScript( "EnablePrivateMatchGameStatusMenu", doEnable )

	if ( doEnable == false )
		RunUIScript( "ClosePrivateMatchGameStatusMenu", null )
}

void function PrivateMatch_OpenGameStatusMenu()
{
	if ( GetLocalClientPlayer().GetTeam() == TEAM_SPECTATOR )
		RunUIScript( "OpenPrivateMatchGameStatusMenu", null )
}

void function PrivateMatch_ToggleSurveyRing( entity player )
{
	if( player.GetTeam() == TEAM_SPECTATOR )
	{
		printt( "OBS_SURVEY: toggling Ring Survey for observer "+player )
		Remote_ServerCallFunction( "ClientCallback_PrivateMatchToggleSurveyRing" )
	}
}

#endif         

#if SERVER
                                                                       
 
	                                      
	 
		                                                                       
			                                  
	 
 
#endif

void function PrivateMatch_SetUpTeamRosters( string playlistName )
{
	file.selectedPlaylist = playlistName

	int maxPlayers = GetPlaylistVarInt( file.selectedPlaylist, MAX_PLAYERS_PLAYLIST_VAR, 60 )
	file.playlistMaxTeams = GetPlaylistVarInt( file.selectedPlaylist, MAX_TEAMS_PLAYLIST_VAR, 20 )
	file.playlistTeamSize = maxPlayers / file.playlistMaxTeams

	#if SERVER
		                                                                                                                                                            
		                                                          
			                              
	#endif

	                                                                                                                                      
}


#if SERVER
                                                              
 
	                               

	                                 
		                                 
	    
		                                  
 



                                                             
 
	                               
	
	                                                                                 
	                                 
		                                 
	    
		                                  
 


                                            
 
	                             
		      

	                                                                     
	                                                                                                

	                                
 

                                                                                        
 
	                             
		      

	                                  
		      

	                                                                                                                                                                       
	                                                                       

	                                                                                 
	                                                                                                    
	                                                  
		      

	                                             
	                                                  
 

                                                                                                           
 
	                             
		      

	                                                               
		      

	                                 
		      

	                                                                                                                                
		      

	                                                                                                    
	                                                                                                
		      

	                                  
 

                                                                                                        
 
	                             
		      

	                                       
		      

	                                               
 

                          
 
	                                                             
	 
		                                              
		 
			                                                                                                            
			                                   
			 
				            
					      

				            
					                                                                          
					        

				              
				        
					     
			 
		 

		                                                                 
		                                           
		                                      
		                                       
	 

	                                                    
	                                                                                                                   
	 
		                                         
		                                                               
		                                                                                                                
		                                                    
	 
	                      
		
	                                                   

	                                                                                        
	                               
	                                                                     
	                                                                           
	                                               
	 
		                                                               
	 
	                              
	                                                    
 

                                                                         
 
	                                                            
		      

	                                                                          
	                                                                   
 

                                                                             
 
	                                                            
		      

	                                                                    
	                                                             
 

                                                                                             
 
	                                               
		      

	                         
		      

	                                         
		      

	                                                                                                             
	                                  
 

                                                                                                          
 
	                                  
		      

	                                         
		      

	                                             
	                               
	                                         

	                   
	 
		              
		 
			                                          
			                                                                                        
			     
		 
		                
		 
			                                          
			                                                                                               
			     
		 
		        
		 
			                            
			     
		 
	 

	                                                           
 

                                                                       
 
	                        
	 
		                                                                
		      
	 

	                                  
	 
		                                                                
		      
	 

	                                                                                                 
	 
		                                                                         
		      
	 

	                                                                                                                
	                                           
	                                     
	      
 

                                                                                      
 
	                                  
		      
		
	                                                       
		      
		
	                                    
 


                                               
 
	                        
		      

                         
	                              
		      
       

                         
	                                                                                                
		      
       

	                     
	 
		                                                           
		 
			      
		 
	 

	                                             
	 
		                         
		                                
	 

	                                                                                                                                   
	                                             
	 
		                                         
		 
			                                                                                  
		 

		                                          
	 
 


                                          
 
	                           
 


                                      
 
	                                                 

	                                                                
	 
		                                 
		 
			                                                    
		 
	 

	                                             
	 
		                                         
		 
			                                                                       
			                                             

			                                                    
			                                                                                 
		 
	 
 


                                       
 
	                                     
	                                                                                                                                        
	 
		                            
		                                       
	 
 


                                                                
 
	                                                                                   

	                                                         
		                                                               

	                                     
 


                                       
 
	                                                                                                                                                    

	                                       
	                                                          

	                   
	                                                                                          
	 
		                                                                                                   

		                           
		 
			        
		 

		                                                       

		                                                             
		                                                    

		                                                              
		 
			                                         
			                                                           
			                                                                                           
			                                                 
			                                                     
			                                                           
			                                                             
			                                                 
			                                               
			                                                         
			                                                               
			                                                                 
			                                                               
			                                                       
			                                                             
			                                                               
			                                      
			                                     
			                                                                        
			                                                              

			                                                                                                                                                                                                                                                              
			                                                      

			             
		 
	 

	                        
	 
		                                                                                               
		      
	 
	                           
 


                                                                       
 
	                                          
	                                         
	                 
	 
		                                                   
		                                                           
		                                                             
		                                                                  
		                                                                   
		                                               
		                                                     
		                                                                               
		                                                                   
		                                                               
	 

	                        
 


                                      
 
	                                                                            
	 
		                                                                               
		                                       
			        

		                                                                      
		                                                            
		                                                                
		                                                                        
		                                                                          
		                                                                  
		                                                                        
		                                                                  
		                                                                            
		                                                                
		            
	 
 


                                              
 
	                                                                            
	 
		  
				 
					                                                                            
					                                              
				 
		  

		                                                                               
		                                       
		 
			                                              
			                                     
			                                       
			                                         
			                                                            
			        
		 

		                                                       
	 
 


                                                                                                   
 
	                                                                 
	                                                        
	                                                                                
	                                                                            
	                                                          
	                                                                            
	                                                                      
	                                                                      
	                                                                             
	                                                                              
	                                                                          
	         
 

                                                
 
	                                                   
	                                                   

	                                                         
		                                         
			                                                                                                                                                  
 
#endif         


bool function IsPrivateMatchLobby()
{
	#if UI
		                                
		if ( !IsConnected() )
			return false
	#endif

	if ( !IsPrivateMatch() )
	{
		if ( GetCurrentPlaylistName() != "private_match" )                
			return false
	}

	string mapName

	#if UI
		mapName = GetActiveLevel()
	#else
		mapName = GetMapName()
	#endif

	return IsLobbyMapName( mapName )
}

                                                                                                              
  
                                    
  
                                                                                                              

#if SERVER
                                       
 
	                            
		      

	                        
		      

	                                                            

	                                                                                                        
	 
		                                                                 
		                                                                
		                                            
		                                                                                                                       

		                                       
		 
			                                                                                                                             
			                                                 
		 
	 

	                                 
	                                                                                 
 

                                                                      
 
	                                         
		      

	                                                   
		                                                                                                                                              
 

                                                                            
 
	                                          
		      

	                                            
 

                                                                             
 
	                                          
		      

	                                       
 

                                                                                       
 
	                                               
	                            
		      

	                            
		      

	                        
		      

	                                                                                                                                                             
 
#endif         

#if UI
void function PrivateMatch_CreateMatchEndEarlyDialog()
{
	DialogData dialogData
	dialogData.header = Localize( "GAMEMODE_ENDED" )
	dialogData.message = Localize( "#TOURNAMENT_END_MATCH_EARLY" )
	dialogData.darkenBackground = true
	dialogData.noChoiceWithNavigateBack = true
	dialogData.noChoice = true
	dialogData.useFullMessageHeight = true
	OpenDialog( dialogData )
}
#endif

#if UI
void function PrivateMatch_SetSelectedPlaylist( string playlistName )
{
	                                                                                
	                                                                                                                    
	int playlistCount = GetPlaylistCount()
	int playlistIndex = -1
	for( playlistIndex = 0; playlistIndex < playlistCount; playlistIndex++ )
	{
		if( playlistName == GetPlaylistName( playlistIndex ) )
			break
	}

	if( playlistIndex < playlistCount )
	{
		Remote_ServerCallFunction( "ClientCallback_PrivateMatchSetPlaylist", playlistIndex )
	}
}
#endif

#if CLIENT
#if DEV
void function DEV_ShowSpectatorButtonHints()
{
	OnSpectatorStarted()
	OnToggleButtonHintsVisibility( KEY_B )
}
#endif     

void function OnSpectatorStarted()
{
	printt( "Spectator_OnSpectatorStarted" )

	entity localClientPlayer = GetLocalClientPlayer()

	                                          
	if ( !file.buttonHintsCreated && localClientPlayer.GetTeam() == TEAM_SPECTATOR )
	{
		                    
		file.buttonHints.push(CreateFullscreenPostFXRui( $"ui/observer_panel_hints.rpak", RUI_SORT_SCREENFADE + 1 ) )
		file.buttonHints.push(CreateFullscreenPostFXRui( $"ui/observer_controller_hints.rpak",  RUI_SORT_SCREENFADE + 1) )
		file.buttonHints.push(CreateFullscreenPostFXRui( $"ui/observer_keyboard_hints.rpak", RUI_SORT_SCREENFADE + 1 ) )
		file.buttonHints.push(CreateFullscreenPostFXRui( $"ui/observer_dpads_hints.rpak",  RUI_SORT_SCREENFADE + 1 ) )
		file.buttonHints.push(CreateFullscreenPostFXRui( $"ui/observer_camera_controls_hints.rpak", RUI_SORT_SCREENFADE + 1 ) )

#if NX_PROG || PC_PROG_NX_UI		
		RuiSetString( file.buttonHints[1], "yButtonLabel", "#OBSERVER_CONTROLLER_X_BUTTON" )
		RuiSetString( file.buttonHints[1], "yButtonDescLabel", "#OBSERVER_CONTROLLER_X_BUTTON_DESC" )
		RuiSetString( file.buttonHints[1], "xButtonLabel", "#OBSERVER_CONTROLLER_Y_BUTTON" )
		RuiSetString( file.buttonHints[1], "xButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC_ALT" )
		RuiSetString( file.buttonHints[1], "bButtonLabel", "#OBSERVER_CONTROLLER_A_BUTTON" )
		RuiSetString( file.buttonHints[1], "bButtonDescLabel", "#OBSERVER_CONTROLLER_A_BUTTON_DESC" )
		RuiSetString( file.buttonHints[1], "aButtonLabel", "#OBSERVER_CONTROLLER_B_BUTTON" )
		RuiSetString( file.buttonHints[1], "aButtonDescLabel", "#OBSERVER_CONTROLLER_B_BUTTON_DESC" )
#else
		RuiSetString( file.buttonHints[1], "yButtonLabel", "#OBSERVER_CONTROLLER_Y_BUTTON" )
		RuiSetString( file.buttonHints[1], "yButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC_ALT" )
		RuiSetString( file.buttonHints[1], "xButtonLabel", "#OBSERVER_CONTROLLER_X_BUTTON" )
		RuiSetString( file.buttonHints[1], "xButtonDescLabel", "#OBSERVER_CONTROLLER_X_BUTTON_DESC" )
		RuiSetString( file.buttonHints[1], "bButtonLabel", "#OBSERVER_CONTROLLER_B_BUTTON" )
		RuiSetString( file.buttonHints[1], "bButtonDescLabel", "#OBSERVER_CONTROLLER_B_BUTTON_DESC" )
		RuiSetString( file.buttonHints[1], "aButtonLabel", "#OBSERVER_CONTROLLER_A_BUTTON" )
		RuiSetString( file.buttonHints[1], "aButtonDescLabel", "#OBSERVER_CONTROLLER_A_BUTTON_DESC" )
#endif

		                                                                       
		file.buttonHintsCreated = true

		                                                                        
		RegisterButtonPressedCallback( KEY_B, OnToggleButtonHintsVisibility )
		RegisterConCommandTriggeredCallback( "toggle_observer_btn_hints", OnToggleButtonHintsVisibility )
	}
}

void function OnFPSSpectatorStarted( entity player, entity currentTarget )
{
	printt( "Spectator_OnFPSSpectatorStarted" )

	if (file.buttonHintsCreated)
	{
		for ( int i = 0; i < file.buttonHints.len(); i++ )
		{
			RuiSetBool( file.buttonHints[i], "isObserverMode", true )
			RuiSetBool( file.buttonHints[i], "isFPS", true )
		}
	}
	if(file.buttonHints.len() > 0)
	{
#if NX_PROG || PC_PROG_NX_UI	
		RuiSetString( file.buttonHints[1], "xButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC_ALT" )
#else
		RuiSetString( file.buttonHints[1], "yButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC_ALT" )
#endif
	}
}

void function OnTPSSpectatorStarted( entity player, entity currentTarget )
{
	printt( "Spectator_OnTPSSpectatorStarted" )

	if (file.buttonHintsCreated)
	{
		for ( int i = 0; i < file.buttonHints.len(); i++ )
		{
			RuiSetBool( file.buttonHints[i], "isObserverMode", true )
			RuiSetBool( file.buttonHints[i], "isFPS", false )
		}
	}
	
	if(file.buttonHints.len() > 0)
	{
#if NX_PROG || PC_PROG_NX_UI
		RuiSetString( file.buttonHints[1], "xButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC" )
#else
		RuiSetString( file.buttonHints[1], "yButtonDescLabel", "#OBSERVER_CONTROLLER_Y_BUTTON_DESC" )
#endif
	}
}

void function OnFreecamSpectatorStarted( entity spectatingPlayer )
{
	printt( "Spectator_OnFreecamSpectatorStarted" )

	if (file.buttonHintsCreated)
	{
		for ( int i = 0; i < file.buttonHints.len(); i++ )
		{
			RuiSetBool( file.buttonHints[i], "isObserverMode", false )
		}
	}
}

void function OnToggleButtonHintsVisibility( var button )
{
	printt("Spectator_OnToggleButtonHintsVisibility", file.buttonHintsHidden)

	if (file.buttonHintsHidden)
	{
		for ( int i = 0; i < file.buttonHints.len(); i++ )
		{
			RuiSetBool( file.buttonHints[i], "isOpen", true )
			RuiSetBool( file.buttonHints[i], "animateIn", true )
		}
	}
	else
	{
		for ( int i = 0; i < file.buttonHints.len(); i++ )
		{
			RuiSetBool( file.buttonHints[i], "isOpen", false )
			RuiSetBool( file.buttonHints[i], "animateOut", true )
		}
	}
	file.buttonHintsHidden = !file.buttonHintsHidden
}

void function PrivateMatch_OnResolution()
{
	Signal( clGlobal.levelEnt, "GameModes_CompletedResolutionCleanup" )
}

                                                             
   
  	                                        
  	                                           
  		      
  
  	                                                               
  	                                                                     
   

void function ServerCallback_PrivateMatch_SquadEliminated( int teamIdx, int placement )
{
	PrivateMatch_SquadEliminated( teamIdx, placement )
}

void function OnSpectatorTargetChanged( entity observer, entity prevTarget, entity newTarget )
{
	if ( observer.GetTeam() != TEAM_SPECTATOR )
		return

	bool showTeamName = true
                         
	if (GunGame_IsModeEnabled())
		showTeamName = false
       

                       
	if (WinterExpress_IsModeEnabled())
		showTeamName = false
       

	if ( IsValid( newTarget ) && ( newTarget.IsPlayer() || newTarget.IsBot() ) && (newTarget != prevTarget) && showTeamName)
	{
		printf( "PrivateMatchObserver: Observer %s changed target to %s", observer.GetPINNucleusPid(), newTarget.GetPINNucleusPid() )
		Remote_ServerCallFunction( "ClientCallback_PrivateMatchReportObserverTargetChanged" )
		Remote_ServerCallFunction( "ClientCallback_PrivateMatchRefreshSurveyRing" )
		PrivateMatch_UpdateChatTarget()
		ShowTeamNameInHud()
	}
	else
	{
		HideTeamNameInHud()
	}
}

void function OnSpectatorModeChanged( entity observer )
{
	Remote_ServerCallFunction( "ClientCallback_PrivateMatchRefreshSurveyRing" )
}

entity function GetObserverPresetTarget()
{
	string presetPlayerHash = GetConVarString( OBSERVER_PRESET_PLAYERHASH_CONVAR_NAME )
	if( presetPlayerHash != "" )
	{
		foreach( entity player in GetPlayerArray() )
		{
			if( player.GetHashedEadpUserIdStr() == presetPlayerHash )
				return player
		}
	}

	int presetTeam = GetConVarInt( OBSERVER_PRESET_TEAM_CONVAR_NAME )
	if( presetTeam < 0 )
		return null

	array<entity> teamPlayers = GetPlayerArrayOfTeam(presetTeam + TEAM_MULTITEAM_FIRST - 1)

	if( teamPlayers.len() == 0 )
		return null

	teamPlayers.sort( PrivateMatch_SortPlayersByName )

	int playerSlot = abs((GetConVarInt( OBSERVER_PRESET_PLAYERSLOT_CONVAR_NAME ) - 1) % teamPlayers.len())

	return teamPlayers[playerSlot]

}

void function PrivateMatch_OnGameStateChanged( int newVal )
{
	if ( !IsPrivateMatch() )
		return

	if( newVal == eGameState.Playing )
	{
		entity observerTarget = GetObserverPresetTarget()
		if( observerTarget != null )
			Remote_ServerCallFunction( "ClientCallback_PrivateMatchChangeObserverTarget", observerTarget )
	}
	else if ( newVal == eGameState.WinnerDetermined )
	{
		if( GameRules_GetTeamName( GetWinningTeam() ) != "Unassigned" )
		{
			SetChampionScreenRuiAsset( PM_CHAMPION_SCREEN )
			SetChampionScreenRuiAssetExtraFunc( ChampionScreenSetWinningTeamName )
		}
	}
	else if ( newVal == eGameState.Resolution )
	{
		DeathScreenCreateNonMenuBlackBars()
		                                                                                                                 
		if ( GameRules_GetTeamName( GetWinningTeam() ) == "Unassigned" )
		{
			                                                            
			thread function() : ( )
			{
				WaitSignal( clGlobal.levelEnt, "GameModes_CompletedResolutionCleanup" )

				if ( IsValid( GetLocalViewPlayer() ) )
					RunUIScript( "PrivateMatch_CreateMatchEndEarlyDialog")


				UpdateBlackBarRui()
			}()
		}

		                                                                     
		                                                   
		bool aimAssistConfig = GetConVarBool( CUSTOM_AIM_ASSIST_CONVAR_NAME )
		if ( aimAssistConfig != file.cachedAimAssistOverride )
		{
			SetConVarBool( GLOBAL_AIM_ASSIST_CONVAR_NAME, file.cachedAimAssistOverride )
		}
	}
}

void function PrivateMatch_ClientOnSquadEliminated( entity player, int newVal )
{
	bool anonymousModeActive = GetConVarBool( CUSTOM_ANONYMOUS_MODE_CONVAR_NAME )
	if ( anonymousModeActive && GameRules_IsTeamIndexValid( newVal ) )
		Obituary_Print_Localized( Localize( "#SURVIVAL_OBITUARY_SQUADELIMINATED", PrivateMatch_GetTeamName( newVal ) ).toupper(), <255, 244, 79> )
}

void function ChampionScreenSetWinningTeamName( var rui )
{
	if ( !IsPrivateMatch() )
		return

	int winningTeamOrAlliance = GamemodeUtility_GetWinningTeamOrAlliance()
	if( winningTeamOrAlliance != TEAM_INVALID )
	{
		int winningTeamIndex = AllianceProximity_IsUsingAlliances() ? AllianceProximity_GetRepresentativeTeamForAlliance( winningTeamOrAlliance ) : winningTeamOrAlliance
		RuiSetString( rui, "winningTeamName", PrivateMatch_GetTeamName( winningTeamIndex ).toupper() )
	}
}
#endif         

#if SERVER || CLIENT
int function PrivateMatch_GetMaxTeamsForSelectedGamemode()
{
	string playlist = GetCurrentPlaylistName()
	return GetMaxTeamsForPlaylistName( playlist )
}
#endif