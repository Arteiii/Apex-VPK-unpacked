global function CodeCallback_PreMapInit
global function ClientCodeCallback_MapInit
global function MinimapLabelsOlympus

void function CodeCallback_PreMapInit()
{
	PathTT_PreMapInit()

                    
		MedBay_PreMapInit()
		LifelineTT_PreMapInit()
       
}


void function ClientCodeCallback_MapInit()
{
	Olympus_MapInit_Common()
	MinimapLabelsOlympus()
	ClCommonStoryEvents_Init()
	ClOlympusStoryEvents_Init()
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )

	PathTT_MapInit()

                    
		MedBay_MapInit()
		LifelineTT_MapInit()
       
}


void function EntitiesDidLoad()
{
}


void function MinimapLabelsOlympus()
{
	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_olympus_mu2.rpak" )

	                
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_DOWNTOWN", 0.54, 0.90, 0.6 )           
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_RND_SHORT", 0.80, 0.72, 0.6 )      
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_SOLARWAVE", 0.61, 0.73, 0.6 )             
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_INFECTION", 0.68, 0.85, 0.6 )             
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_LABS", 0.51, 0.55, 0.6 )       
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_GARDENS_SHORT", 0.78, 0.44, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_UNDERBELLY", 0.60, 0.44, 0.6)             
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_TURBINE_SHORT", 0.44, 0.41, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_ESTATES_SHORT", 0.32, 0.53, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_MARINA", 0.09, 0.63, 0.6 )         
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_HYDROPONICS", 0.19, 0.71, 0.6 )              
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_OASIS_SHORT", 0.23, 0.39, 0.6 )            
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_SHIP_SHORT", 0.28, 0.27, 0.6 )       
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_GRID_SHORT", 0.51, 0.295, 0.6 )             
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_RIFT_SHORT", 0.65, 0.26, 0.6 )       
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_GROWTOWERS", 0.78, 0.56, 0.6 )              
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_DOCKS", 0.37, 0.20, 0.6 )        
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_RING_SHORT", 0.4, 0.33, 0.6 )              
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_PHASEDRIVER", 0.385, 0.78, 0.6 )               
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_TERMINAL_SHORT", 0.455, 0.65, 0.6 )                 
	SURVIVAL_AddMinimapLevelLabel( "#MAPZONE_ZONE_LIFELINE_CLINIC_SHORT", 0.9, 0.43, 0.6 )         


	                                  
	                                                                                                                                          
	                                                                                                                                     
	                                                                                                                                            
	                                                                                                                                            
	                                                                                                                                      
	                                                                                                                                         
	                                                                                                                                            
	                                                                                                                                         
	                                                                                                                                        
	                                                                                                                                        
	                                                                                                                                             
	                                                                                                                                           
	                                                                                                                                      
	                                                                                                                                              
	                                                                                                                                      
	                                                                                                                                             
	                                                                                                                                       
	                                                                                                                                            
	                                                                                                                                               
	                                                                                                                                                 
}