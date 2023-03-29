global function Desertlands_PreMapInit_Common
global function Desertlands_MapInit_Common
global function CodeCallback_PlayerEnterUpdraftTrigger
global function CodeCallback_PlayerLeaveUpdraftTrigger

#if SERVER
                                              
                                                     
                                                  
                                           
                          
#endif


#if SERVER
                                                               
                                        
                                                        
                                           
                                           
                                          
                                          
                                                  
                                                 
                                                 
                                                     
                                                       
                                                                              

                                       
                                              
                                          
                                                    
                                                   

              
                                             
#endif

#if CLIENT
const JUMP_PAD_LAUNCH_SOUND_1P = "Geyser_LaunchPlayer_1p"
#endif

struct
{
	#if SERVER
	                          
	#endif
} file

void function Desertlands_PreMapInit_Common()
{
	DesertlandsTrain_PreMapInit()
}

void function Desertlands_MapInit_Common()
{
	printt( "Desertlands_MapInit_Common" )

                                
		Valentines_S15_Map_Init()
       

                                                    
                       
       

                    
                                              
  
                                                                                            
  
     
      
	{
		SetVictorySequencePlatformModel( $"mdl/rocks/desertlands_victory_platform.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )
	#if CLIENT
		SetVictorySequenceLocation( <11092.6162, -20878.0684, 1561.52222>, <0, 267.894653, 0> )
		SetVictorySequenceSunSkyIntensity( 1.0, 0.5 )
                       
		SetVictorySequenceEffectPackage( <11092.6162, -20878.0684, 1561.52222>, <0, 220, 0>, $"P_podium_backdrop_FW_des", "UI_InGame_Victory_Anniversary_Fireworks_Single", "UI_InGame_Victory_Anniversary_Fireworks", true )
      
	#endif
	}

                         
		if ( Control_IsModeEnabled() )
		{
			#if SERVER || CLIENT
				                                                     
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_A, [ <4377.86572, -26819.9141, -3711.96875>, <2097.12085, -26366.8496, -3703.5625>, <518.120239, -24563.4102, -3639.96875>, <-318.68219, -21906.8262, -3898.45557> ] )
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_B, [ <8058.47754, -14368.2168, -3717.50073>, <11589.5918, -14460.458, -3718.93726>, <13570.1641, -16230.3955, -3717.59326>, <13909.2988, -18391.2441, -3723.20239>, <9866.09863, -12401.3018, -3658.69238>, <5657.99072, -13631.9248, -3711.9375> ] )
			#endif                    
		}
       

	#if SERVER
		                                              

		                                
		                                  
		                                  
		                              

		                          
			                            

		                                                                             

		                                                                                
	#endif

	#if CLIENT
		Freefall_SetPlaneHeight( 15250 )
		Freefall_SetDisplaySeaHeightForLevel( -8961.0 )
		SetMinimapBackgroundTileImage( $"overviews/mp_rr_canyonlands_bg" )

		AddCreateCallback( "trigger_cylinder_heavy", Geyser_OnJumpPadCreated )
		RegisterMinimapPackage( "prop_script", eMinimapObject_prop_script.TRAIN, MINIMAP_OBJECT_RUI, MinimapPackage_Train, FULLMAP_OBJECT_RUI, FullmapPackage_Train )
	#endif
}

#if SERVER
                               
 
	                          
		                              
 
#endif

#if SERVER
                                                         
 
	                             
 
#endif

                                                                                                   
                                                                                                   
  
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
  
                                                                                                   
                                                                                                   

#if SERVER
                                              
 
	                                                                                    

	                            
	                                            
	                
	                             

	                                                               

	                                                                                                  
 


                                                           
 
	                         
		      

	                                            
	                                                 
	 
		                                     
	 
 

                       
                       
             


                                                         
 
	                                         
 


                                                       
 
	                              

	                                                         
	                
	              

	                                               
	                      
	 
		                                                       
			           
		                                                         
			             
	 


	                                                                              
	                                                                            

	                                 
	                                         

	                                                                              
	                                                     

	                            

	              
	 
		                                    

		                                    

		             

		                   
		                                      
		                                      

		                                       
	 
 


                                                                 
 
	                                            
                         
		                                                                                                                            
                               
	                                                 
	                                   
 


                                                     
 
	            
	               

	                                                 

	                                                                                                                   
	                   
		                                                                        
 


               
                          
 
	                                                                      
	                                   
	 
		                                      
		                  
	 
 


                                                     
 
	                                                
	                                

	                                                     
	                                   

	                                                         
	                                          
	                           
	                                                 
	                            
	                                                                                                                                                    
	                           
	                           
	                                     
	                                                            
	                                                                                                          
	                                       
	                           
	                                          
	                        
	                                                     

	                                                                                                                                                                  
	                                                          

	                                                                                                                         
	                                                                                                                          

	            
		                        
		 
			                 
		   

	             
 


                                                                     
 
	                                                                               
 


                                                                                               
 
	                                                  
	 
		                     
		 
			                                   
			                         
			 
				                                                       
				                                                                                               
			 

			                        

			                                          
		 
		    
		 
			                                                   
			                                                   
		 
	 
 


                                                           
 
	                         
		      

	                             
	                               
	                               
	                                  
	                     
	                      

	                                                                            
	                                                                            

	                        
	                                                         
	                                            
	                                     
	 
		                                                              
		                                                                                                                                                  
		                             
		                           
		                                                          
		                               

		                                                            
		                                                                                                                                            
		                        
		                                                    
		                            
	 

	            
		                                   
		 
			                            
			 
				                    
					            
			 

			                        
			 
				                      
				                     
				                                                      
			 
		 
	 

	           

	        

	                             
	 
		           
	 
 


                                                                   
 
	                       
		            
                         
                                
              
      

	                         
		            

	                           
		            

	           
 


                       
                       
             

                                                               
                             
 
	                                                                               
	                                      
	 
		                                                  
		 
			                                                     
			                                           
			                                           
			                                             
			                                                       
			                                        
			                                          
			                                        
			                                     
			                           
			                 
		 
	 
 

                                                 
 
	                           
	                               
	                             
	                                                
	                             
	 
		                                              
			     

		                               
		 
			                                                                                                    
		 

		        
	 
 
#endif

void function CodeCallback_PlayerEnterUpdraftTrigger( entity trigger, entity player )
{
	float entZ = player.GetOrigin().z
	OnEnterUpdraftTrigger( trigger, player, max( -5750.0, entZ - 400.0 ) )
	#if SERVER
		                                                    
	#endif
}


void function CodeCallback_PlayerLeaveUpdraftTrigger( entity trigger, entity player )
{
	OnLeaveUpdraftTrigger( trigger, player )
}

#if SERVER
                                               
 
	                                                                                      
	                                                                     
	                             
	                                        
	                                      
	 
		                                          
	 
 
#endif

#if CLIENT
void function MinimapPackage_Train( entity ent, var rui )
{
	if ( MINIMAP_DEBUG )
		printt( "Adding 'rui/hud/gametype_icons/sur_train_minimap' icon to minimap" )

	RuiSetImage( rui, "defaultIcon", $"rui/hud/gametype_icons/sur_train_minimap" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}

void function FullmapPackage_Train( entity ent, var rui )
{
	MinimapPackage_Train( ent, rui )
	RuiSetFloat2( rui, "iconScale", <1.5,1.5,0.0> )
	RuiSetFloat3( rui, "iconColor", <0.5,0.5,0.5> )
}

void function Geyser_OnJumpPadCreated( entity trigger )
{
	if ( trigger.GetTriggerType() != TT_JUMP_PAD )
		return

	if ( trigger.GetTargetName() != "geyser_trigger" )
		return

	trigger.SetClientEnterCallback( Geyser_OnJumpPadAreaEnter )
}

void function Geyser_OnJumpPadAreaEnter( entity trigger, entity player )
{
	entity localViewPlayer = GetLocalViewPlayer()
	if ( player != localViewPlayer )
		return

	if ( !IsPilot( player ) )
		return

	if ( trigger.GetTargetName() != "geyser_trigger" )
		return

	EmitSoundOnEntity( player, JUMP_PAD_LAUNCH_SOUND_1P )
	EmitSoundOnEntity( player, "JumpPad_Ascent_Windrush" )
}
#endif