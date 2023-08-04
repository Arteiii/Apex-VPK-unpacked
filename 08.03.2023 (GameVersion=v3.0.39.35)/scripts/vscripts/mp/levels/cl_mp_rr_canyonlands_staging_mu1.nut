global function ClientCodeCallback_MapInit

void function ClientCodeCallback_MapInit()
{
	Canyonlands_MapInit_Common()
	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_staging_mu1.rpak" )

                    
		SurvivalCommentary_SetHost( eSurvivalHostType.COMBATRANGE )
       
}
