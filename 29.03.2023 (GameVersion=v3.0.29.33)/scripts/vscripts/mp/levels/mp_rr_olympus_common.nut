global function Olympus_MapInit_Common


const float RIFT_INNER_RADIUS = 850.0
const float RIFT_OUTER_RADIUS = 1200.0
const float RIFT_REDUCE_SPEED_INNER = 250.0
const float RIFT_REDUCE_SPEED_OUTER = 500.0
const float RIFT_PULL_SPEED = 1500.0
const float RIFT_SWIRL_ACCEL = 1200.0
const float RIFT_TRIGGER_BOX_SIZE = 350.0

const asset OLYMPUS_VICTORY_EFFECT = $"P_env_oly_victory"

struct
{
	table< entity, int > riftHandles
} file

void function Olympus_MapInit_Common()
{
	printf( "%s()", FUNC_NAME() )

	ShPrecacheSkydiveLauncherAssets()

                                
		Valentines_S15_Map_Init()
       

                                                    
                       
       

	vector victoryPlatformAngles = < 0, 0, 0 >
	vector victorySequencePosition = <15002.5635, 16763.1055, 2355.54785>
	vector victorySequenceAngles = <0, 15.1553955, 0>
	vector victoryEffectAngles = <0, 105.155, 0>
	vector victoryPlatformOffset = < 0, 0, -10 >
	float victorySequenceSunIntensity = 1
	float victorySequenceSkyIntensity = 1
	if ( GetMapName() == "mp_rr_olympus_mu2" )
	{
		victoryPlatformAngles = < 0, -235, 0 >
		victorySequencePosition = <-31145.642578, 28981.710938, 3519.912354>
		victorySequenceAngles = <0, -220, 0>
		victoryEffectAngles = <0, -130, 0>
		victorySequenceSunIntensity = 0.6
		victorySequenceSkyIntensity = 0.7
	}

	SetVictorySequencePlatformModel( $"mdl/levels_terrain/mp_rr_olympus/floating_victory_platform_01.rmdl", victoryPlatformOffset, victoryPlatformAngles )

                         
		if ( Control_IsModeEnabled() )
		{
			if ( GetMapName() == "mp_rr_olympus_mu2" )
			{
					victoryPlatformOffset = < -27, 0, -10 >
			}
			else
			{
					victoryPlatformOffset = < 15, 0, -10 >
			}

			SetVictorySequencePlatformModel( $"mdl/levels_terrain/mp_rr_olympus/floating_victory_platform_control_01.rmdl", victoryPlatformOffset, victoryPlatformAngles )

			#if SERVER || CLIENT
				                                                     
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_A, [ <4974.02686, 1975.41541, -4458.56885>, <1061.4856, 6256.33154, -5323.96875>, <-3439.14258, 7960.45068, -5095.95801>, <3797.76172, 8994.75, -5087.31396>, <-3947.23169, 6873.3335, -5095.96875>, <2989.89453, 4081.48608, -4804.11621>, <-890.098938, 6173.85254, -5263.30566> ] )
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_B, [ <-16851.3535, -7533.10938, -5167.93262>, <-17533.2793, -5086.30225, -5117.9248>, <-15849.4941, 788.421082, -5450.62695>, <-15126.8623, -9503.92285, -4598.41455>, <-20152.125, -6325.14648, -5248.32715>, <-17877.4824, 2665.34277, -5367.86133>, <-16494.5742, -2241.39136, -5163.96875> ] )
			#endif                    
		}
       

	#if CLIENT
		SetVictorySequenceLocation( victorySequencePosition, victorySequenceAngles )
		SetVictorySequenceEffectPackage( victorySequencePosition, victoryEffectAngles, OLYMPUS_VICTORY_EFFECT )
		SetVictorySequenceSunSkyIntensity(victorySequenceSunIntensity, victorySequenceSkyIntensity)
		Freefall_SetPlaneHeight( 12500 )
		Freefall_SetDisplaySeaHeightForLevel( -11500 )
	#endif

	#if SERVER
		                       

		                                                                
		 
			                                            
		 

		                                                                            
	#endif

	#if SERVER && DEV
		                                              
	#endif

	#if CLIENT
		SetMinimapBackgroundTileImage( $"overviews/mp_rr_olympus_bg" )
	#endif
}

#if SERVER && DEV
                               
 
	                                 
 
#endif


#if SERVER

                                     
 
	                                                              
	 
		                                                                                                    
		                                                  
			      

		                
	   
 

                        

                                     
 
	                                           
		      

	                                                        
	                                    
	                                    
	                                                                                                                                              
	                                                    
	                                                    
	                                      
	                                          

	                        

	                                          
	                                                        

	                
 

                                                                    
 
	                                

	                                                               

	                                                                                               
		                                                                                                                                                                                      

	                           
		                        
 

                                                                    
 
	                                

	                           
		                               
 

                                                
 
	                                                                                               
	                        
	                                 
 

                                                       
 
	                                                    
	                                                               
	                                                                             
 
#endif