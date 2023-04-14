global function Canyonlands_MapInit_Common
global function CodeCallback_PlayerEnterUpdraftTrigger
global function CodeCallback_PlayerLeaveUpdraftTrigger

#if SERVER && DEV
	                                      
	                                      
#endif

#if SERVER
	                                          
	                                      
	                                   
	                                              

	                            
	                                      		                        
	                                    		                      
	                                         	       

	                                                                 

	                                                         

	                                                                                                  

	                                                       
	                                                                   

	                                              
	                                    
	                                  

	                                              
	 
		              
		                       
		                            
		              
		                        
		             
	 
#endif

const int HOVER_TANKS_DEFAULT_COUNT_INTRO = 1
const int HOVER_TANKS_DEFAULT_COUNT_MID = 1
global const asset LEVIATHAN_MODEL = $"mdl/creatures/leviathan/leviathan_kingscanyon_preview_animated.rmdl"
const asset FLYER_SWARM_MODEL = $"mdl/Creatures/flyer/flyer_kingscanyon_animated.rmdl"
global const string CANYONLANDS_LEVIATHAN1_NAME = "leviathan1"
global const string CANYONLANDS_LEVIATHAN2_NAME= "leviathan2"
global const string CANYONLANDS_LEVIATHANBABY_NAME= "leviathan3"
const string HOVER_TANKS_ZIP_MOVER_SCRIPTNAME = "hovertank_zip_mover"

struct
{
	#if SERVER
		                                
		                              
		                                                    
		                                    
		                                  

		                                                      
	#endif
	int numHoverTanksIntro = 0
	int numHoverTanksMid = 0

	#if CLIENT
		entity clientSideLeviathan1
		entity clientSideLeviathan2
		entity clientSideLeviathan3
		float lastLevAnimCycleChosen = -1.0
	#endif

} file

void function Canyonlands_MapInit_Common()
{
	printt( "Canyonlands_MapInit_Common" )

	FlagInit( "IntroHovertanksSet", false )

	PrecacheModel( LEVIATHAN_MODEL )
	PrecacheModel( FLYER_SWARM_MODEL )

                    
                              
       

	SetVictorySequencePlatformModel( $"mdl/rocks/victory_platform.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )

                         
		if ( Control_IsModeEnabled() )
		{
			SetVictorySequencePlatformModel( $"mdl/rocks/victory_platform_control.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )
			#if SERVER || CLIENT
				                                                     
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_A, [ <3047.53906, -18727.1953, 2618.70728>, <126.41423, -17895.6758, 2813.13867>, <-2166.80151, -21425.0293, 3244.57471>, <-2173.26196, -24773.0664, 2709.64111>, <19063.1953, -26453.6426, 3033.4397> ] )
				Control_SetHomeBaseBadPlacesForMRBForAlliance( ALLIANCE_B, [ <12111.5732, -22695.7227, 1924.55103>, <17170.1094, -23047.2754, 1744.65686>, <19063.1953, -26453.6426, 3033.4397> ] )
			#endif                    
		}
       

	file.numHoverTanksIntro = GetCurrentPlaylistVarInt( "hovertanks_count_intro", HOVER_TANKS_DEFAULT_COUNT_INTRO )
	#if SERVER
		                                                           
	#endif
	float chance = GetCurrentPlaylistVarFloat( "hovertanks_chance_intro", 1.0 ) * 100.0
	if ( RandomInt(100) > chance )
		file.numHoverTanksIntro = 0
	#if SERVER
		                                                                                              
	#endif

	file.numHoverTanksMid = GetCurrentPlaylistVarInt( "hovertanks_count_mid", HOVER_TANKS_DEFAULT_COUNT_MID )
	#if SERVER
		                                                       
	#endif
	chance = GetCurrentPlaylistVarFloat( "hovertanks_chance_mid", 0.33 ) * 100.0
	if ( RandomInt(100) > chance )
		file.numHoverTanksMid = 0
	#if SERVER
		                                                                                          
	#endif

	SupplyShip_Init()

	#if SERVER
		                             
			                                                                     

		                

		                             

		                                                                                                  

		                                
		                                              

		                            

		                                                                        

		                                              
		                                                      

		                                                                              
		                                                                                  

		                                
		                                  
		                                  

		                                        
			                                                                               

		                                                        
	#endif

	#if CLIENT
		                                                                                                    
		AddTargetNameCreateCallback( CANYONLANDS_LEVIATHAN1_NAME, OnLeviathanMarkerCreated )                                                                               
		AddTargetNameCreateCallback( CANYONLANDS_LEVIATHAN2_NAME, OnLeviathanMarkerCreated )
		AddTargetNameCreateCallback( CANYONLANDS_LEVIATHANBABY_NAME, OnLeviathanMarkerCreated )
		AddTargetNameCreateCallback( "leviathan_staging", OnLeviathanMarkerCreated )

		Freefall_SetPlaneHeight( 24000 )
		Freefall_SetDisplaySeaHeightForLevel( -956.0 )

		if ( file.numHoverTanksIntro > 0 || file.numHoverTanksMid > 0 )
			SetMapFeatureItem( 500, "#HOVER_TANK", "#HOVER_TANK_DESC", $"rui/hud/gametype_icons/survival/sur_hovertank_minimap" )

		if ( !IsPVEMode() )
			SetMapFeatureItem( 300, "#SUPPLY_DROP", "#SUPPLY_DROP_DESC", $"rui/hud/gametype_icons/survival/supply_drop" )

		if ( GetMapName() == "mp_rr_canyonlands_mu1_night" )
		{
			SetVictorySequenceLocation( <10472, 30000, 8500>, <0, 60, 0> )
			SetVictorySequenceSunSkyIntensity( 0.8, 0.0 )
		}
		else
		{
			SetVictorySequenceLocation( <11926.5957, -17612.0508, 11025.5176>, <0, 248.69014, 0> )
			SetVictorySequenceSunSkyIntensity( 1.3, 4.0 )

                          
			if (Control_IsModeEnabled())
				SetVictorySequenceEffectPackage( <11926.5957, -17612.0508, 11025.5176>, <0, 248.69014, 0>, $"P_podium_backdrop_FW_KCHU", "UI_InGame_Victory_Anniversary_Fireworks_Single", "UI_InGame_Victory_Anniversary_Fireworks", true )
         
		}

		SetMinimapBackgroundTileImage( $"overviews/mp_rr_canyonlands_bg" )

		RegisterMinimapPackage( "prop_script", eMinimapObject_prop_script.HOVERTANK, MINIMAP_OBJECT_RUI, MinimapPackage_HoverTank, FULLMAP_OBJECT_RUI, MinimapPackage_HoverTank )
		RegisterMinimapPackage( "prop_script", eMinimapObject_prop_script.HOVERTANK_DESTINATION, MINIMAP_OBJECT_RUI, MinimapPackage_HoverTankDestination, FULLMAP_OBJECT_RUI, MinimapPackage_HoverTankDestination )
	#endif
}

#if SERVER

                                   
 
	                                                                                            
	                                                                                            
	                                                                                               
	                                                                                    
 

                               
 
	                          
 

                                 
 
	                                  
	                 
	                                                           
		         
 

                                                             
 
                         
		                                                                                                                        
                               
	                                            
	                                                 
 

                                                                  
 
	                                  

	                                              
	                                              

	                                                        
	 
		                                                                            
		                                                                                                                   
		                       
		 
			                                                               
				                                                                                         
				                                                                              
				     

			                                                                    
				                                                                                                                 
				                                                             
				     

			                                                      
				                                                                                                              
				                                                             
				     

			                                                                
				                                                                                                              
				                                                                                                         
				     

			                                                     
				                                                                                                              
				                                                                                                         
				     


			                                                      
			        
				     
		 
	 

	                                                                                                               
	                                               
	                    

	                   

	                            

	        

	             
 

                                     
 
	                                           

	                                                                                                   
	                                                                                                                                

	                                                                  
	                                                                      

	                                                                                                  
	                                                                                            

	                                
 

                               
 
	                                                                                                          
	                                                                 
		      

	                                                                
		      

	                                                                                    
	                                                                                                                                                                                                                                                          

	                                                         
	                                                                  

	                                                
	 
		                                                         
		                             

		                                       
		 
			                                                   
			                                        
			                                   
		 
		    
		 
			                                                 
			                                      
		 
	 
 

                                    
 
	                                                                  
 

                                                           
 
	                              
		      

	                                             
	                                 
	                         
	 
		                                        
			        

		               
		     
	 

	                       
		      

	                             

	                          
	                                                        

	                                             
 

                                                                     
 
	                                  

	           

	                                                        

	                                                     

	                            
 

                                                  
 
	                           
	                       
	                                     
	                                 
	                                  
	                              
	                                
	                            
	                                 
	                                       
	 
		              
		          
	 
 

                                            
 
	                                   
		      

	                                            
 

                                                   
 
	                                  

	                                                                        
	 
		                     
		                                                                                                           
		                                                                         
	 
	                                                                             
	 
		                             
	 
	    
	 
		                          
		                                                                              
	 

	                               
 

                                                                                        
 
	                                 
		      

	                                                                                                                   
	 
		                                                                            
		        
		                                                                   
	 
 

       
                                      
 
	                                                                       
 
      

                                                                                          
 
	                                                                              
	                        
	                      
	                                               
	 
		                                                                                                             
		                                                                  
		                                      
	 
	                                                  
	 
		                                                                                                           
		                                                                
		                                    
	 
	    
	 
		               
	 

	                                                                                              

	                          
		      

	                                                   
	 
		                                                 

		                                                               

		                                                                                              
		                                                         

		                                        
		                                       
		                                              

		                                                    
		                                                                  
		                                                                   
	 
 

                                                         
 
	                                   

	                                   
	                                         
	                         
	                      

	                                                   

	                               
	 

		                                                                                      
		                                              
		           
	 

	                                                 
 

                                                        
 
	                                   
	                                      

	              
	 
		                                 
		                                  
	 
 

                                                               
 
	                                   
	                                      

	              
	 
		                                                                                     
		                                  
	 
 

                                                                                               
 
	                      
	                                               
		                                      
	                                                  
		                                    
	                                                                                        

	                                                   
	 
		                                                           
		                                                                                            
		                                                
	 
 

                                              
 
	                                  
	                                                        

	                                                     
		                                        

	                                                   
		                                        

	                                        
	 
		                                                
		                                                            
		                                         
		 
			                                                           
				                   
		 
	 
 

                                                                         
 
	                                                            
	                                                                                    
	                                                                         		               
	                                               
	                                        
	                                                                                                               
	                                      
	                                        		                

	                                                    
 

                                                                                           
 
	                                             
	                                                                                    
	                                                                                     		               
	                                                                                                       
	                                      
	                                                   		                
	                                                           

	                                                    

	                                                    
	  	                                                                                                                     
 

                                                                        
 
	                                                    
	 
		                                                                      
		                                                   
	 
 

                                                                                   
 
	                                   

	                                                     

	                                                
 

                                                                                 
 
	                                      
	 
		             
			                                          
		    
			                                    
	 
 

                         
                                     
     
                                       
      

                               		   
                              		   
                              		   

                             		   
                              		       
                                                                          
 
	                                                                     
	                         

	                                       
	 
		                                     
		                                   
	 

	                                                               
	                                         
	                     
	                                             
	 
		                                                
			        

		                                                           
		                   
	 

	                                           
	                                        

	                     
	 
		                                       
		                   	                                          
		                   	                                          
		                   	                                          
		                                                                                      
		                                                                   
		                                                                                      
		                                                              
		                                                                                      
		                                                                     
	 
	    
	 
		                                                              

		                                                       
			           

		                                   

		                                             

		                              
		 
			                              

			                     

			                                             
			                                        

			                                                                                                             
			                         

			                                                                                                

			                    
			 
				                            
				                                         
			 
		 

		                     
	 

	                                                

	                                                          
	 
		                                    
		                                                  

		                  
		                   

		                                                        

		                                                         
		 
			                                                                                                                                                
			                                          
			                                                                   
			                                                   
			 
				              
				              
			 
		 

		                       
		 
			                  
			                                                          
			                                                       
			                                                                                    
			                                                                                    
			                                       
		 
	 
 

                                                                                                         
 
	          

	                                                                              

	                                  
	                                      
	                                   

	                                           
	        
	                              
	                                 
	               
 

                                                                               
 
	                                        
 

                                                                       
 
	                          
	 
		                                                                               
		                               
		                      
		                    
		                 
	 

	                                                 
	                                                             			                                                                                     

	                                                                                                 
	                                                                               
	                               

	                                                                                       
	                              
	                                   
	 
		                        
		              
		                                   
	 

	                                                                  
	                                                                          
	                                         
	                                                       

	                                                 
	                                                                          
	 
		                                      
	 

	                                                                                                           
	                            
	 
		                                      
		                  

		                                                                          
		                                                             
		                     
			                                                                         		                
		    
			                                                                         		                
	 

	                                                                                                                        
	                                                         

	                                
		                       

	                                                                 
		                                             

	                                                                                                                                           
	                  
	                        
	                      
	                            

	                                                                       
	 
		                                     
			                                                                                                      

		                                            
		                         	                                                                     
		                                              

		                                                   
		 
			                               
			                               
			                     
			                     
		 
		                                                                    
		 
			                           
			                           
		 
	 

	                                                                                                                                                           
	                        		                                    
	                                                                                                                                                           
	                
		                  

	                                     
	 
		                                                                                                       
		                                                                                                             
		                                                                                                         
		                                                                                                         

		                                                                                                                                 
		                                                                                                                                                                           

		                                                                                          
		                                                                                          
		                                                                                                        
		                                                                                                                 

		                                                                                         
		                                                                                           
		                                                                                             
	 

	               
 


                                                                                                     
 
	                                                                                      
	                                                           

	                       
	                                      
		                                           

	                                                                                    
	 
		                                                              
		                                                        
		 
			                                                                                                                                                
				                             
		 
	 
	                             

	                                                                                                                           
	                                    
	                                                                                                                                       
	                                                                                                         
	 
		                                                                                                                                  
		                                                                                                     
	 
	                                                                                                                               
	                                                                            
	                                                        
	 
		                                                                                                       
			                             
	 

	                                          
	 
		                                                             
		                                                                                                                                   
		                                                                                                         
		 
			                                                                                                                                  
			                                                                                                     
		 
		                                                                                                                               
		                                                        
		 
			                                                                                                                            
				                             
		 
	 

	                                  
		                             

	                                       
	                           
	                                           
	 
		                                   
			     
		                            
	 
	                    
 

                                                                               
 
	                                   
	                                               

	                          
	                                    
	 
		                                                      
	 

	                                                 

	                                               
 

                                                
 
	                                                         
 

                                          
 
	                                          
 

                                                 
 
	                                                                                                                                              
	                                                                                                                                              
	                                                                                                                                              

	                                                  
	                                                                               
	                                
	                                    
	                          
	                     

	                                        
	 
		                                         

		                                      
		 
			                                     
			                                                                           
			 
				                                                                                                                                           
				                                                                                                
			 
			               
			                                         
			 
				                 
				           
			 
		 
	 
	                                                                                                                                              
	                                                                                                                                              
 

                 
                                      
 
	                                   

	                                                           
	                             
	                                        

	                                                  

	                                  
	 
		                                                                    
		                                                    
		                                                                                            
		                                                

		                                                             
		                                            

		                                                                                      
			           

		                                                                                        
			           
	 
 
      

                                      
 
	      
	                                       
	                            
	 
		                               
		 
			                               
			 
				                             
				                                        
				                          
				 
					                                            
					 
						                                                     
						                                
					 
				 
			 
			      
		 
	 
 

                       
 
	                                               
	                            
		      

	                     
	         
	             
	 
		                                                           
		                      
			     
		                         
		            
		                
		                       
		   
	 

	                         
		      

	                                                                                   

	                                  
	 
		            
		             
		                                                         

		                                   
		               

		                 
		                           
			     

		                                            
			                                                                         
	 

	                                            
		                                                                         

	                                                                                                   
	                                                                            
	                                               
	         
	                                              
	         
	                                                                             
	                                               
	         
	               
 

                                                               
 
	                                                      
	                                                 
	 
		                             
		                                          
	 
 
#endif

#if CLIENT

void function OnLeviathanMarkerCreated( entity marker )
{
	string markerTargetName = marker.GetTargetName()
	printt( "OnLeviathanMarkerCreated, targetName: " + markerTargetName  )
	#if DEV
		if ( IsValid( file.clientSideLeviathan1 ) && markerTargetName == CANYONLANDS_LEVIATHAN1_NAME )
		{
			printt( "Destroying clientSideLeviathan1 with markerName: " + markerTargetName  )
			file.clientSideLeviathan1.Destroy()
		}

		if ( IsValid( file.clientSideLeviathan2 ) && markerTargetName == CANYONLANDS_LEVIATHAN2_NAME )
		{
			printt( "Destroying clientSideLeviathan2 with markerName: " +  markerTargetName )
			file.clientSideLeviathan2.Destroy()
		}

		if ( IsValid( file.clientSideLeviathan3 ) && markerTargetName == CANYONLANDS_LEVIATHANBABY_NAME )
		{
			printt( "Destroying clientSideLeviathan3 with markerName: " +  markerTargetName )
			file.clientSideLeviathan3.Destroy()
		}

	#endif

	entity leviathan = CreateClientSidePropDynamic( marker.GetOrigin(), marker.GetAngles(), LEVIATHAN_MODEL )

	if ( markerTargetName == CANYONLANDS_LEVIATHAN1_NAME )
		file.clientSideLeviathan1 = leviathan
	else if ( markerTargetName == CANYONLANDS_LEVIATHAN2_NAME )
		file.clientSideLeviathan2 = leviathan
	else if ( markerTargetName ==  CANYONLANDS_LEVIATHANBABY_NAME )
	{
		file.clientSideLeviathan3 = leviathan
		file.clientSideLeviathan3.SetModelScale( 0.5 )
	}

	bool stagingOnly = markerTargetName == "leviathan_staging"
	if ( stagingOnly  )
		SetAnimateInStaticShadow( leviathan, false )
	else
		SetAnimateInStaticShadow( leviathan, true )

	thread LeviathanThink( marker, leviathan, stagingOnly )
}

void function LeviathanThink( entity marker, entity leviathan, bool stagingOnly )
{
	marker.EndSignal( "OnDestroy" )
	leviathan.EndSignal( "OnDestroy" )

	OnThreadEnd(
		function () : ( leviathan )
		{
			if ( IsValid( leviathan ) )
			{
				leviathan.Destroy()
			}
		}
	)

	leviathan.Anim_Play( "ACT_IDLE"  )

	                                                 
	const float CYCLE_BUFFER_DIST = 0.3
	Assert( CYCLE_BUFFER_DIST < 0.5, "Warning! Impossible to get second leviathan random animation cycle if cycle buffer distance is 0.5 or greater!" )

	float randCycle
	if ( file.lastLevAnimCycleChosen < 0 )
		randCycle = RandomFloat( 1.0 )
	else
	{
		                                                                                                    
		                                                                                                   
		float randomRoll = RandomFloat( 1.0 - ( CYCLE_BUFFER_DIST * 2 ) )
		float adjustedRandCycle = ( file.lastLevAnimCycleChosen + CYCLE_BUFFER_DIST + randomRoll ) % 1.0
		randCycle = adjustedRandCycle
	}

	file.lastLevAnimCycleChosen = randCycle

	leviathan.SetCycle( randCycle )
	WaitForever()

}

array<entity> function GetClientSideLeviathans()
{
	return [ file.clientSideLeviathan1, file.clientSideLeviathan2  ]
}

entity function GetClientSideLeviathan1()
{
	return file.clientSideLeviathan1

}

entity function GetClientSideLeviathan2()
{
	return file.clientSideLeviathan2

}
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
#if CLIENT

void function MinimapPackage_HoverTank( entity ent, var rui )
{
	if ( MINIMAP_DEBUG )
		printt( "Adding 'rui/hud/gametype_icons/survival/sur_hovertank_minimap' icon to minimap" )

	RuiSetImage( rui, "defaultIcon", $"rui/hud/gametype_icons/survival/sur_hovertank_minimap" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}


void function MinimapPackage_HoverTankDestination( entity ent, var rui )
{
	if ( MINIMAP_DEBUG )
		printt( "Adding 'rui/hud/gametype_icons/survival/sur_hovertank_minimap_destination' icon to minimap" )

	RuiSetImage( rui, "defaultIcon", $"rui/hud/gametype_icons/survival/sur_hovertank_minimap_destination" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}
#endif