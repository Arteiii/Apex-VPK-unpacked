global function ClientCodeCallback_MapInit

void function ClientCodeCallback_MapInit()
{
	ClLaserMesh_Init()

	Tropics_MapInit_Common()

                      
	if ( SpectreShacksAreEnabled() )
	{
		SpectreShacks_Bootstrap()
	}
      

	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_7_LIGHTNING_ROD", 0.87, 0.16, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_7_HIGHPOINT", 0.75, 0.11, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_8_THUNDERWATCH", 0.79, 0.26, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_6_COMMANDCENTER", 0.64, 0.30, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_2_CHECKPOINT", 0.31, 0.31, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_2_NORTHPAD", 0.26, 0.16, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_6_WALL", 0.51, 0.15, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_12_BAROMETER", 0.35, 0.73, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_11_CENOTE", 0.17, 0.70, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_1_MILL", 0.15, 0.47, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_4_CASCADE", 0.51, 0.38, 0.5 )
    SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_1_DOWNED_BEAST", 0.11, 0.29, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_16_LAUNCHPAD", 0.77, 0.63, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_1_FISH_FARMS", 0.78, 0.86, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_MIRAGE_BOAT",  0.88, 0.81, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_10_ANTENNA", 0.58, 0.69, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_15_SHIPFALL", 0.49, 0.90, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_15_GALESTATION", 0.65, 0.82, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#TRO_ZONE_8_STORMCATCHER", 0.74, 0.42, 0.5 )
}
