global function ClientCodeCallback_MapInit

const asset MOON_CORE_VFX = $"P_env_KineticBattery_top_elec"
const asset MOON_CABLE_VFX = $"P_env_KineticBattery_cables_shrt"


void function ClientCodeCallback_MapInit()
{
	ClLaserMesh_Init()

	DividedMoon_MapInit_Common()

	                   
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_6_ATMOSTATION", 0.63, 0.86, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_13_BIONOMICS", 0.86, 0.79, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_4_THE_FOUNDRY", 0.2, 0.86, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_12_TERRAFORMER", 0.64, 0.68, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_3_PRODUCTION_YARD", 0.12, 0.58, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_14_THE_DIVIDE", 0.9, 0.5, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_11_N_PROMENADE", 0.5, 0.47, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_7_S_PROMENADE", 0.41, 0.58, 0.5 )	
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_15_ETERNAL_GARDENS", 0.81, 0.37, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_8_THE_CORE", 0.35, 0.3, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_2_DRY_GULCH", 0.18, 0.36, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_9_ALPHA_BASE", 0.57, 0.18, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_16_BACKUP_ATMO", 0.85, 0.15, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_1_BREAKER_WHARF", 0.1, 0.15, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_10_STASIS_ARRAY", 0.6, 0.33, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#MOON_ZONE_5_CULTIVATION", 0.38, 0.80, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_MIRAGE_BOAT", 0.86, 0.55, 0.5)

	PrecacheParticleSystem( MOON_CABLE_VFX )
	PrecacheParticleSystem( MOON_CORE_VFX )

	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
}

void function EntitiesDidLoad()
{
	array< entity > ents =  GetEntArrayByScriptName( "kb_cables_shrt_01_info_node" )
	if ( ents.len() == 1 )
	{
		thread CableFXNodeThread( ents[0], ents[0].GetOrigin(), <-17470.87, 18007.68,  3322.34> )
	}

	ents =  GetEntArrayByScriptName( "kb_cables_shrt_02_info_node" )
	if (  ents.len() == 1 )
	{
		thread CableFXNodeThread( ents[0], < -10158.26, 19460.14, 3703.56 >, <-8121.13, 20013.76, 3045.25> )
	}

	ents =  GetEntArrayByScriptName( "kb_top_elec_info_node" )
	if ( ents.len() == 1 )
	{
		thread TopElecNodeFXThread( ents[0] )
	}
}

void function TopElecNodeFXThread( entity node)
{
	int effectHandle = -1

	OnThreadEnd(
		function() : ( effectHandle )
		{
			if ( EffectDoesExist( effectHandle ) )
				EffectStop( effectHandle, true, false )
		}
	)

	while ( true )
	{
		EmitSoundOnEntity( node, "DividedMoon_PerpetualCore_Emit_CoreElectricity"  )
		effectHandle = StartParticleEffectOnEntity( node, GetParticleSystemIndex( MOON_CORE_VFX ), FX_PATTACH_ABSORIGIN_FOLLOW, ATTACHMENTID_INVALID )
		wait RandomFloatRange( 2.1, 12 )

		if ( EffectDoesExist( effectHandle ) )
			EffectStop( effectHandle, true, false )
	}
}

void function CableFXNodeThread( entity node, vector ambientStart, vector ambientStop  )
{
	entity mover = CreateClientsideScriptMover( $"mdl/dev/empty_model.rmdl", ambientStart, <0, 0, 0> )
	entity ambientGeneric = CreateClientSideAmbientGeneric( mover.GetOrigin(), "DividedMoon_PerpetualCore_Emit_WiresElectricity", 0 )
	ambientGeneric.SetParent( mover )
	ambientGeneric.SetEnabled( false )

	int effectHandle = -1

	OnThreadEnd(
		function() : ( mover, ambientGeneric, effectHandle )
		{
			if ( IsValid (ambientGeneric ) )
			{
				ambientGeneric.ClearParent()
				ambientGeneric.Destroy()
			}

			if ( IsValid (mover ) )
			{
				mover.Destroy()
			}

			if ( EffectDoesExist( effectHandle ) )
				EffectStop( effectHandle, true, false )
		}
	)

	while ( true )
	{
		effectHandle = StartParticleEffectOnEntity( node, GetParticleSystemIndex( MOON_CABLE_VFX ), FX_PATTACH_ABSORIGIN_FOLLOW, ATTACHMENTID_INVALID )
		mover.NonPhysicsMoveTo( ambientStop, 1.0, 0.0, 0.0 )
		ambientGeneric.SetEnabled( true )

		wait 2.0

		mover.NonPhysicsStop()
		mover.SetOrigin( ambientStart )
		ambientGeneric.SetEnabled( false )

		if ( EffectDoesExist( effectHandle ) )
			EffectStop( effectHandle, true, false )

		wait RandomFloatRange( 0.1, 10 )
	}
}
