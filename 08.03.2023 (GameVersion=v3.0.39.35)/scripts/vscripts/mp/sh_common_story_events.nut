#if SERVER
                                      
#endif

#if CLIENT
global function ClCommonStoryEvents_Init
                      
global function ServerCallback_TriggerMemoryMalfunction
      
#endif

struct
{
                       
	table< entity, bool > hasPlayerExperienceMemoryTable
       
} file


                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
  
                               
                            
                            
                            
                            
                            
                            
  
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    
                                                                                                                                    

                      
const asset FX_MEMORY_SCREEN = $"p_Rev_rework_tease_screen"
      

#if SERVER
                                      
 
	                                              

                      
	                          
	 
		                                          
		                                                              
	 
      
 
#endif


#if CLIENT
void function ClCommonStoryEvents_Init()
{
                      
	if ( IsRevGlitchActive() )
		PrecacheParticleSystem( FX_MEMORY_SCREEN )
      

	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
}
#endif

#if SERVER || CLIENT
void function EntitiesDidLoad()
{

}
#endif

                      
#if SERVER
                                                      
 
	                                                     
	 
		                                              
		       
			                                                                                  
		      
	 
 

                                                              
 
	                      
		      

	                      
		      

	                                    
		      

	                              
		      

	                 
	                                                      
		      

	                                                          
	                                                                                             
		      

	                                                                                 
		      

	                                                                            

	                                                
 
#endif

#if CLIENT
void function ServerCallback_TriggerMemoryMalfunction()
{
	thread function() : () {
		entity localViewPlayer = GetLocalViewPlayer()
		if ( !IsValid ( localViewPlayer ) )
			return

		if ( !IsValid( localViewPlayer.GetCockpit() ) )
			return

		int index = GetParticleSystemIndex( FX_MEMORY_SCREEN )

		                             

		int fxID1 = StartParticleEffectOnEntity( localViewPlayer, index, FX_PATTACH_POINT_FOLLOW, localViewPlayer.GetCockpit().LookupAttachment( "CAMERA" ) )
		EmitUISound( "Revenant_17_1_Overlay_1p" )

		                      
		EffectSetIsWithCockpit( fxID1, true )

		OnThreadEnd(
				function() : ( fxID1 )
				{
					if ( EffectDoesExist( fxID1 ) )
						EffectStop( fxID1, false, true )
				}
			)

		wait GetCurrentPlaylistVarFloat( "s17_glitch_duration", 5.0 )
	}()
}
#endif
      