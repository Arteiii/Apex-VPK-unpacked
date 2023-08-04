global function Lifesteal_Init

#if CLIENT
global function ServerToClient_AddLifestealHealVFX
#endif

#if SERVER
                                           
#endif

       
const string LIFESTEAL_WEAPON_VAR = "lifesteal_heal_percent"

           
const float VALENTINES_HEAL_DEBOUNCE_SEC = 10

     
const VFX_COCKPIT_HEALTH = $"P_heal_loop_screen"
const VFX_COCKPIT_SHIELDS = $"P_armor_FP_charging_CP"
const VFX_PLAYER_HEALED_3P = $"P_armor_3P_loop_CP"                   

     
const SFX_RECEIVING_HEAL_1P = "DateNight_AOE_Bow_Healing_Success_1P"
const SFX_GAVE_HEAL_1P = "DateNight_AOE_Success_Stinger_1P"
const SFX_RECEIVING_HEAL_3P = "DateNight_AOE_Success_Stinger_3P"

struct
{
	#if SERVER
		                       
	#endif

	#if CLIENT
		bool  isHealing = false
		float healedEndTime
	#endif
} file

void function Lifesteal_Init()
{
	PrecacheParticleSystem( VFX_COCKPIT_HEALTH )
	PrecacheParticleSystem( VFX_COCKPIT_SHIELDS )
	PrecacheParticleSystem( VFX_PLAYER_HEALED_3P )

	Remote_RegisterClientFunction( "ServerToClient_AddLifestealHealVFX", "bool" )
}

#if SERVER
                                                            
 
	                              
	                                                              
	                         
	                         

	                                        

	                     
	 
		                             
		 
			                                                 
			            
		 
		    
		 
			                                         
			                      
		 
		                   
	 

	                                                                      

	                                    
	 
		                                                                 
		                                                
		                            
		 
			                                                             
		 
		    
		 
			                                                     
		 
		                  
	 

	                                  
	 
		                                               
		                                                                                                        
		                                                                      
	 

	                                  
 

                                                                
 
	                             
	                               

	                                                                                                                                                                                      
	                                                                                    
	                           
	                                     
	                                                 

	            
		                         
		 
			                          
				                      
		 
	 

	      
 
#endif

#if SERVER
                                                                                                                                                                       
 
	                                                                       
	                                        
		      

	                         
		      

	                                                   
	                                                                                      
	  	      

	                                                                                   
	                       
		      

	                              
	                         
		      

	                           
		      

	                                  
		      

	                                                   
	                                               
		      

	                                                             
		      

	                                  
	                                                                             
		      

	                                                             
	                                        

	                      
		      

	                                                         
	                        

                                
		                                    
		                                                                                                             
		                                                 

		                          
			      

		                                                           
		 
			                                                  
		 
       

	                                                  
	               
	 
		                                                                                 
	 

	                  
	 
		                                                                                
		                                                                     
	 
 
#endif


#if CLIENT
const float HEAL_VFX_DURATION = 1
void function ServerToClient_AddLifestealHealVFX( bool onlyShields )
{
	AddHealVFX( HEAL_VFX_DURATION, onlyShields )
}

void function AddHealVFX( float duration, bool onlyShields )
{
	file.healedEndTime = (Time() + duration)

	if ( !file.isHealing )
		thread HealVFX_Thread( onlyShields )
}

void function HealVFX_Thread( bool onlyShields )
{
	entity player = GetLocalViewPlayer()

	player.EndSignal( "OnDeath" )
	player.EndSignal( "OnDestroy" )

	file.isHealing = true

	int fxID = onlyShields ? GetParticleSystemIndex( VFX_COCKPIT_SHIELDS ) : GetParticleSystemIndex( VFX_COCKPIT_HEALTH )

	int fxHandle = StartParticleEffectOnEntity( player, fxID, FX_PATTACH_ABSORIGIN_FOLLOW, ATTACHMENTID_INVALID )
	EffectSetIsWithCockpit( fxHandle, true )
	if ( onlyShields )
	{
		int armorTier      = EquipmentSlot_GetEquipmentTier( player, "armor" )
		vector shieldColor = GetFXRarityColorForTier( armorTier )
		EffectSetControlPointVector( fxHandle, 1, shieldColor )
	}
	OnThreadEnd(
		function() : (fxHandle)
		{
			file.isHealing = false
			if ( EffectDoesExist( fxHandle ) )
				EffectStop( fxHandle, false, true )
		}
	)

	while( (file.healedEndTime > Time()) )
		WaitFrame()
}
#endif