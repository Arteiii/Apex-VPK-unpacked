global function CodeCallback_PreMapInit
global function ClientCodeCallback_MapInit
global function MinimapLabelsCanyonlandsMU3

struct
{
}
file

void function CodeCallback_PreMapInit()
{
	CryptoTT_PreMapInit()
}

void function ClientCodeCallback_MapInit()
{
	Canyonlands_MapInit_Common()

	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_hu.rpak" )
	MinimapLabelsCanyonlandsMU3()
	AddCallback_GameStateEnter( eGameState.WinnerDetermined, MU1_OnWinnerDetermined )
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
	ClCommonStoryEvents_Init()
	ClCanyonLandsCausticLore_Init()

	ClCryptoTVsInit()
	RegisterCLCryptoCallbacks()
}

void function EntitiesDidLoad()
{
	InitCryptoMap()
}

void function MinimapLabelsCanyonlandsMU3()
{
	           
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_02_A" ) ), 0.93, 0.5, 0.6 )         

	            
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_04_A" ) ), 0.79, 0.62, 0.6 )            
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_11_A" ) ), 0.56, 0.91, 0.6 )                    
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_14_RUNOFF" ) ), 0.13, 0.40, 0.6 )         

	        
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_13_ARENA" ) ), 0.26, 0.35, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_18_A" ) ), 0.16, 0.7, 0.6 )            
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_03_B" ) ), 0.81, 0.51, 0.6 )       

	          
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_04_B" ) ), 0.78, 0.74, 0.6 )           
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_08_ARTILLERY" ) ), 0.54, 0.15, 0.6 )            
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_15_AIRBASE" ) ), 0.13, 0.56, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "JCT_10_13" ) ), 0.34, 0.45, 0.6 )              

	        
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_01_A" ) ), 0.81, 0.22, 0.6 )                           

	      
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_19_A" ) ), 0.92, 0.27, 0.6 )          
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_01_B" ) ), 0.75, 0.37, 0.6 )            
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_07_C" ) ), 0.76, 0.84, 0.6 )             

	        
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_09_A" ) ), 0.4, 0.3, 0.6 )                
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_06_A" ) ), 0.66, 0.53, 0.6 )             

	      
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_16_MALL" ) ), 0.49, 0.68, 0.6 )           
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_16_RIG" ) ), 0.35, 0.73, 0.6 )          
	
	      
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_19_E" ) ), 0.4, 0.10, 0.6 )               
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_12_A" ) ), 0.25, 0.24, 0.6 )                
}

void function MU1_OnWinnerDetermined()
{
	array<entity> portalFXArray = GetEntArrayByScriptName( "wraith_tt_portal_fx" )

	if ( portalFXArray.len() == 0 )
	{
		Warning( "Warning! Incorrect number of portal FX entities found for destruction!" )
		return
	}

	foreach( entity fx in portalFXArray )
		fx.Destroy()
}