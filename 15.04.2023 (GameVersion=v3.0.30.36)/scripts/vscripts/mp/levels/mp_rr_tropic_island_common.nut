global function Tropics_MapInit_Common
global function CodeCallback_PreMapInit

const asset TROPICS_VICTORY_EFFECT = $"P_env_trop_victory"
const asset STORMCATCHER_GEOFIX_MODEL = $"mdl/tropics/stormcatcher_towerblock_02.rmdl"

void function CodeCallback_PreMapInit()
{
                            
		if ( IsTropicsWildlifeEnabled() )
		{
			TropicsWildlife_PreMapInit()
		}
       
}

void function Tropics_MapInit_Common()
{
	printf( "%s()", FUNC_NAME() )

	ShPrecacheSkydiveLauncherAssets()

	SetVictorySequencePlatformModel( $"mdl/levels_terrain/mp_rr_tropic/tropic_victory_platform.rmdl", < 0, 0, -10 >, <0, 79.0578232, 0> )

                        
	if ( Control_IsModeEnabled() )
	{
		SetVictorySequencePlatformModel( $"mdl/levels_terrain/mp_rr_tropic/tropic_victory_platform_control.rmdl", < 0, 0, -10 >, <0, 79.0578232, 0> )

		#if SERVER || CLIENT
			                                                     
			Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_A, [ <-10868.0049, -11685.083, 211.251877>, <-4962.93945, -20376.8828, -31.9687519>, <-6405.43945, -17740.2832, 72.4342575>, <-10007.4473, -14843.6836, -22.704565>, <-15658.9727, -13812.6641, -18.140873>, <-13510.5303, -12344.6689, -31.8686733>, <-7350.72998, -15252.8564, 303.776337> ] )
			Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_B, [ <-21250.0156, -32458.373, -31.9687519>, <-16748.8164, -32209.3438, 236.703125>, <-23425.1348, -29427.9922, -22.5844955>, <-19015.5781, -32442.6445, 90.3130798>, <-23116.4648, -31528.0957, -31.8373814>, <-25676.6641, -28813.0742, -31.9687481> ] )
		#endif                    
	}
      

	#if CLIENT
		SetVictorySequenceLocation(<46246.2188, 24016.5508, 19370.9395>, <0, 79.0578232, 0> )
		SetVictorySequenceEffectPackage( <46246.2188, 24016.5508, 19370.9395>, <0, 169.0578232, 0> , TROPICS_VICTORY_EFFECT )
                         
		SetVictorySequenceEffectPackage( <46246.2188, 24016.5508, 19370.9395>, <0, 169.0578232, 0>, $"P_podium_backdrop_FW_trop", "UI_InGame_Victory_Anniversary_Fireworks_Single", "UI_InGame_Victory_Anniversary_Fireworks", true )
        
		SetVictorySequenceSunSkyIntensity( .9, 0.4 )
	#endif
	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_tropic_island.rpak" )

	                        
	                    
	                        
                            
		TropicsWildlife_Init()
		if ( !IsTropicsWildlifeEnabled() )
		{
			FreelanceNPCs_Init()                                                                           
		}
      
                                                                                                 
       

#if SERVER
	                                                                       
	                                                

	                                                                                 
#endif          

                    
                       
       

	#if SERVER
		                        
	#elseif CLIENT
		ClCommonStoryEvents_Init()
	#endif
		TropicsStoryEvents_Init()
}

#if SERVER
                                             
 
	                     
		      

	             
 
#endif          