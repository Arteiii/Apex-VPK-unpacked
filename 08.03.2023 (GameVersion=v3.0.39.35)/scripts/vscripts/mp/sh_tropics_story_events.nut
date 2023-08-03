#if SERVER || CLIENT
global function TropicsStoryEvents_Init
#endif

                 
#if SERVER || CLIENT
global function S17Storm_GetPhase
#endif

               
const string S17STORM_COLONY_ROTOR_SCRIPTNAME = "colony_rotor"
const string S17STORM_DASHBOARDSCREEN_SCRIPTNAME = "s12e05_screen_1"
const string S17STORM_WEATHERSCREEN_SCRIPTNAME = "s12e05_screen_2"
const string S17STORM_MAPSCREEN_SCRIPTNAME = "s12e05_screen_3"

const string S17STORM_P1_SKYBOX_SCRIPTNAME = "tropics_storm_s1"
const string S17STORM_P2_SKYBOX_SCRIPTNAME = "tropics_storm_s2"
const string S17STORM_P3_SKYBOX_SCRIPTNAME = "tropics_storm_s3"

const string S17STORM_WINDFARM_ROT_SCRIPTNAME = "tropic_wind_farm_rotator"

const table< string, string > SOUNDSCAPE_TO_AMBIENTEVENT_TABLE =
{
	["Amb_Storm_Global"] = "Tropics_AMB_EXT_Global",
	["Amb_Zone11"] = "Tropics_AMB_EXT_Zone11_Cenote_BeachSide",
	["Amb_Zone12"] = "Tropics_AMB_EXT_Zone12_Barometer_Cove",
	["Amb_Zone14_Beach"] = "Tropics_AMB_EXT_Zone14_TheOdysseus_Beach",
	["Amb_Zone14_Hill"] = "Tropics_AMB_EXT_Zone14_TheOdysseus_Hill",
	["Amb_Zone14_Island"] = "Tropics_AMB_EXT_Zone14_TheOdysseus_Beach_Island",
	["Amb_Zone15"] = "Tropics_AMB_EXT_Zone15_IslandChains_Beach",
	["Amb_Zone16_Beach"] = "Tropics_AMB_EXT_Zone16_LaunchSite_BeachSide",
	["Amb_Zone16_Launch"] = "Tropics_AMB_EXT_Zone16_LaunchSite",
}

const table < string, string > AMBIENT_GENERIC_EVENT_TABLE =
{
	["Storm_Center"] = "Tropics_Mu1_Storm_Emit_Thunder",
	["TreeWind_Heavy_A"] = "Tropics_Mu1_Storm_Emit_TreeWind_Heaviest_A",
	["TreeWind_Heavy_B"] = "Tropics_Mu1_Storm_Emit_TreeWind_Heaviest_B",
	["TreeWind_Heavy_C"] = "Tropics_Mu1_Storm_Emit_TreeWind_Heaviest_C",
	["TreeWind_Heavy_D"] = "Tropics_Mu1_Storm_Emit_TreeWind_Heaviest_D",
	["TreeWind_Heavy_E"] = "Tropics_Mu1_Storm_Emit_TreeWind_Heaviest_E"
}

const string CC_AMBIENT_SCRIPTNAME = "CommandCenter_ComputerScreen"
const array < string > CC_AMBIENT_SOUND_BY_PHASE = [ "Tropics_Mu1_Storm_Emit_ComputerScreen_Calm", "Tropics_Mu1_Storm_Emit_ComputerScreen_Alert", "Tropics_Mu1_Storm_Emit_ComputerScreen_Alert", "Tropics_Mu1_Storm_Emit_ComputerScreen_Urgent" ]

const string WIND_ROTATORS_SCRIPT_NAME = "WindRotor_Windy"

const string AMBIENT_EVENT_WINDY_POSTFIX = "_Windy"
const string AMBIENT_EVENT_STORMY_POSTFIX = "_Stormy"

global enum S17STORM_PHASE
{
	DISABLED = 0,
	PHASE1,
	PHASE2,
	PHASE3,

	_COUNT
}

const array < float > WIND_SPEED_BY_PHASE = [ 1.0, 1.75, 2.5, 2.5 ]
const array < float > ROTOR_SPEED_BY_PHASE = [ 1.0, 4.0, 8.0, 8.0 ]
const array < string > ROTOR_AMBIENT_SOUND_BY_PHASE = [ "", "Tropics_Zone15_Emit_WindRotors_Level02_Fast", "Tropics_Zone15_Emit_WindRotors_Level03_VeryFast", "Tropics_Zone15_Emit_WindRotors_Level03_VeryFast" ]

      

struct
{

} file


                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
  
                               
                            
                            
                            
                            
                            
                            
  
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    

#if SERVER || CLIENT
void function TropicsStoryEvents_Init()
{
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
                  
	if ( GetMapName() == "mp_rr_tropic_island_mu1_storm" )
		S17Storm_Init()
       
}
#endif                    

void function EntitiesDidLoad()
{
                  
	#if CLIENT
	if ( GetMapName() == "mp_rr_tropic_island_mu1_storm" )
	{
		S17Storm_SetupColonyRotors()
		S17Storm_SetupSoundScapes()
		S17Storm_SetupAmbientGenerics()
		S17Storm_SetupCCAmbientGenerics()
	}
	#endif
       
}

                 
#if SERVER || CLIENT
void function S17Storm_Init()
{
	#if SERVER
	                                                                    
	                                                        
	                                                                     
	#endif

	#if CLIENT
		int phase = S17Storm_GetPhase()
		SetupStormWind( phase )
	#endif
}

int function S17Storm_GetPhase()
{
	#if DEV
		int devPhase = GetCurrentPlaylistVarInt( "s17st_debug_phase", -1 )
		if ( devPhase != -1 )
			return devPhase
	#endif

	int unixTimeNow = GetUnixTimestamp()
	if ( unixTimeNow >=  expect int( GetCurrentPlaylistVarTimestamp( "s17st_p3_active", UNIX_TIME_FALLBACK_2038 ) ) )
	{
		return S17STORM_PHASE.PHASE3
	}
	else if ( unixTimeNow >=  expect int( GetCurrentPlaylistVarTimestamp( "s17st_p2_active", UNIX_TIME_FALLBACK_2038 ) ) )
	{
		return S17STORM_PHASE.PHASE2
	}
	else if ( unixTimeNow >=  expect int( GetCurrentPlaylistVarTimestamp( "s17st_p1_active", UNIX_TIME_FALLBACK_2038 ) ) )
	{
		return S17STORM_PHASE.PHASE1
	}

	return S17STORM_PHASE.DISABLED
}
#endif

#if CLIENT
void function S17Storm_SetupColonyRotors()
{
	int phase = S17Storm_GetPhase()
	float rotatorSpeed = ROTOR_SPEED_BY_PHASE[ phase ]
	string ambientSound = ROTOR_AMBIENT_SOUND_BY_PHASE [ phase ]
	array< entity > rotors = GetEntArrayByScriptName( S17STORM_COLONY_ROTOR_SCRIPTNAME )
	foreach ( rotor in rotors )
	{
		rotor.Anim_SetPlaybackRate( rotatorSpeed )
	}

	if ( ambientSound == "" )
		return

	array< entity > rotorsAmbients = GetEntArrayByScriptName( WIND_ROTATORS_SCRIPT_NAME )
	foreach ( rotatorAmbient in rotorsAmbients )
	{
		rotatorAmbient.SetSoundName( ambientSound )
	}
}

void function S17Storm_SetupSoundScapes()
{
	string postfix = ""
	switch ( S17Storm_GetPhase() )
	{
		case S17STORM_PHASE.PHASE1:
			postfix = AMBIENT_EVENT_WINDY_POSTFIX
			break
		case S17STORM_PHASE.PHASE2:
		case S17STORM_PHASE.PHASE3:
			postfix = AMBIENT_EVENT_STORMY_POSTFIX
			break
		default:
			break
	}

	if ( postfix == "" )
		return

	foreach ( soundScapeScriptName, ambientEvent in SOUNDSCAPE_TO_AMBIENTEVENT_TABLE )
	{
		array< entity > soundScapes = GetEntArrayByScriptName( soundScapeScriptName )
		string postFixedAmbientEvent = ambientEvent + postfix
		foreach( soundScape in soundScapes )
		{
			soundScape.kv.ambient_event = postFixedAmbientEvent
		}
	}
}

void function S17Storm_SetupAmbientGenerics()
{
	if ( S17Storm_GetPhase() < S17STORM_PHASE.PHASE2 )
		return

	foreach ( ambientGenericScriptName, eventName in AMBIENT_GENERIC_EVENT_TABLE )
	{

#if NX_PROG
			if ( ambientGenericScriptName != "Storm_Center" )
				continue
#endif

		array< entity > ambients = GetEntArrayByScriptName( ambientGenericScriptName )
		foreach( ambient in ambients )
		{
			ambient.SetSoundName( eventName )
		}
	}
}

void function S17Storm_SetupCCAmbientGenerics()
{
	int phase = S17Storm_GetPhase()
	string ambientSound = CC_AMBIENT_SOUND_BY_PHASE [ phase ]

	array< entity > ambients = GetEntArrayByScriptName( CC_AMBIENT_SCRIPTNAME )
	foreach( ambient in ambients )
	{
		ambient.SetSoundName( ambientSound )
	}
}

void function SetupStormWind( int phase )
{
	SetConVarFloat("wind_speed_multiplier", WIND_SPEED_BY_PHASE[ phase ])
}

#endif

#if SERVER
                                                
 
	                              
	 
		                                         
			                                       
			     
		                                       
			                                       
			     
		                                   
			                                        
			     
		                                   
			                                    
			     
		                                   
			                                    
			     
		                                   
			                                    
			     
		                          
		                                         
		  	                                     
		        
			     
	 
 

                                                                          
 
	                       
		      

	                               
	                              
	                   
 

                                                                         
 
	                       
		      

	                                          
		             
 

  
                       
                                                          
 

   
#endif
      

