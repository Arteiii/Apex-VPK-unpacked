global function TropicsWildlife_Init
global function TropicsWildlife_PreMapInit
global function IsTropicsWildlifeEnabled

#if DEV && SERVER
                                                    
                                                       
                                                     
                                                               
                                                                  
                                                      
                                                 
                                                  
                                                   
                                                  
                                                     
#endif                 

#if SERVER
                                                           
#endif

#if CLIENT
global function Wildlife_ServerToClient_SetWildlifeClientEnt
global function ServerCallback_CL_CampClearedNoMaterialRewards
#endif

#if DEV
const bool TROPICS_WILDLIFE_AI_DEBUG = false
#endif       

#if CLIENT
const asset PROWLER_PIT_CAMP_ICON = $"rui/hud/gametype_icons/survival/prowler_pit_icon"
const asset PROWLER_PIT_CAMP_ICON_SMALL = $"rui/hud/gametype_icons/survival/prowler_pit_small"

const asset PROWLER_CAMP_ICON = $"rui/hud/gametype_icons/survival/prowler_icon"
const asset PROWLER_CAMP_ICON_SMALL = $"rui/hud/gametype_icons/survival/ai_camp_small"

const asset SPIDER_CAMP_ICON = $"rui/hud/gametype_icons/survival/spider_icon"
const asset SPIDER_CAMP_ICON_SMALL = $"rui/hud/gametype_icons/survival/ai_camp_small"
const asset WILDLIFE_CAMP_SPAWNPOINT_ICON = $"rui/hud/gametype_icons/survival/wildlife_ai_camp"
#endif


#if CLIENT || SERVER
const string FUNCNAME_SetWildlifeClientEnt = "Wildlife_ServerToClient_SetWildlifeClientEnt"
const string FUNCNAME_PingWildlifeFromMap = "Wildlife_ClientToServer_PingWildlifeFromMap"
#endif


const string EDITOR_CLASS_CAMP_ROOT_KEYWORD = "info_ai_camp_node"
const string EDITOR_CLASS_CAMP_ASSAULT_RADIUS_KEYWORD = "info_ai_camp_assaultradius"
const string EDITOR_CLASS_CAMP_TREASURE_CHEST_KEYWORD = "info_ai_camp_treasurechest"

const string EDITOR_CLASS_PROWLER_SPAWNPOINT_KEYWORD = "info_ai_spawnpoint_prowler"
const string EDITOR_CLASS_SPIDER_SPAWNPOINT_KEYWORD = "info_ai_spawnpoint_spider"
                   
                                                                                   
      

const string EDITOR_CLASS_SPIDER_EGG_KEYWORD = "script_ai_spider_egg"
const string EDITOR_CLASS_PROWLER_DEN_KEYWORD = "script_ai_prowler_den"

const string SCRIPT_NAME_GOLIATH_PIT_KEYWORD = "goliath_pit"

const string WILDLIFE_SPAWNER_INFOENT_BASECLASS = "info_target"
const string WILDLIFE_CAMPNODE_INFOENT_BASECLASS = "script_ref"

const string PROWLER_RESET_ASSAULT_SIGNAL_KEYWORD = "OnResetProwlerAssaultRadius"
const string END_DEATHFIELD_MONITOR_SIGNAL_KEYWORD = "OnEndDeathFieldMonitor"
const string EXTERNAL_CAMP_MONITOR_SIGNAL_KEYWORD = "OnEndExternalCampMonitor"
const string CANCEL_SPAWNLOCK_MONITOR_SIGNAL_KEYWORD = "OnCancelSpawnLockMonitor"

const int MAX_SPIDERS_ALLOWED_ALIVE_IN_SPIDER_NEST = 12

global const int WILDLIFE_MAX_FLYER_COUNT = 54

const float WILDLIFE_ASSAULTPOINT_HEIGHT = 1750.0
const float WILDLIFE_ASSAULTPOINT_DEFAULT_RADIUS = 2048.0
const float PROWLER_DISENGAGE_DISTANCE = 3000.0

const float WILDLIFE_PROWLER_ASSAULTPOINT_EXTENDS_SCALE = 2.0

const float WILDLIFE_SMARTLOOT_CAMP_RADIUS_SCALAR = 1.25
const float WILDLIFE_SMARTLOOT_TEAM_RADIUS_LIMITER = 1024.0

const int AI_LIMIT = 190
const float REWARD_MESSAGE_DELAY = 1.5

#if SERVER
                          
 
	           
	           
 

                     
 
	                		       

	             
	             

	                           
 

                                         
 
	                               

	                      

	                

	             
	             

	                           
 

                       
 
	             
	                   

	                           
 

                        
 
	             
	             

	                       
	                           
 

                       
 
	                          

	                                       
	                                           
	                                             

	                       
	                             

	                            
	                              
	                              

	                                     

	                     
	                                                                                  

	                                                                                                          
	                                                                
	                         
	                                                                                    

	                      

	                                                                                                           
	                              
	                        
	                              

	                    

	                  

	                                                        

	      
	 
		                        
	        
 

                                                                           
 
	                        
	               
	             
 

                             
                                  

                                    
                                
                                    

                                      

                      

                               
                                   
                                 
                                    

                                           
                                        

                                           
                                                 
                                                   
                                           
                                                 
                                                  
                                             
                                          
                                         
                   
                                          
      

                                                       
                                                                
                                                                  
#endif          

#if CLIENT
struct WildlifeTrackingData
{
	entity rootEnt
	bool active
	int wildlifeType = -1             
}

struct{
	table < entity, WildlifeTrackingData > wildlifeEntStatuses
}file
#endif

void function TropicsWildlife_PreMapInit()
{
	AddCallback_OnNetworkRegistration( TropicsWildlife_OnNetworkRegistration )
}

void function TropicsWildlife_Init()
{
	#if DEV
		if ( TROPICS_WILDLIFE_AI_DEBUG )
			printf("TropicsWildlife_Init()")
	#endif

	if ( !IsTropicsWildlifeEnabled() )
	{
		#if DEV
			if ( TROPICS_WILDLIFE_AI_DEBUG )
				printf("TropicsWildlife_Init: Map AI disabled. (See: Playlist var wildlife_ai_enabled)")
		#endif
		return
	}

	TropicsWildlife_InitializeNPCandSkitDependencies()

	RegisterSignal( PROWLER_RESET_ASSAULT_SIGNAL_KEYWORD )
	RegisterSignal( END_DEATHFIELD_MONITOR_SIGNAL_KEYWORD )
	RegisterSignal( EXTERNAL_CAMP_MONITOR_SIGNAL_KEYWORD )
	RegisterSignal( CANCEL_SPAWNLOCK_MONITOR_SIGNAL_KEYWORD )
	
	PrecacheScriptString( SCRIPT_NAME_GOLIATH_PIT_KEYWORD )

	SpiderEgg_Init()

	#if SERVER
		                                                               
		                                                                                       

		                 
		                                                                  
		                                                                                         

		                                                                                      
		                                                                                                

		                                     
		 
			                                
		 

		                                                              

		                                                                                                                                
		                                                                                                                                              
		                                                                                                                                               
		                                                                                                                                                
		                                                                                                                                              
		                                                                                                
		                                                                                       
		                                                                                     
		                                                                                             
		                                                                                 
	#endif

	#if CLIENT
		RegisterMinimapPackage( "prop_script", eMinimapObject_prop_script.SPIDER_CAMP, MINIMAP_OBJECT_RUI, MinimapPackage_SpiderCamp, FULLMAP_OBJECT_RUI, FullmapPackage_SpiderCamp )
		RegisterMinimapPackage( "prop_script", eMinimapObject_prop_script.PROWLER_CAMP, MINIMAP_OBJECT_RUI, MinimapPackage_ProwlerCamp, FULLMAP_OBJECT_RUI, FullmapPackage_ProwlerCamp )
		SetMapFeatureItem( 1000, "#WILDLIFE_CAMP", "#WILDLIFE_CAMP_DESC", WILDLIFE_CAMP_SPAWNPOINT_ICON )

		if( Wildlife_PingFromMap_Enabled() )
			AddCallback_OnFindFullMapAimEntity( GetWildlifeUnderAim, PingWildlifeUnderAim )
	#endif
}

#if CLIENT||SERVER
bool function Wildlife_PingFromMap_Enabled()
{
	return GetCurrentPlaylistVarBool( "wildlife_pingfrommap_enabled", true )
}
#endif

void function TropicsWildlife_OnNetworkRegistration()
{
	#if DEV
		if ( TROPICS_WILDLIFE_AI_DEBUG )
			printf("TropicsWildlife_OnNetworkRegistration()")
	#endif

	#if SERVER || CLIENT
		if( Wildlife_PingFromMap_Enabled() )
		{
			Remote_RegisterServerFunction( FUNCNAME_PingWildlifeFromMap, "entity", "int", -1, INT_MAX  )
			Remote_RegisterClientFunction( FUNCNAME_SetWildlifeClientEnt, "entity", "bool", "int", -1, INT_MAX )
		}
	#endif

	Remote_RegisterClientFunction( "ServerCallback_CL_CampClearedNoMaterialRewards", "int", 0, eWildLifeCampType.Count - 1 )
}

#if CLIENT
void function MinimapPackage_SpiderCamp( entity ent, var rui )
{
	RuiSetImage( rui, "defaultIcon", SPIDER_CAMP_ICON )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )

	RuiSetBool( rui, "useTeamColor", false )

	RuiSetImage( rui, "smallIcon", SPIDER_CAMP_ICON_SMALL )
	RuiSetBool( rui, "hasSmallIcon", true )
}

void function FullmapPackage_SpiderCamp( entity ent, var rui )
{
	RuiSetImage( rui, "defaultIcon", SPIDER_CAMP_ICON )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )

	RuiSetBool( rui, "useTeamColor", false )

	RuiSetImage( rui, "smallIcon", SPIDER_CAMP_ICON_SMALL )
	RuiSetBool( rui, "hasSmallIcon", true )
}

void function MinimapPackage_ProwlerCamp( entity ent, var rui )
{
	asset prowlerIconName = PROWLER_CAMP_ICON
	asset smallProwlerIconName = PROWLER_CAMP_ICON_SMALL
	if ( ent.GetScriptName() == SCRIPT_NAME_GOLIATH_PIT_KEYWORD )
	{
		prowlerIconName = PROWLER_PIT_CAMP_ICON
		smallProwlerIconName = PROWLER_PIT_CAMP_ICON_SMALL
	}

	RuiSetImage( rui, "defaultIcon", prowlerIconName )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )

	RuiSetBool( rui, "useTeamColor", false )

	RuiSetImage( rui, "smallIcon", smallProwlerIconName )
	RuiSetBool( rui, "hasSmallIcon", true )
}

void function FullmapPackage_ProwlerCamp( entity ent, var rui )
{
	asset prowlerIconName = PROWLER_CAMP_ICON
	asset smallProwlerIconName = PROWLER_CAMP_ICON_SMALL
	if ( ent.GetScriptName() == SCRIPT_NAME_GOLIATH_PIT_KEYWORD )
	{
		prowlerIconName = PROWLER_PIT_CAMP_ICON
		smallProwlerIconName = PROWLER_PIT_CAMP_ICON_SMALL
	}

	RuiSetImage( rui, "defaultIcon", prowlerIconName )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )

	RuiSetBool( rui, "useTeamColor", false )

	RuiSetImage( rui, "smallIcon", smallProwlerIconName )
	RuiSetBool( rui, "hasSmallIcon", true )
}

void function ServerCallback_CL_CampClearedNoMaterialRewards( int campIndex )
{
	string msg = WILDLIFE_REWARD_STRINGS[ campIndex ]
	AnnouncementMessageRight( GetLocalClientPlayer(), msg, "", <214,214,214>, $"", 2, "UI_TropicsAI_AreaCompletionStinger" )
}
#endif

#if SERVER
                                                                                    
 
	                                  

	       
		                                
			                                                                                                              
	      
 

                                                                                            
 
	                                          

	       
		                                
			                                                                                                                      
	      
 

                                                                                              
 
	                                            

	       
		                                
			                                                                                                                        
	      
 

                                                                                              
 
	                                         

	       
		                                
			                                                                                                                     
	      
 

                                                                                                
 
	                                          

	       
		                                
			                                                                                                                      
	      
 

                                                
 
	                                    
	 
		                                     
		 
			                                                       
			 
				                                                                     
				 
					                                                               
					                  
					                        

					                                                                                                    
				 
			 
		 
	 
 

                                                  
 
	       
		                                
			                                                                   
	      

	                                
	                                                                  
	                                                                 
	                                                                    

	                                                                  
	 
		                                             
		 
			                                                                             
		 

		                                                      
		 
			                                                         
			 
				                                                       
				                                      
			 
		 
	 
 

                                                                                                 
 
	                                                                 

	                                   
	                                                                   
	                                                                                         
	                                                                                                    
	                                                                  
	 
		                                                                             
		                                                                                                                               
		                              
		 
			                                   
		                                                                                                                       
			                                            
		 
	 

	                                                                                 
 

                                                                                                                                      
 
	                                                                     
	                                                                    

	                                          
	                                         

	            
	 
		                                                                                                  

		                                                  
		 
			                                             
			 
				                     
				 
					                                                            
					                            
					                                       
					 
						                                          
						                                                            
						 
							                                                                              
						 
						        
					 

					                      
					                                    
					 
						        
					 

					                                                     
					                                                           
					 
						        
					 

					                                    
					                                     
					 
						                                                                             
						                         
					 
				 
			 
		 

		                                                                                                         
		 
			      
		 

		                            
	 
 

                                                                                                
 
	                                                                  
 

                                                                                                    
 
	                 
	 
		      
	 

	                                                                   
	                                                                                         
	                                                                                          
	                                                                  
	 
		                                                                             
		                                                            
		                              
		 
			                                   
		 
	 

	                                             
	                                    
	 
		                                                  
		 
			                                                                                                        
			 
				                                   
				     
			 
		 
	 

	                                                  
	 
		                                             
		 
			                     
			 
				             
			 
		 
		                           

		                                                     
		 
			                                                         
			 
				                                                     
				                                       
			 
		 
		    
		 
			                                                         
			 
				                                                       
				                                      
			 
		 

		                                      
		 
			                                      
			 
				                                              
			 
			                              
		 
		                          
		                         

		                                                       
		                                                       
		 
			                                                         
		 
	 

	                                                                                                    
 

                                               
 
	       
		                                
			                                           
	      

	                                                
	 
		                        
		                                               
		                                                                              
		                                             
		                                                                                         
		                                        
		                                     

		                                                        
		 
			                                              
			                      
			 
				                                              
					                        
					                                    
					                                                                   
					                          
					 
						                                                     
					 
					                              
					                                          
					                              
					                                     
					     
				                                              
					                         
					                                    
					                                    
					                                              
					                                      
					     
				                                             
					                      
					                              
					                                    
					                                    
					                                           
					                                      
					     
				                                            
					                      
					                                    
					                                    
					                                    
					                                           
					                                     
					     
                   
                                                 
                           
                                   
                                         
                                         
                                                
                                           
          
      
				                                     
					                        
					                                        
					                                                   
					                                    
					                                    
					                                       
					                                    
					                                                    
					                                             
					                                           
					                                               
					     
				                                      
					                        
					                                         
					                                                     
					                                    
					                                    
					                                 
					                                    
					                                                    
					                                             
					                                            
					                                                
					     
				        
					                                                                                                                                                               
			 
		 
	 

	                          

	                   

	                  

	                                                           
	                                                             
 

                                
 
	                                                
	 
		                  
	 
	                         

	                                                        
	 
		                      
	 
	                             

	                                                    
	 
		                    
	 
	                           

	                                                          
	 
		                       
	 
	                              
 

                                 
 
	                                                            
	 
		                                                                                     
		 
			                                                                                                                                                                                
		 

		                                                                                                                                                                                    
		                                             
		 
			                                                                                                                                                      
		 

		                                                     
		 
			                                                                                                                             
			                                                                                                                                        

		 
		                                                           
		 
			                                        
			                                    
			                                                             
			 
				                                          
				                                                                                                                         
				                                                                                                                                                                         
			        
				                                                                                                                                               
				                                                                                                          
				                                                                                                       
			 
		 
		                                                
		                                           

                    
                         
    
                                        
                                                                                                                   
          
                                       
                                                                                                                  
          
    
        

		       
			                                
			 
				                                   
				                                                
			 
			                             
				                             
				                                                                                    
				                           
				                                                                                   
			 
		      

		                                                                             
	 

	                          

	       
	                                
		                                                                                         
	      
 

                                       
 
	                          
	 
		      
	 

	                                                   
	 
		                                                  
		                                                                    
		                                             
		 
			                                             
			                         
			 
				                               
					                                                                                                                
					                                                 
					                                            
					     
				                                
					                                                                                                                  
					                                                 
					                                             
					     
			 
			       
				                                
					                                                                               
			      
		 
	 

	                          
 

                                        
 
	                                                         
	 
		      
	 

	                                                   
	 
		                                                  
		                                                                       
		                                
		 
			        
		 

		                                            
		                                                                                                        
		       
			                                
				                                                                                                                                                                                
		      
	 

	                              
 

                                                                 
 
	                                                       
	 
		           
	 

	                                                     
	                                                       
	 
		           
	 

	                                            
	 
		           
	 

	                         
	                                           
	 
		                                               
	 

	                                
	                                                                                                                                                                                    

	       
		                                
			                                                                                                                                                                                           
	      

	                                
	 
		                                                                                
	 

	             
 

                                                                                                         
 
	                                                    
	                                                        
 

                                                                                                          
 
	                                                       
	 
		           
	 

	                                                     
	                                                       
	 
		           
	 

	                                            
	 
		           
	 

	                         
	                                            
	 
		                                                
	 

	                                                                                                                                              

	       
		                                
			                                                                                                                                                                                            
	      

	                                             

	                                                             
	 
		                                                                        
	 

	                                
	 
		                                                                                 
	 

	              
 

                                                                                              
 
	                                            
	 
		                                                                 

		                                                                                                                                                          
		 
			                                                  
			 
				                                                          
				        
			 
			                                                                                                   
			                                                      
			 
				                                                                                         
				                                                                                                  
				                                                                              
				                                     
				 
					        
				 
			 
		 

		                                                                                                                                                           
		 
			        
		 
		                                                                                                           
		 
			        
		 
	 
	                                
 

                                                                                  
 
	                                                                       

	                                           
	                                        
	                                        

	                                                   
	 
		                                                          
	 

	                                                             
	 
		                              
	 

	                           

	                                                   
	 
		                                                           
	 

	                           

	                                                                   
	 
		                                                             
		                         
		                                               
		 
			                                                              
			                       
			 
				                                        
				     
			 
		 
	 
 

                                                                          
 
	                      
	                                                   
	                                                
	                                            
	 
		                       
		 
			        
		 

		                           
		                                   
		 
			        
		 
		                                                                             
		 
			                        
		 
		                             
		 
			           
		 
	 

	            
 

                                                                             
 
	                         
	                                           
	 
		                                               

		                                                                                  
		                                                            
		 
			                               
			                                                                             
			                        
		 
		                                                                
		 
			                                 
			                                                                               
			                          
		 
	 
	                            
 

                                                                      
 
	                                           
	                                                   
	 
		                                                        
	 
	                  
 

                                                                        
 
	                                                             
	 
		      
	 

	       
		                                
			                                                                                    
	      

	                                                        
	                                                     
	 
		                                        
		 
			                                                                      
		 
	 
	                                         
	 
		                                                                                                
		                                                     
		 
			                                                                     
		 
		                                          
	 

	                                                                              
 

                                                                                                       
 
	                                                          

	            
		               
		 
			       
				                                
					                                                                   
			      
		 
	 
	       
		                                
			                                                                  
	      

	         

	                                                                     
 

                                                                                                      
 
	                                                           

	       
		                                
			                                                                                       
	      

	         

	                                                     
	 
		                                                                                    
	 

	                                         

	       
		                                
			                                                                                                 
	      
 

                                                                                 
 
	                                                                            
	 
		                                             
		                                                         
	 
 

                                                                                                         
                                                                                                                  
                                                                           
 
	                                      

	                            
	            
 

                                       
 
	                                                        
	             
	                      

	         
 

                                                  
 
	                                        
	                               
 

                                                  
 
	                                     

	                                        

	       
		                                
			                                                                      
	      

	                                                    
	                                 
	 
		           
	 

	       
		                                
			                                                                   
	      

	                                                                                                                                                           
	                                                   
	 
		       
			                                
				                                                                                                                                                                     
		      

		                                                  
		                                   
		 
			                                                              
			                       
			                                                    
			 
				                                            
				 
					     
				 

				                                                     
				 
					     
				 

				                                            
				 
					     
				 

				                                                                                                                    

				       
					                                
						                                                                                                                                                                            
				      
			 

			                       
			                                                                                                                    
			                                                             
			 
				                                                         
			 
			                                        
			                                                                                                                                                                     
			                                    
			                                      
			 
				                                        
			 
			                                              
			                               

			                                          
			                        
		        
			                        
			 
				                                   
					                                                           
					 
						                                                                        
						                                       
					 
					     
				                                    
					                                                           
					 
						                                                                          
						                                      
					 
					     
			 
		 
	 

	                                     

	                                                   
	 
		                                       
	 
	                                 

	       
		                                
			                                                   
	      
 

                                           
 
	                              

	                       
	                       
 

                                                                 
 
	                
	                         
 

                                                                                                                                                      
 
	                                                                    
	                         

	                               
	 
		                                                  
		                                                             
		 
			                                           
		 
		    
		 
			                             
		 

		                                         
		                                                                                         

		                                                                                                          
		 
			                                                         
		   
		                                                                              
		 
			                                                                              
		   
		                               

                                   
                                                                     
                                    
                                                                 
                                         
	 
	                

	       
		                                
			                                                                                                                                                                                                                      
	      

	          
 

                                          
 
	                                           
	 
		                                                                                                                                     
		                                                                                                               
		            
	 

	           
 

                                                                   
 
	                                                  

	                                                                 

	                
	                    
	                                    
	                                                            
	                                              
	                              

	                                                               

	                              
	 
		                    
		 
			                                                         
			                                                                                                  
			                               
		 
	 

	                                   

                          
		                                            
       

	               
 

                                                                                               
 
	                                                                                                           
			                                                                          
		            

	           
 

                                                                                  
 
	                        

	                                                 

	                                        
	                                                                                               
	                                                                                                   
	                                                                                               
	                                                                                                      
	                                                                                                                                                                                                                               
	                                                                                                                                                                                          
	                                                                                                                                                                                                
	                                                          
	                                            
	                                              
	                                                
	                                           

	             
 

                                                                                                                
 
	                                                      

	                
	                                            

	                                                                           
	                                                 
	 
		                                                                                                                                                          
	 

	                                                       
	 
		      
	 

	                        

	       
		                                
			                                                                                                                                                      
	      

	                                                                                                  

	                                                                                                     
	                                                   
	 
		                                                                     
		 
			                                                                                    
			                                                                                                                 
		 
	 

	                                                      
	 
		                                     
		                                                                         
			                                           
			                             
			 
				                                                 
			 
		 
		                                                                        
		                                                    
			                                                                                     
			                                                              

			                                                  
			 
				                                                                                                    
				 
					            
				 
			 

			                                         
			                                            
			                                                           
			 
				                                                                          
				                       
				 
					                                         
					 
						                                     
					        
						                                        
						                                               
						 
							     
						 
					 
				 
			 

			                                                                                  
			 
				                                                        
				                                        
				                                                
			 

			                                                        
			 
				                                                          
			 
		 

		                                                                         
		                                         

		                                                  
		 
			                                                                                     
			                         
			 
				                        
					                                                                                                                                                                                                      
					     
				                  
					                                                                                                                                                                                                
					     
			 
		 
	 

	                            
	                                                                    
	 
		               
		                              
		                                                      
		 
			                                                                                                                         
		        
			                                                                                       
			                        
		 

		                       
		                                      
		 
			                                      
			 
				                                              
			 
			                              
		 
		                         
		                                                       
		                                                       
		 
			                                                         
		 

		                            
		                     
		                                                                                                                
		 
			                                
		        
			                                                                                               
		 

		                                       
		                                    
		 
			                                                                                                                                                      
			 
				                                     
			 
		 

		                           
		 
			                                                                                                                      
		 
		    
		 
			                                                                                           
		 

		                                                   
		                                                      
		 
			                                              
			 
				                                                         
			 
		 

		                                                  
		 
			                        
			 
				                                   
					                                                                                                            
					     
				                                    
					                                                                                                             
					     
			 
		 

	 
 

                                                                                                   
 
	                         
	                                    
	 
		                                                   
		 
			                                                                                                    
		 
	 
 

                                                                                                                                                              
 
	                                           
	                   

	                          

	                                               

	                            
	 
		                                                      
	 

	                        
	              
	 
		                                                                                                                                      
		                                                                                                              
		                  
	 
 

                                                                                                                                                                                                
 
	       
		                                
			                                                                   
	      

	                                           
	                   

	                      
		      

	                                      
		                                          

	            
		                                  
		 
			                      
				      

			                                                       
				      

			                                
		 
	 

	                               
	                                                     
	                                                
	                                                                   
	                  
	 
		                                                     
	 
	    
	 
		                                               
	 
	                                        
	                                                        

	             
 

                                                                                                                                                             
 
	       
		                                
			                                                                     
	      

	                                           
	                   

	                                    
		                                                                

	                                    
	 
		                                

		                                                     
		                                                                                              
		                                                                                                          
		 
			        
		 

		                              
	 
 

                                      
 
	       
		                                
			                                                    
	      

	                                                                                 
	 
		                      
	 

	                                                                                   
	 
		                       
	 
 

                                         
 
	       
		                                
			                                                       
	      

	                                                   
	 
		                                                      
		                          
		 
			                  
		 
	 

	                               
 

                                                                     
 
	                                                            
	 
		                                                                                          
		 
			               
		 
	 

	           
 

                                 
 
	       
		                                
			                                               
	      

	                                                   
	 
		                                                                       
		                                             
		                                           
	 
 

                                                                                   
 
	                                                                             
	 
		                                                                         
	 
	    
	 
		                                                                                                
		                                                                                                
		                                                            
		                                                 
		                                              
	 
 
#endif          

bool function IsTropicsWildlifeEnabled()
{
	return GetCurrentPlaylistVarBool( "wildlife_ai_enabled", true )
}

void function TropicsWildlife_InitializeNPCandSkitDependencies()
{
	FreelanceNPCs_Init()
	SkitSystem_Init()
	#if SERVER
		                                      
	#endif
}

#if DEV && SERVER
                                                                   
 
	                         
	 
		      
	 

	                                                                      
	                   
	 
		      
	 

	                               
	                                     
	                                                                 
	                                                                                                           
	                                                       
	                                                           
	                                                                       
	                                                                                                                                                                                            
	                                                                               
	                                                                         
	                                                                             
 

                                                       
 
	                                     
	                                                                  
	                                                                      
	                                                                                                              
	                                                                     
	                                                                               
	                                                                    
	                                                                                                            
	                                                                   
	                                                                             
                   
                                                                      
      
 

                                                             
 
	             
	                                         
	 
		                                 
	 
	            
 

                                             
                                                               
 
	                                               
	 
		                                        
	        
		                                       
		                      
		 
			          
			 
				           
				                                        
				 
					     
				 

				                                                            
				 
					                                            
					                                           
					                                                                                                                                                       
						                                                     
					                                                            
				 
			 
		   
	 
 

                                                
                                                                  
 
	                                                  
	 
		                                           
	        
		                                          
		                      
		 
			          
			 
				           
				                                           
				 
					     
				 

				                                                            
				 
					                                                                                                
				 
			 
		   
	 
 

                                                     
 
	                                     
	                                                                                                 
	                                                  
	                                                                                                   
 

                                                      
 
	                                       
	 
		                                                         
		                                
		                                      
	        
		                                                        
		                               
		                                      
	 
 

                                                   
 
	                                                       

	                                                    
	 
		                                                  
		                                 
		                                      
		 
			                                      
			 
				                                              
			 
			                              
		 
		                         
	 

	                      
	                                                     
	                                                                                 
	 
		                        
	 
	                                 

	                       
	                                                     
	                                                                                   
	 
		                         
	 
	                                  

	                                 

	                           

	                                                      
	                                                    
 

                                                          
 
	                   

	                                                     
	                                  
	 
		                                                 
		                                                                   
		                                                     
		 
			           
		 
		                                
	        
		                                                                                                                   
	 
 

                                                  
 
	                                                   
	                                     
	 
		                   
		                          
		 
			                        
		 
		    
		 
			                         
		 
		                          
		                                                           
		                                                             
	 
	    
	 
		                                                                                                                                   
	 
 

                                                                                                                                                               
 
	                                                       

	                                                     

	                                                      
 

                                                            
 
	                   

	                                                       
	                           
	                                    
 

                                                                     
 
	                                                                                                                   
 

                                                                      
 
	                                                                                                     
 

                                                                                                                                                                  
 
	                                     
	                                    
	                                                                                                                                    
	                         
	 
		                                                                                     
		      
	 

	                                            
	 
		      
	 

	                                         
	 
		                                                                                  
		                    
	 
 
#endif                 

#if CLIENT
void function Wildlife_ServerToClient_SetWildlifeClientEnt( entity targetEnt, bool active, int campType )
{
	printf("Wildlife attempting to set")
	if ( IsValid( targetEnt ) )
	{
		WildlifeTrackingData newWildlifeData
		newWildlifeData.rootEnt = targetEnt
		newWildlifeData.active = active
		newWildlifeData.wildlifeType = campType

		file.wildlifeEntStatuses[targetEnt] <- newWildlifeData
		printf("Wildlife Root Set: " + targetEnt)
	}
}
#endif          

#if CLIENT
entity function GetWildlifeUnderAim( vector worldPos, float worldRange )
{
	float closestDistSqr        = FLT_MAX
	float worldRangeSqr = worldRange * worldRange
	entity closestEnt = null

	if( MapPing_Modify_DistanceCheck_Enabled() )
	{
		float modifier = MapPing_DistanceCheck_GetModifier()

		if( worldRange >= MapPing_DistanceCheck_GetDistanceRange() )
			modifier *= 0.5

		worldRangeSqr = ( worldRange * modifier ) * ( worldRange * modifier )
	}

	foreach( entity spawnEnt, WildlifeTrackingData wildlifeData in file.wildlifeEntStatuses )
	{
		if ( !IsValid( spawnEnt ) )
			continue

		if( !file.wildlifeEntStatuses[spawnEnt].active )
			continue

		vector wildlifeOrigin = spawnEnt.GetOrigin()

		float distSqr = Distance2DSqr( wildlifeOrigin, worldPos )
		if ( distSqr < worldRangeSqr && distSqr < closestDistSqr  )
		{
			closestDistSqr = distSqr
			closestEnt     = spawnEnt
		}
	}

	if ( !IsValid( closestEnt ) )
	{
		return null
	}

	                   
	return closestEnt
}

bool function PingWildlifeUnderAim( entity targetEnt )
{
	entity player = GetLocalClientPlayer()

	if ( !IsValid( player ) || !IsAlive( player ) )
		return false

	if ( !IsPingEnabledForPlayer( player ) )
		return false

	if( !IsValid( targetEnt ) )
		return false

	int pingType

	if( file.wildlifeEntStatuses[targetEnt].wildlifeType == eWildLifeCampType.PROWLER_DENS )                          
		pingType = ePingType.PING_PROWLER_DEN

	if( file.wildlifeEntStatuses[targetEnt].wildlifeType == eWildLifeCampType.SPIDER_NEST )
		pingType = ePingType.PING_SPIDER_EGGS

	if( Wildlife_PingFromMap_Enabled() )
		Remote_ServerCallFunction( FUNCNAME_PingWildlifeFromMap, targetEnt, pingType )

	EmitSoundOnEntity( GetLocalViewPlayer(), PING_SOUND_LOCAL_CONFIRM )

	return true
}
#endif


#if SERVER
                                                                                                          
 
	                                                
	 
		                                                                                                                                          
	 
 
#endif