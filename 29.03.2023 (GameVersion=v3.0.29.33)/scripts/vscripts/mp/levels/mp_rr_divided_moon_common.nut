global function DividedMoon_MapInit_Common
global function CodeCallback_PlayerEnterUpdraftTrigger
global function CodeCallback_PlayerLeaveUpdraftTrigger

const asset MOON_VICTORY_EFFECT = $"P_env_moon_victory"

#if SERVER
                                              
#endif          

                                                                      
void function CodeCallback_PlayerEnterUpdraftTrigger( entity trigger, entity player )
{
	float entZ = player.GetOrigin().z
	OnEnterUpdraftTrigger( trigger, player, entZ + 100 )
}

void function CodeCallback_PlayerLeaveUpdraftTrigger( entity trigger, entity player )
{
	OnLeaveUpdraftTrigger( trigger, player )
}

#if SERVER
                                                                                                      
                                                             
 
	                                            
                         
		                                                                                                                        
                               
	                                                  

	                                                                                                                                                   
	                                                                                                                                
 
#endif          

void function DividedMoon_MapInit_Common()
{
	printf( "%s()", FUNC_NAME() )

	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_divided_moon.rpak" )

	UpdraftTriggerSettings dividedMoonUpdraftSettings = {
		minShakeActivationHeight = 500.0                                                                       
		maxShakeActivationHeight = 400.0                                                                                     
		liftSpeed                = 425.0                                      
		liftAcceleration         = 200.0                                                                    
		liftExitDuration         = 2.0                                                                                                      
	}
	OverrideUpdraftTriggerSettings ( dividedMoonUpdraftSettings )

                                
		Valentines_S15_Map_Init( false )
       

                                                    
                              
       

	#if SERVER
	                

	                                                                                
	#endif

	DividedMoonStoryEvents_Init()

	#if SERVER
		                        
	#elseif CLIENT
		ClCommonStoryEvents_Init()
	#endif

	SetVictorySequencePlatformModel( $"mdl/levels_terrain/mp_rr_divided_moon/divided_victory_platform.rmdl", < 0, 0, -10 >, <0, 10, 0> )
	#if CLIENT
		SetVictorySequenceLocation(<-26436.28076, 39242.0625, 13816.7988>, <0, 195, 0> )
		SetVictorySequenceEffectPackage( <-26436.28076, 39242.0625, 13816.7988>, <0, 100, 0>, MOON_VICTORY_EFFECT )
                         
		SetVictorySequenceEffectPackage( <-26436.28076, 39242.0625, 13816.7988>, <0, 100, 0>, $"P_podium_backdrop_FW_Moon", "UI_InGame_Victory_Anniversary_Fireworks_Single", "UI_InGame_Victory_Anniversary_Fireworks", true )
        
		                                              
	#endif
}

