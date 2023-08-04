                   
global function LootSensor_Init
global function LootSensorEnabled
global function PlayerAlreadyConnectedToServers

global function LootSensor_Map_Init

global function OnWeaponActivate_loot_sensor
global function OnWeaponPrimaryAttack_loot_sensor
global function OnWeaponDeactivate_loot_sensor

#if SERVER
                                    
                                        
       
                                         
                                              
                                                 
            
#elseif CLIENT
global function ServerToClient_DisplayCurrencyGranted
global function LootSensorConnectedEnt_EntityChangeCallback
#endif         

global const string LOOT_SENSOR_REF = "mp_ability_loot_sensor"
global const string LOOT_SENSOR_PRINT_NAME = "#SURVIVAL_PICKUP_LOOT_SENSOR"
const string LOOT_SENSOR_ALL_NODES_COLLECTED = "#ALL_DAILY_NODES_COLLECTED"
const string LOOT_SENSOR_NODES_ACQUIRED = "#CONNECTION_NODES_ACQUIRED"

const string LOOT_SENSOR_BEEP_AUDIO = "NodeTracker_Beeps_1P"
const string LOOT_SENSOR_SPHERE_AUDIO = "NodeTracker_SphereHolo_LP"
const string LOOT_SENSOR_SPHERE_ENTER_AUDIO = "NodeTracker_SphereHolo_Enter"
const string LOOT_SENSOR_SPHERE_EXIT_AUDIO = "NodeTracker_SphereHolo_Exit"
const string LOOT_SENSOR_WARP_IN_AUDIO = "NodeTracker_WarpIn"
const string LOOT_SENSOR_JACKPOT_AUDIO = "NodeTracker_LootJackPot"
const string LOOT_SENSOR_UPLOADING_AUDIO = "NodeTracker_UI_Uploading"
const string LOOT_SENSOR_PRE_WARP_IN_AUDIO = "NodeTracker_Pulse_PreWarpIn"

                      
const string LOOT_SENSOR_LOBACR_HOLO_AUDIO = "NodeTracker_LobaChronicles_DoorLocked_Hologram_LP"
const string LOOT_SENSOR_LOBACR_HOLO_DISS_AUDIO = "NodeTracker_LobaChronicles_DoorLocked_Hologram_Dissolves"
const string LOOT_SENSOR_LOBACR_FD_AUDIO = "NodeTracker_UI_LobaChronicles_FirstDraw"

const string LOOT_SENSOR_REWARD_EQUIPMENT = "loot_sensor_reward_equipment"
const string LOOT_SENSOR_REWARD_WEAPON = "loot_sensor_reward_weapon"
const string LOOT_SENSOR_REWARD_EQUIPMENT_NO_BLUE = "loot_sensor_reward_equipment_no_blue"
const string LOOT_SENSOR_REWARD_WEAPON_NO_BLUE = "loot_sensor_reward_weapon_no_blue"
const string LOOT_SENSOR_REWARD_CONSUMABLE = "Health_Large"

const string LOOT_SENSOR_PURSUE_OBJECTIVE_LINE = "bc_pursueObjective"
const string LOOT_SENSOR_NODE_TRACKER_RETRIEVED = "bc_nodeTrackerRetrieved"

const asset FX_LOOT_SENSOR_CONNECTION_RING = $"P_node_tracker_HC_01"
const asset FX_LOOT_SENSOR_REPEATING_RING = $"P_NT_ping_sphere"
const asset FX_LOOT_SENSOR_REWARD_TICK_WARP = $"P_NT_warp"
const asset FX_LOOT_SENSOR_BUILD_UP_TICK = $"P_NT_wrp_buildUp"
const asset FX_LOOT_SENSOR_JACKPOT = $"P_NT_confetti_burst"

const vector TICK_HEIGHT_OFFSET = < 0, 0, 35 >
const vector JACKPOT_HEIGHT_OFFSET = < 0, 0, 50 >
const vector WARP_BUILDUP_SIZE_VECTOR = < 1, 1, 1 >

const vector NODE_TRACKER_BASE_RING_COLOR = <20, 230, 230>
const vector NODE_TRACKER_INSIDE_RING_COLOR = <255, 30, 30>

const float MAX_GOAL_RADIUS = 100 * METERS_TO_INCHES
const float MIN_GOAL_RADIUS = 60 * METERS_TO_INCHES
const float MIN_AUDIO_DELAY = 0.2
const float MAX_AUDIO_DELAY = 2.0
const float SPHERE_PING_VISIBILITY_RADIUS_SQR = pow( 40 * METERS_TO_INCHES, 2)
const float EFFECTS_VISIBILITY_RADIUS_SQR = pow( 40 * METERS_TO_INCHES, 2)
const float CONNECTION_RADIUS = 4.3 / INCHES_TO_METERS
const float CONNECTION_RADIUS_SQR = pow( CONNECTION_RADIUS, 2 )
const float RESET_CONNECTION_RADIUS_SQR = pow( 150 * METERS_TO_INCHES, 2 )
const float TEAMMATE_CONNECTION_RADIUS_SQR = pow( 150 * METERS_TO_INCHES, 2  )
const float NODE_TRACKER_UPLOAD_TIME = 2.1
const float LOOT_SENSOR_SPECIAL_AUDIO_CHANCE = 0.3
const float MAX_CONNECTION_SEARCH_TIME = 4.0
const float SEARCH_TIME_BUFFER = 1

const float FOLLOWING_LEAD_MIN_AUDIO_REPLAY_TIME = 60

const int CURRENCY_MIN = 875
const int CURRENCY_MAX = 905
const int MAX_DAILY_USES = 5

const int SPHERE_PING_FREQUENCY = 10
const int SPHERE_CLOSE_MULTIPLIER = 5

const int MAX_LOOT_SENSOR_JACKPOTS = 2

const vector NO_CONNECTION_VEC = <0, 0, 0>
const vector CONNECTION_COMPLETED_VEC = <1, 1, 1>

       
const vector CR_DOOR_1_ORIGN = <-3046, -12380, 34056>
const vector CR_DOOR_2_ORIGN = <-3046, -12260, 34056>              
const asset FX_DOOR_GOAL = $"P_loba_env_door_highlight"

enum LootSensorConnectionType
{
	FAILED,
	CONNECTION_LOST,
	SEARCHING,
	CONNECTED,
	UPLOADING,
	COMPLETED,
}

struct LootSensorPlayerInfo
{
	bool lootSensorOpen = false
	bool playedStartAudio
}

struct {
	#if SERVER
		                                                               
		                                            
		                 
		       
			                                 
			                         
		      
	#elseif CLIENT
		vector goalLocation
		bool isLootSensorActive = false
		bool previouslyConnected = false

		float blinkDelay
		float blinkTime
		bool secondBeep = false
		int beepCount = 0
		int pingCount = 0

		entity soundEnt
	#endif          
} file

void function LootSensor_Init()
{
	Remote_RegisterClientFunction( "ServerToClient_DisplayCurrencyGranted", "int", 0, CURRENCY_MAX )

	RegisterNetworkedVariable( "lootSensorConnectionValue", SNDC_PLAYER_EXCLUSIVE, SNVT_INT, -1 )
	RegisterNetworkedVariable( "lootSensorConnectedEnt", SNDC_PLAYER_EXCLUSIVE, SNVT_ENTITY )
	RegisterNetworkedVariable( "lootSensorActivateTime", SNDC_PLAYER_GLOBAL, SNVT_TIME, -1 )

	PrecacheParticleSystem( FX_LOOT_SENSOR_CONNECTION_RING )
	PrecacheParticleSystem( FX_LOOT_SENSOR_REPEATING_RING )
	PrecacheParticleSystem( FX_LOOT_SENSOR_REWARD_TICK_WARP )
	PrecacheParticleSystem( FX_LOOT_SENSOR_BUILD_UP_TICK )
	PrecacheParticleSystem( FX_LOOT_SENSOR_JACKPOT )

	if ( IsEventFinale() )
		PrecacheParticleSystem( FX_DOOR_GOAL )

	#if SERVER
		                                                                                                                                              
		 
			                                                                  
		 

		                                                                            

		                                                
		                                        
	#endif         
	#if CLIENT
		RegisterSignal( "LootSensorGoalLocSet" )
		RegisterSignal( "StopLootSensorSecondBeep" )

		RegisterNetVarEntityChangeCallback( "lootSensorConnectedEnt", LootSensorConnectedEnt_EntityChangeCallback )

		AddCallback_OnBleedoutStarted( LootSensor_PlayerStartBleedout_Client )
	#endif         

	RegisterSignal( "DeactivateLootSensor" )
	RegisterSignal( "PlayerConnectedToSignal" )
	RegisterSignal( "LootSensorConnectionLost" )
}


void function LootSensor_Map_Init( bool precacheLootTicks = true )
{
	#if SERVER
	                        
	 
		                         
	 
	#endif          
}


bool function LootSensorEnabled()
{
	return GetCurrentPlaylistVarBool( "loot_sensor_enabled", true )
}


bool function SpawnLootSensorInInventory()
{
	return GetCurrentPlaylistVarBool( "loot_sensor_spawn_in_inventory", false )
}


bool function LootSensor_AutoUploadEnabled()
{
	return GetCurrentPlaylistVarBool( "loot_sensor_auto_upload_enabled", true )
}


bool function LootSensor_JackpotEnabled()
{
	return GetCurrentPlaylistVarBool( "loot_sensor_jackpot_enabled", true )
}


bool function LootSensor_UseUpdatedBeep()
{
	return GetCurrentPlaylistVarBool( "loot_sensor_use_updated_beep", false )
}


bool function PlayerAlreadyConnectedToServers( entity player )
{
	return player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.COMPLETED
}


#if SERVER
                                                                      
 
	                                                                                                         
			                                               
	 
		                         
		                           
		                             
		                                                
		                              
	 
 


                                                          
                                                   
 
	                                             
	 
		                                                                           
	 
 


                                                                  
 
	                                                                                                   
			                                                                                             
		      

	                                                            
 


                                                                       
 
	                         
		      

	                                                                                                  
		      

	                                                         
	                                                       

	                                                                    
	 
		                                                            
		                                                        
	 
 


                                                                                              
 
	                         
		      

	                                                                                                          
	 
		                                             
	 
 


                                                 
                                                                                 
 

	                                                                                                        
	 
		                                                                                         
	 

	                                                           

	                                                                                       
	                                 
	                                                                              
	 
		                                                                
		 
			                                                                         
				        

			                                                                       
				        

			                                                                                  
			                                                                                   
			 
				                                    
			 
		 
	 

	                                                                                                                                
	                        

	                                  
	                      
	 
		                                                     
	 
	                                       
	 
		                                                                                 
	 
	    
	 
		                                                                         
	 

	                                             
	                                                                                             

	                                                                                               
	                                      
	 
		             
	 

	                         
		      

	                                              
	 
		                                                                                         

		                       
			                                                                                
	 
	    
	 
		                                                                                      
	 

	                                                                                                                   
 


                                                                                               
 
	        
	                                            
	                                                                                                                                                              
	                                   
	                            
	                                                       

	                                                                                                                                                                                                    

	                             
	 
		                                      
		      
	 

	                              
 


                                                         
                                                           
                                         
                                                                                                                           
 
	             
	                       
	                                     
	                             
	 
		                 

		                                                                                                                                      
		                                                                                                                                    

		                                                                 
		                                                                                                              

		                                                                                                    
		 
			           
		 

		            
		 
			                                         
			 
				                                                                                      
				 
					           
				 
			 
		 

		           
		 
			                   
			           
		 
		    
		 
			                                             
			     
		 
	 

	                                                                                                        
	 
		                                                                  
	 

	                                         
 


                                                                                                 
 
	                                        

	                                                                                              

	                           
	 
		                                                                                                                            
		                                                                                                        

		                                                                                                                   

		                                                                               
				                                                                             
		 
			                                                                                               
			                                                       
			                                           

			                                                                                                          
			 
				                                      
				                                                           
			 

			     
		 

		        
	 
 


                                                                                    
 
	                                                                                                                          

	              
	 
		                                               
			      

		                                    
		 
			                                                         
			      
		 
		           
	 
 


                                                                              
 
	                                                
	                                                                                                                                                          

	                             
	                       

	            
		                                          
		 
			                        
			 
				                      
				 

					       
						                                
						 
							                                                               
							                                                       
						 
					      
					 
						                      
						 
							                                                                       
							                                    
							                                                                                             
							                                         
						 

						                                                                                         
					 

				 
				    
				 
					                                                                                         
				 
			 
		 
	 

	                                                                                         

	                        
	                                                        
	 
		                                    
		 
			                                     
			 
				                                                               
			 

			      
		 

		           
	 

	                                                                                            

	                                               
		      

	                                                               
	                      

	                       
		                                                           
 


                                                                                
 
	                   
	                                                                    
		                                                                             

	                                                     

	                                                                      
	 
		                               
	 


	                                          
	                                                                            
	                                                              

	                                                                                                                                  
	                                                                           
	                                                                                                                                                                   
	                                                                      
	                                                                        

	                                                                                                                                     
	                                                               
	 
		                           
			        

		                                                              
		 
			                                           
			     
		 
	 

	                                                    

	                                               
		      

	                                     
	 
		                                                                                             
	 
	                                         

	                                                          

	                         
		      

	                            
	 
		                        
		                    
	 

	                                                                

	                          
	 
		                  
	 
 


                                                    
 
	            
	                                                                                                             
	                                                                                                             
	                                                                                                                                                        

	             
	                
	                                                                                                            
	                                                                            
	 
		                                                                        
		                                                      
			      

		                                        
		                                              
		                                                                                         
	 
	    
	 
		                                                                                         
		                                                                       
	 

	                                
	                                                                        
	                                                                            
	                                                                                                    

	                                                                                                      
	                                                       
	                                               
	                                                                                    
	                                                                              

	                                                                                                                  
	 
		             
	 

	                                  
	 
		                  
	 
	    
	 
		                                                                  
		                                                              

		                                                                                    
		                                                                                           

		                                                                       

		                                 
		 
			                                                                  
		 
	 

	                                                                                                
 


                                
                                    
                                                                                  
 
	                                                                               
	                                                               
	 
		                           
			        

		                                                               
		 
			                                           
			     
		 
	 

	                        
	                                                   

	                                                               
	                            
	                                      

	                         
	 
		                                       
	 

	       
	                        
	 
		               
		                      
	 
	      

	                                                                                                                         
	 
		                                                                                     
		            
		                    
		                      
	 
	    
	 
		                         
		 
			                                                                                             
		 
		    
		 
			                                                                                     
		 

		                                                               

		                                                                                
		 
			                                                                                                                                
			                                                    
			                           
			                           
		 
	 

	                         
	 
		                                                                                                           
	 
	    
	 
		                                                                                                   
	 

	                    
	 
		                               
		 
			                                                                
			 
				            
				     
			 
			                                                                       
			 
				            
			 
		 
	 

	                                                                                                    

	                                                                                   

	                                                                                                                                                                           
	                                                                          

	                                         
	                      
	 
		                                                                                                                                                                    
		                                                 
		                                                             
	 

	                                                         

	        

	                                
	 
		                            
		                        
	 
 

                                                                      
 
	                           
		      

	                                            
	 
		                                                     
		                        
		 
			                    
			                
		 

		                                            
	 
 

                                                          
 
	                                                                           
		            

	                                                                        
	                     
 


                                                                              
 
	                                                                   
	                         
	 
		                                                                              
		                                                              
		                 
	 
	    
	 
		                                                                   
		                                                           
	 
 
#endif          


#if CLIENT
void function LootSensor_PlayerStartBleedout_Client( entity victim, float endTime )
{
	if ( victim != GetLocalViewPlayer() )
		return

	if ( file.isLootSensorActive )
	{
		DeactivateLootSensorForPlayer( victim, true )
	}
}


void function LootSensorConnectedEnt_EntityChangeCallback( entity player, entity goalEnt )
{
	thread LootSensorConnectedEnt_EntityChangeCallback_Thread( player )
}

void function LootSensorConnectedEnt_EntityChangeCallback_Thread( entity player )
{
	                                                                                                                    
	             
	WaitFrame()

	if ( !IsValid( player ) )
		return

	entity goalEnt = player.GetPlayerNetEnt( "lootSensorConnectedEnt" )

	if ( !IsValid( goalEnt ) )
		return

	if ( player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.FAILED )
	{
		player.Signal( "LootSensorGoalLocSet" )
	}

	vector goalLocation = goalEnt.GetOrigin()

	if ( goalLocation == file.goalLocation )
		return

	file.goalLocation = goalLocation

	if ( goalLocation == CONNECTION_COMPLETED_VEC )
	{
		file.isLootSensorActive = false
		player.Signal( "PlayerConnectedToSignal" )
	}
	else if ( player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.CONNECTION_LOST )
	{
		file.previouslyConnected = true
		player.Signal( "LootSensorConnectionLost" )

		if ( file.isLootSensorActive )                                                              
		{
			entity weapon = player.GetActiveWeapon( eActiveInventorySlot.mainHand )
			thread ActivateLootSensorForPlayer_Thread( player, weapon, true )
		}
	}
	else if ( goalLocation != NO_CONNECTION_VEC )
	{
		player.Signal( "LootSensorGoalLocSet" )
		if ( IsEventFinale() )
			thread ShowGoalLocRadiusCr_Thread( player )
		else
			thread ShowGoalLocRadius_Thread( player )
	}
}


void function ServerToClient_DisplayCurrencyGranted( int nodeAmount )
{
	string header
	string milesAlias

	if ( nodeAmount == 0 )
	{
		AnnouncementMessageRight( GetLocalViewPlayer(), header + Localize( LOOT_SENSOR_ALL_NODES_COLLECTED ), "", <214, 214, 214>, $"", 5, milesAlias )
		return
	}

	AnnouncementMessageRight( GetLocalViewPlayer(), header + Localize( LOOT_SENSOR_NODES_ACQUIRED, nodeAmount ), "", <214, 214, 214>, $"", 7, milesAlias )

	float playAudioChance = GetCurrentPlaylistVarFloat( "loot_sensor_special_audio_chance", LOOT_SENSOR_SPECIAL_AUDIO_CHANCE )
	if ( RandomFloat( 1 ) >= LOOT_SENSOR_SPECIAL_AUDIO_CHANCE )
		return

	entity player = GetLocalViewPlayer()
	ItemFlavor character = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_Character() )
	string characterRef  = ItemFlavor_GetCharacterRef( character ).tolower()
	switch ( characterRef )
	{
		case "character_lifeline":
			thread PlayBattleChatterToSelfOnClient( player, LOOT_SENSOR_NODE_TRACKER_RETRIEVED + "_lifeline" )
			break
		case "character_loba":
			thread PlayBattleChatterToSelfOnClient( player, LOOT_SENSOR_NODE_TRACKER_RETRIEVED + "_loba" )
			break
		case "character_valkyrie":
			thread PlayBattleChatterToSelfOnClient( player, LOOT_SENSOR_NODE_TRACKER_RETRIEVED + "_valkyrie" )
			break
		case "character_madmaggie":
			thread PlayBattleChatterToSelfOnClient( player, LOOT_SENSOR_NODE_TRACKER_RETRIEVED + "_madmaggie" )
			break
		case "character_crypto":
			thread PlayBattleChatterToSelfOnClient( player, LOOT_SENSOR_NODE_TRACKER_RETRIEVED + "_crypto" )
			break
	}
}


void function ShowGoalLocRadiusCr_Thread( entity player )
{
	EndSignal( player, "OnDeath", "OnDestroy", "PlayerConnectedToSignal", "DeactivateLootSensor", "LootSensorConnectionLost" )

	PassByReferenceInt fxHandle1
	fxHandle1.value = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( FX_DOOR_GOAL ), CR_DOOR_1_ORIGN, ZERO_VECTOR )
	var soundHandle = EmitSoundAtPosition( player.GetTeam(), CR_DOOR_1_ORIGN, LOOT_SENSOR_LOBACR_HOLO_AUDIO )

	OnThreadEnd(
		function() : ( fxHandle1, soundHandle, player )
		{
			if ( IsValid( fxHandle1 ) && IsValid( fxHandle1.value ) )
			{
				EffectStop( fxHandle1.value, false, true )
			}

			if ( soundHandle != null )
			{
				StopSound( soundHandle )
			}

			if ( IsValid( player ) )
				EmitSoundAtPosition( player.GetTeam(), CR_DOOR_1_ORIGN, LOOT_SENSOR_LOBACR_HOLO_DISS_AUDIO )

		}
	)



	WaitForever()
}



void function ShowGoalLocRadius_Thread( entity player )
{
	EndSignal( player, "OnDeath", "OnDestroy", "PlayerConnectedToSignal", "DeactivateLootSensor", "LootSensorConnectionLost" )

	if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
		return

	PassByReferenceInt fxHandle

	fxHandle.value = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( FX_LOOT_SENSOR_CONNECTION_RING ), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin(), ZERO_VECTOR )
	EmitSoundOnEntity( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_AUDIO )

	OnThreadEnd(
		function() : ( fxHandle, player )
		{
			if ( IsValid( fxHandle ) && IsValid( fxHandle.value ) )
			{
				EffectStop( fxHandle.value, false, true )
			}

			if ( IsValid( player ) && IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
			{
				StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_AUDIO )
				StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_EXIT_AUDIO )
				StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_ENTER_AUDIO )
			}

			if ( !LootSensor_AutoUploadEnabled() )
			{
				HidePlayerHint( "#CONNECTION_AVAILABLE_HINT" )
			}
		}
	)

	bool isActive = false
	bool wasInConnectionRadius = false
	float hintStartTime = 0
	float hintDisplayTime = 3.0

	while( true )
	{
		if ( !IsValid( player ) || !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
			return

		if ( !LootSensor_AutoUploadEnabled() && player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.UPLOADING &&
				Time() - hintStartTime > hintDisplayTime && hintStartTime != 0 )
		{
			HidePlayerHint( "#CONNECTION_AVAILABLE_HINT" )
			hintStartTime = 1                                                                                      
		}

		if ( !wasInConnectionRadius && InConnectionRadius( player ) )
		{
			if ( !EffectDoesExist( fxHandle.value ) )
			{
				fxHandle.value = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( FX_LOOT_SENSOR_CONNECTION_RING ), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin(), ZERO_VECTOR )
			}
			EffectSetControlPointVector( fxHandle.value, 1, <125, 0, 0> )
			EffectSetControlPointVector( fxHandle.value, 2, NODE_TRACKER_INSIDE_RING_COLOR )
			wasInConnectionRadius = true
			isActive = true

			StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_EXIT_AUDIO )
			EmitSoundOnEntity( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_ENTER_AUDIO )

			if ( !LootSensor_AutoUploadEnabled() && hintStartTime == 0 )
			{
				hintStartTime = Time()
				AddPlayerHint( hintDisplayTime, 0.25, $"", "#CONNECTION_AVAILABLE_HINT" )
			}
		}
		else if ( ( !isActive || wasInConnectionRadius ) && InEffectVisibilityRadius( player ) && !InConnectionRadius( player ) && file.beepCount != 3 )
		{
			if ( !isActive || !EffectDoesExist( fxHandle.value ) )                             
			{
				if ( EffectDoesExist( fxHandle.value ) )
				{
					EffectStop( fxHandle.value, true, false )
				}
				fxHandle.value = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( FX_LOOT_SENSOR_CONNECTION_RING ), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin(), ZERO_VECTOR )
				EmitSoundOnEntity( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_AUDIO )

				file.pingCount = 0                                                      
			}

			if ( wasInConnectionRadius )
			{
				StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_ENTER_AUDIO )
				EmitSoundOnEntity( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_EXIT_AUDIO )
			}

			EffectSetControlPointVector( fxHandle.value, 1, <125, 0, 0> )
			EffectSetControlPointVector( fxHandle.value, 2, NODE_TRACKER_BASE_RING_COLOR )
			isActive = true
			wasInConnectionRadius = false

			if ( LootSensor_AutoUploadEnabled() )
			{
				HidePlayerHint( "#CONNECTION_AVAILABLE_HINT" )
				hintStartTime = 0
			}
		}
		else if ( isActive && !InEffectVisibilityRadius( player ) )
		{
			if ( EffectDoesExist( fxHandle.value ) )
			{
				EffectStop( fxHandle.value, false, true )
			}

			StopSoundOnEntityByName( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ), LOOT_SENSOR_SPHERE_AUDIO )
			isActive = false
			wasInConnectionRadius = false
		}
		WaitFrame()
	}
}


void function ShowClosingRingFxCR_Thread( entity player, float closeTime, float connectionStrength )
{
	EndSignal( player, "OnDeath", "OnDestroy", "PlayerConnectedToSignal", "DeactivateLootSensor", "LootSensorConnectionLost" )

	PlayBeepAudioForPlayer( player, connectionStrength )

	wait closeTime
}

void function ShowClosingRingFx_Thread( entity player, float closeTime, float connectionStrength )
{
	EndSignal( player, "OnDeath", "OnDestroy", "PlayerConnectedToSignal", "DeactivateLootSensor", "LootSensorConnectionLost" )

	if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
		return

	float dist = Distance( player.GetOrigin(), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin() ) * INCHES_TO_METERS + 5                                                  

	PassByReferenceInt fxHandle
	fxHandle.value = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( FX_LOOT_SENSOR_REPEATING_RING ), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin(), ZERO_VECTOR )

	OnThreadEnd(
		function() : ( fxHandle, closeTime )
		{
			if ( IsValid( fxHandle ) && IsValid( fxHandle.value ) )
			{
				EffectSkipForwardToTime( fxHandle.value, closeTime )
				EffectStop( fxHandle.value, false, true )
			}
		}
	)

	EffectSetControlPointVector( fxHandle.value, 1, < dist , 0, 0> )
	EffectSetControlPointVector( fxHandle.value, 2, < closeTime , 0, 0> )
	EffectSetControlPointVector( fxHandle.value, 3, NODE_TRACKER_BASE_RING_COLOR )

	PlayBeepAudioForPlayer( player, connectionStrength )

	wait closeTime
}


void function ShowLootSensorUI_Thread( entity player, entity weapon )
{
	EndSignal( player, "OnDeath", "OnDestroy", "PlayerConnectedToSignal", "DeactivateLootSensor", "LootSensorConnectionLost" )

	OnThreadEnd(
		function() : ( player )
		{
			if ( IsValid( file.soundEnt ) )
			{
				file.soundEnt.Destroy()
			}
		}
	)

	float uploadStartTime = 0
	bool alreadyFinishedTracker = player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.COMPLETED
	bool alreadyDidSearchingWait = false
	file.beepCount = 0
	file.pingCount = 0

	if( weapon.GetScriptClientInt0() <= 0 && !alreadyFinishedTracker )                             
	{
		weapon.SetScriptClientInt0( int( Time() ) )
		if ( IsEventFinale() )
			EmitSoundOnEntity( weapon, LOOT_SENSOR_LOBACR_FD_AUDIO )
			                     
	}

	while ( true )
	{
		if ( !IsValid( player ) || !IsValid( weapon ) )
			return

		int connectionType = player.GetPlayerNetInt( "lootSensorConnectionValue" )
		if ( connectionType == LootSensorConnectionType.FAILED )
		{
			weapon.SetScriptClientInt1( 0 )
		}
		else if ( connectionType == LootSensorConnectionType.CONNECTION_LOST )
		{
			weapon.SetScriptClientInt1( 1 )
			player.WaitSignal( "LootSensorGoalLocSet" )
		}
		else if ( connectionType == LootSensorConnectionType.SEARCHING && !alreadyDidSearchingWait )
		{
			weapon.SetScriptClientInt1( 2 )
			float activationTime = player.GetPlayerNetTime( "lootSensorActivateTime" )

			if ( activationTime > 0 )
			{
				wait MAX_CONNECTION_SEARCH_TIME - Time() + activationTime - SEARCH_TIME_BUFFER
				alreadyDidSearchingWait = true
			}
		}
		else if ( connectionType == LootSensorConnectionType.CONNECTED )                      
		{
			if ( file.isLootSensorActive )
			{
				if ( LootSensor_AutoUploadEnabled() && InConnectionRadius( player ) )
				{
					                                                                                                                     
					weapon.SetScriptClientFloat0( 0 )
					weapon.SetScriptClientInt1( 4 )
				}
				else
				{
					RunScreenUIBlinkUpdate( player, weapon )
				}
			}
		}
		else if ( connectionType == LootSensorConnectionType.UPLOADING )
		{
			if ( !InConnectionRadius( player ) && file.beepCount < 3 )
			{
				weapon.SetScriptClientInt1( 3 )
				RunScreenUIBlinkUpdate( player, weapon )
				StopUISound( LOOT_SENSOR_UPLOADING_AUDIO )
			}
			else
			{
				weapon.SetScriptClientInt1( 4 )

				if ( uploadStartTime == 0 )
				 {
					 uploadStartTime = Time()
					 weapon.SetScriptClientFloat0( 0 )
					 EmitUISound( LOOT_SENSOR_UPLOADING_AUDIO )
				 }

				float timeDiff = Time() - uploadStartTime
				float percentComplete = min( max( timeDiff / NODE_TRACKER_UPLOAD_TIME, 0 ), 1 ) * 100

				weapon.SetScriptClientFloat0( percentComplete )
			}
		}
		else if ( connectionType == LootSensorConnectionType.COMPLETED )
		{
			weapon.SetScriptClientInt1( 5 )
		}
		else if ( connectionType == -1 )
		{
			weapon.SetScriptClientInt1( -1 )
		}

		                                                           
		if ( connectionType != LootSensorConnectionType.CONNECTED && !( connectionType == LootSensorConnectionType.UPLOADING && !InConnectionRadius( player ) ) )
		{
			file.blinkTime = 0
			file.blinkDelay = MAX_AUDIO_DELAY
			file.pingCount = 0
			file.secondBeep = false
		}
		if ( connectionType < LootSensorConnectionType.UPLOADING )
		{
			uploadStartTime = 0
			file.beepCount = 0
		}

		WaitFrame()
	}
}


void function RunScreenUIBlinkUpdate( entity player, entity weapon )
{
	if ( !file.previouslyConnected )
	{
		weapon.SetScriptClientInt1( 3 )
	}
	else
	{
		weapon.SetScriptClientInt1( 6 )
	}

	if ( Time() > file.blinkTime + file.blinkDelay )
	{
		                                                                         
		vector viewVector = player.GetViewVector()
		viewVector.z = 0

		                                                                                                                                                                                          
		if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
			return

		vector goalLocation = player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin()

		vector playerToGoalVec = goalLocation - player.GetOrigin()
		playerToGoalVec.z = 0

		float dot = DotProduct( viewVector, playerToGoalVec )
		bool left = CrossProduct( viewVector, playerToGoalVec ).z < 0 ? true : false
		float ang = RadToDeg( acos( dot / Length( viewVector ) / Length( playerToGoalVec ) ) )

		if ( left )
		{
			weapon.SetScriptClientFloat0( -1 * ang )
		}
		else
		{
			weapon.SetScriptClientFloat0( ang )
		}

		                                                        
		float dist = Distance( goalLocation, player.GetOrigin() )
		float connectionStrength = max( 0, -1.0 / ( 2 * MAX_GOAL_RADIUS ) * pow ( max( dist - CONNECTION_RADIUS, 0 ), 1.5 ) + 100 )
		file.blinkDelay = ( MAX_AUDIO_DELAY - MIN_AUDIO_DELAY ) / ( 1.5 * MAX_GOAL_RADIUS ) * ( max( dist - CONNECTION_RADIUS, 0 ) ) + MIN_AUDIO_DELAY
		file.blinkDelay = min( file.blinkDelay, MAX_AUDIO_DELAY )

		if ( Time() >= player.GetPlayerNetTime( "lootSensorActivateTime" ) + MAX_CONNECTION_SEARCH_TIME - 0.5 )
		{
			if ( !file.secondBeep || fabs( ang ) < 30 )
			{
				if ( LootSensor_UseUpdatedBeep() )
				{
					float additionalPulseMultiplier = 1
					if ( file.secondBeep )
					{
						file.secondBeep = false
						player.Signal( "StopLootSensorSecondBeep" )
					}
					else if ( fabs( ang ) >= 30 )
					{
						thread CallSecondBeepAfterDelay_Thread( file.blinkDelay, player, connectionStrength )
						file.secondBeep = true
						additionalPulseMultiplier = 2
					}
				}

				if ( !( file.pingCount % SPHERE_PING_FREQUENCY == 0 && InSpherePingVisibilityRadius( player ) ) )
				{
					PlayBeepAudioForPlayer( player, connectionStrength )
				}
			}
			else
			{
				file.secondBeep = false
			}

			if ( file.pingCount % SPHERE_PING_FREQUENCY == 0 && InSpherePingVisibilityRadius( player ) )
			{
				if ( IsEventFinale())
					thread ShowClosingRingFxCR_Thread( player, file.blinkDelay * SPHERE_CLOSE_MULTIPLIER, connectionStrength )
				else
					thread ShowClosingRingFx_Thread( player, file.blinkDelay * SPHERE_CLOSE_MULTIPLIER, connectionStrength )
			}
			file.pingCount++
		}



		file.blinkTime = Time()
	}
}


void function PlayBeepAudioForPlayer( entity player, float connectionStrength)
{
	if ( file.isLootSensorActive )
	{
		if ( !IsValid( file.soundEnt ) )
		{
			file.soundEnt = CreateClientsideScriptMover( $"mdl/dev/empty_model.rmdl", player.GetOrigin(), ZERO_VECTOR )
		}
		else
		{
			file.soundEnt.SetOrigin( player.GetOrigin() )
		}

		float codeValue = 1000 - connectionStrength * 10                                                                               
		file.soundEnt.SetSoundCodeControllerValue( codeValue )
		EmitSoundOnEntity( file.soundEnt, LOOT_SENSOR_BEEP_AUDIO )
	}
}


void function CallSecondBeepAfterDelay_Thread( float delay, entity player, float connectionStrength )
{
	EndSignal( player, "StopLootSensorSecondBeep" )

	wait delay

	if ( !IsValid( player ) )
		return

	PlayBeepAudioForPlayer( player, connectionStrength )
}
#endif         


bool function InConnectionRadius( entity player )
{
	if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
		return false
	#if SERVER
		                                                                                                                                 
	#endif          
	#if CLIENT
		return DistanceSqr( player.GetOrigin(), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin() ) <= CONNECTION_RADIUS_SQR
	#endif          
	return false
}


bool function InEffectVisibilityRadius( entity player )
{
	if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
		return false
	#if SERVER
		                                                                                                                                           
	#endif          
	#if CLIENT
		return Distance2DSqr( player.GetOrigin(), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin() ) <= EFFECTS_VISIBILITY_RADIUS_SQR
	#endif          
	return false
}


bool function InSpherePingVisibilityRadius( entity player )
{
	if ( !IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) )
		return false
	#if SERVER
		                                                                                                                                               
	#endif          
	#if CLIENT
		return Distance2DSqr( player.GetOrigin(), player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin() ) <= SPHERE_PING_VISIBILITY_RADIUS_SQR
	#endif          
	return false
}


void function ActivateLootSensorForPlayer_Thread( entity player, entity weapon, bool setActive = false )
{
	if ( !IsValid( player ) || !LootSensorEnabled() )
		return

	#if SERVER
		                                               
		 
			                                                              
		 
		    
		 
			                         
			                          
			                             
			                                                
		 

		                                                                 
		 
			                                                                

			                       
				                                                                                  
		 

		                                     
		 
			                                                               
		 
	#endif          
	#if CLIENT
		thread ShowLootSensorUI_Thread( player, weapon )

		if ( IsValid( player.GetPlayerNetEnt( "lootSensorConnectedEnt" ) ) && player.GetPlayerNetEnt( "lootSensorConnectedEnt" ).GetOrigin() != NO_CONNECTION_VEC )
		{
			if ( IsEventFinale() )
			{
				thread ShowGoalLocRadiusCr_Thread( player )
			}
			else
			{
				thread ShowGoalLocRadius_Thread( player )
			}
		}

		if ( setActive )
		{
			file.isLootSensorActive = true
		}
	#endif         
}


void function DeactivateLootSensorForPlayer( entity player, bool forceDeactivate = false )
{
	if ( !IsPlayingFirstPersonAnimation( player ) || forceDeactivate )                                                                                
	{
		player.Signal( "DeactivateLootSensor" )
		#if SERVER
			                                                               
		#endif         
		#if CLIENT
			file.isLootSensorActive = false
		#endif          
	}
}


void function OnWeaponActivate_loot_sensor( entity weapon )
{
	if ( !IsValid( weapon ) || !LootSensorEnabled() )
		return

	#if SERVER
		                                                          
		                      
		 
			                           
		 
	#endif

	entity player = weapon.GetWeaponOwner()

	if ( !IsValid( player ) )
		return

	if ( GetCurrentPlaylistVarBool( "loot_sensor_use_old_activate_logic", false ) )                                                                                                  
	{
		if ( player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.SEARCHING ||
				player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.UPLOADING )
			return

		#if SERVER
			                                                                      
					                                                                                     
			 
				                                                            
			 
			                                                           
		#endif
	}
	else
	{
		#if SERVER
			                                                                                                          
				      

			                                                                                                                 
			                                                                                                      
						                                                                                                
					                                                                   
						                                                                                       
			 
				                                                            
			 
			                                                           
		#endif
		#if CLIENT
			if ( file.isLootSensorActive )
				return
		#endif
	}

	#if CLIENT
		entity localPlayer = GetLocalViewPlayer()
		if ( localPlayer != player )
			return

		thread ActivateLootSensorForPlayer_Thread( player, weapon, true )
	#endif
}


var function OnWeaponPrimaryAttack_loot_sensor( entity weapon, WeaponPrimaryAttackParams params  )
{
	entity player = weapon.GetWeaponOwner()
	if ( !IsValid( player ) || !LootSensorEnabled() || LootSensor_AutoUploadEnabled() )
		return 0

	if ( player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.SEARCHING ||
			player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.UPLOADING )
		return 0

	                                                                                                    
	                                      
	#if SERVER
		                                                                     
				                                                                                              
				                                                                                                     
		 
			                                                            
			                                                           
			                           
		 

		                                    
		 
			                                                         

			                      
		 
	#endif
	#if CLIENT
		entity localPlayer = GetLocalViewPlayer()
		if ( localPlayer != player )
			return

		if ( file.isLootSensorActive )
			return

		if ( player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.FAILED ||
			 player.GetPlayerNetInt( "lootSensorConnectionValue" ) == LootSensorConnectionType.CONNECTION_LOST )
		{
			thread ActivateLootSensorForPlayer_Thread( player, weapon )
			return 0                   
		}
	#endif

	return 0                    
}


void function OnWeaponDeactivate_loot_sensor( entity weapon )
{
	entity player = weapon.GetWeaponOwner()
	if ( !IsValid( player ) || !LootSensorEnabled() )
		return

	#if CLIENT
		entity localPlayer = GetLocalViewPlayer()
		if ( localPlayer != player )
			return
	#endif

	DeactivateLootSensorForPlayer( player )
}


#if SERVER && DEV
                                         
 
	                                          
	                             
	 
		                         
			        

		                                                                                                  
		 
			                                                                                               

			                                                       
		 
	 

	                                
 


                                              
 
	                                      
 


                                                                
 
	                                                      
	                                                        
	                                                          
 
#endif                 
                  
      
