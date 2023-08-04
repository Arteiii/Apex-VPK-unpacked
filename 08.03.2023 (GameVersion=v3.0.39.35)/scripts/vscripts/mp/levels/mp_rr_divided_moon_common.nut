global function DividedMoon_MapInit_Common
global function CodeCallback_PlayerEnterUpdraftTrigger
global function CodeCallback_PlayerLeaveUpdraftTrigger

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
}

