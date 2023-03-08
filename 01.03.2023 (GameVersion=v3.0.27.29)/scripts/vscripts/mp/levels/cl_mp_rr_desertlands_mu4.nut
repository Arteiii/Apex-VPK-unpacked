global function CodeCallback_PreMapInit
global function ClientCodeCallback_MapInit

const string WAYPOINTTYPE_SILO_DOORS = "desertlands_silo_doors_waypoint"
const string SILO_DOOR_LEFT_SCRIPTNAME = "silo_door_left"
const string SILO_DOOR_RIGHT_SCRIPTNAME = "silo_door_right"
const string SILO_PLATFORM_SCRIPTNAME = "silo_rising_platform"

              
const string LAVA_SIPHON_SHORT_SFX = "Desertlands_Mu3_Zone13_FireVents_Small"
const string LAVA_SIPHON_LONG_SFX = "Desertlands_Mu3_Zone13_FireVents_Large"
const string LAVA_SIPHON_FX_SCRIPTNAME = "lava_siphon_fx_ref"

const float LAVA_SIPHON_FLOAT_MIN = 2.0
const float LAVA_SIPHON_FLOAT_MAX = 5.0
const float LAVA_SIPHON_FLOAT_CLEANUP = 10.0

const asset LAVA_SIPHON_SHORT_FX = $"P_rf_flames_towertop_burst"
const asset LAVA_SIPHON_LONG_FX = $"P_rf_flames_towertop_burst_02"

             
const string CLIMATIZER_LARGE_TOWER_INSTANCE_NAME = "climatizer_largetower_"
const string CLIMATIZER_LARGE_FX_SCRIPTNAME = "climatizer_fx_large_ref"
const string CLIMATIZER_SMALL_TOWER_INSTANCE_NAME = "climatizer_smalltower_"
const string CLIMATIZER_SMALL_FX_SCRIPTNAME = "climatizer_fx_small_ref"

const string CLIMATIZER_BURST_SMALL_SFX = "Desertlands_Mu3_Zone04_Emit_Climatizer_Cannons_Bursts_Small"
const string CLIMATIZER_BURST_LARGE_SFX = "Desertlands_Mu3_Zone04_Emit_Climatizer_Cannons_Bursts_Large"

const asset CLIMATIZER_BURST_LARGE_FX = $"P_climatizer_stm_vent_burst_lrg"
const asset CLIMATIZER_BURST_SMALL_FX = $"P_climatizer_stm_vent_burst"

const float CLIMATIZER_WAIT_LONG = 10.0
const float CLIMATIZER_WAIT_SHORT = 7.0

const int CLIMATIZER_FIRST_LARGE_TOWER = 0
const int CLIMATIZER_SECOND_LARGE_TOWER = 1

const int CLIMATIZER_FIRST_EAST_TOWER = 0
const int CLIMATIZER_LAST_EAST_TOWER = 4
const int CLIMATIZER_FIRST_WEST_TOWER = 5
const int CLIMATIZER_LAST_WEST_TOWER = 9

struct LavaSiphonFXData
{
	asset 	fxAsset
	string 	sfxString
}

const LavaSiphonFXData LAVA_SIPHON_SHORT_BURST_DATA =
{
	fxAsset = LAVA_SIPHON_SHORT_FX
	sfxString = LAVA_SIPHON_SHORT_SFX
}

const LavaSiphonFXData LAVA_SIPHON_LONG_BURST_DATA =
{
	fxAsset = LAVA_SIPHON_LONG_FX
	sfxString = LAVA_SIPHON_LONG_SFX
}

struct ClimatizerSmallTowerData
{
	int 	smallTowerFX
	vector 	smallTowerVec
}

struct ClimatizerLargeTowerData
{
	array< int > 	fxArray
	vector 			largeTowerVec
}

struct
{
	array< LavaSiphonFXData >	lavaSiphonFXDatas = [ LAVA_SIPHON_SHORT_BURST_DATA, LAVA_SIPHON_LONG_BURST_DATA ]
	array < entity > 			lavaSiphonFXEntArray

	table< int, ClimatizerLargeTowerData  >		climatizerLargeTowers
	table< int, ClimatizerSmallTowerData >		climatizerSmallTowers
}file

void function CodeCallback_PreMapInit()
{
	Desertlands_PreMapInit_Common()
}

void function ClientCodeCallback_MapInit()
{
	DesertlandsTrainAnnouncer_Init()
	ClLaserMesh_Init()
	Desertlands_MapInit_Common()
	DesertlandsStoryEvents_Init()
	ClCommonStoryEvents_Init()
	ShPrecacheEvacShipAssets()
	ShPrecacheBreachAndClearAssets()
	ShPrecacheTreasureExtractionAssets()

	Waypoints_RegisterCustomType( WAYPOINTTYPE_SILO_DOORS, InstanceSiloDoorsActivatedWP )

	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_desertlands_mu4.rpak")

	AddCallback_EntitiesDidLoad( EntitiesDidLoad )

	PrecacheParticleSystem( LAVA_SIPHON_SHORT_BURST_DATA.fxAsset )
	PrecacheParticleSystem( LAVA_SIPHON_LONG_BURST_DATA.fxAsset )
	PrecacheParticleSystem( CLIMATIZER_BURST_LARGE_FX )
	PrecacheParticleSystem( CLIMATIZER_BURST_SMALL_FX )
	
	           
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_MIRAGE_BOAT", 0.18, 0.53, 0.5 )

	           
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_13_LAVA_SIPHON", 0.58, 0.74, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_4_CLIMATIZER", 0.72, 0.19, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_5_LANDSLIDE", 0.36, 0.47, 0.5 )

	           
	SURVIVAL_AddMinimapLevelLabel( "DES_ZONE_8_STAGING", 0.31, 0.59, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_16_LAUNCH_SITE", 0.56, 0.90, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_1_COUNTDOWN", 0.29, 0.36, 0.5 )

	           
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_6_FRAGMENT_WEST", 0.52, 0.40, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_6_FRAGMENT_EAST", 0.66, 0.44, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_3_SURVEY", 0.59, 0.20, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_9_HARVESTER", 0.47, 0.60, 0.5 )

	           
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_11_THERMAL_STATION", 0.28, 0.73, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_7_SNOW_FIELD", 0.85, 0.40, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_2_CAP_CITY", 0.35, 0.22, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_15_LAVA_CITY", 0.80, 0.80, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_5_LAVA_FISSURE", 0.18, 0.43, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_4_GROUND_ZERO", 0.63, 0.30, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_10_RESEARCH_STATION_BRAVO", 0.77, 0.60, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_12_RESEARCH_STATION_ALPHA", 0.41, 0.84, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_16_MT", 0.72, 0.92, 0.5 )

	                     
	                                                                        
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_1_BLOOD_SHORT", 0.22, 0.22, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_15_RAMPART_TT_SHORT", 0.79, 0.71, 0.5 )
}

void function EntitiesDidLoad()                                                                           
{
	LavaSiphon_VentFX_Init()
	Climatizer_FX_Init()
}

void function InstanceSiloDoorsActivatedWP( entity wp )
{
	thread InstanceSiloDoorsActivatedWP_Thread( wp )
}

void function InstanceSiloDoorsActivatedWP_Thread( entity wp )
{
	EndSignal( GetLocalClientPlayer(), "OnDeath" )

	array<entity> siloDoors
	siloDoors.append( GetEntByScriptName( SILO_DOOR_LEFT_SCRIPTNAME ) )
	siloDoors.append( GetEntByScriptName( SILO_DOOR_RIGHT_SCRIPTNAME ) )

	foreach ( entity door in siloDoors )
		AddEntToInvalidEntsForPlacingPermanentsOnto( door )

	while( wp.GetWaypointInt( 0 ) != 1 )
		WaitFrame()

	AddToAllowedAirdropDynamicEntities( GetEntByScriptName( SILO_PLATFORM_SCRIPTNAME ) )
}

void function LavaSiphon_VentFX_Init()
{
	file.lavaSiphonFXEntArray = GetEntArrayByScriptName( LAVA_SIPHON_FX_SCRIPTNAME )

	if ( file.lavaSiphonFXEntArray.len() > 0 )
		thread LavaSiphon_SpawnFX_Thread()
}

void function LavaSiphon_SpawnFX_Thread()
{
	EndSignal( GetLocalClientPlayer(), "OnDeath" )

	int fxDataIdx
	entity refEnt

	while( true )
	{
		fxDataIdx = RandomInt( file.lavaSiphonFXDatas.len() )
		LavaSiphonFXData data = file.lavaSiphonFXDatas[ fxDataIdx ]

		refEnt = LavaSiphon_GetRefEntForFX( refEnt )

		int fx = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( data.fxAsset ), refEnt.GetOrigin(), refEnt.GetAngles() )
		                                                                 
		entity sfx = CreateClientSideAmbientGeneric( refEnt.GetOrigin(), data.sfxString, 0 )

		                                                  
		thread LavaSiphon_Cleanup_Thread( fx, sfx )

		wait RandomFloatRange( LAVA_SIPHON_FLOAT_MIN, LAVA_SIPHON_FLOAT_MAX )
	}
}

entity function LavaSiphon_GetRefEntForFX( entity refEnt )
{
	                                                                                                        
	if ( IsValid( refEnt ) )
	{
		array< entity > possibleEntities = clone file.lavaSiphonFXEntArray
		possibleEntities.removebyvalue( refEnt )

		int entRefIdx = RandomInt( possibleEntities.len() - 1 )
		refEnt = possibleEntities[ entRefIdx ]
	}
	else
	{
		int entRefIdx = RandomInt( file.lavaSiphonFXEntArray.len() - 1 )
		refEnt = file.lavaSiphonFXEntArray[ entRefIdx ]
	}

	return refEnt
}

void function LavaSiphon_Cleanup_Thread( int fx, entity sfx )
{
	                                                                    
	wait LAVA_SIPHON_FLOAT_CLEANUP

	if ( IsValid( fx ) )
		EffectStop( fx, true, true )

	if ( IsValid( sfx ) )
		sfx.Destroy()
}

void function Climatizer_FX_Init()
{
	if ( !IsClimatizerEnabled() )
		return

	for ( int i = CLIMATIZER_FIRST_LARGE_TOWER; i <= CLIMATIZER_SECOND_LARGE_TOWER; i++ )
	{
		ClimatizerLargeTowerData data

		foreach( entity largeTowerFX in GetEntArrayByScriptNameInInstance( CLIMATIZER_LARGE_FX_SCRIPTNAME, CLIMATIZER_LARGE_TOWER_INSTANCE_NAME + i ) )
		{
			data.largeTowerVec = largeTowerFX.GetOrigin()

			int fxInt = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( CLIMATIZER_BURST_LARGE_FX ), largeTowerFX.GetOrigin(), largeTowerFX.GetAngles() )
			data.fxArray.append( fxInt )
			EffectSleep( fxInt )
			largeTowerFX.Destroy()
		}

		file.climatizerLargeTowers[ i ] <- data
	}

	for ( int i = CLIMATIZER_FIRST_EAST_TOWER; i <= CLIMATIZER_LAST_WEST_TOWER; i++ )
	{
		ClimatizerSmallTowerData data

		entity smallTowerRef = GetEntByScriptNameInstance( CLIMATIZER_SMALL_FX_SCRIPTNAME, CLIMATIZER_SMALL_TOWER_INSTANCE_NAME + i )
		data.smallTowerVec = smallTowerRef.GetOrigin()
		data.smallTowerFX = StartParticleEffectInWorldWithHandle( GetParticleSystemIndex( CLIMATIZER_BURST_SMALL_FX ), data.smallTowerVec, smallTowerRef.GetAngles() )
		EffectSleep( data.smallTowerFX )
		smallTowerRef.Destroy()

		file.climatizerSmallTowers[ i ] <- data
	}

	Climatizer_FX_MainSequence_Thread()
}

void function Climatizer_FX_MainSequence_Thread()
{
	EndSignal( GetLocalClientPlayer(), "OnDeath" )

	while( true )
	{
		thread Climatizer_Activate_LargeTowerFX_Thread( CLIMATIZER_FIRST_LARGE_TOWER )

		wait CLIMATIZER_WAIT_SHORT

		thread Climatizer_Activate_LargeTowerFX_Thread( CLIMATIZER_SECOND_LARGE_TOWER )

		wait CLIMATIZER_WAIT_SHORT

		waitthread Climatizer_Activate_SmallTowerFX_Thread( CLIMATIZER_FIRST_EAST_TOWER, CLIMATIZER_LAST_EAST_TOWER )

		thread Climatizer_Activate_LargeTowerFX_Thread( CLIMATIZER_FIRST_LARGE_TOWER )

		wait CLIMATIZER_WAIT_SHORT

		thread Climatizer_Activate_LargeTowerFX_Thread( CLIMATIZER_SECOND_LARGE_TOWER )

		wait CLIMATIZER_WAIT_SHORT

		waitthread Climatizer_Activate_SmallTowerFX_Thread( CLIMATIZER_FIRST_WEST_TOWER, CLIMATIZER_LAST_WEST_TOWER )
	}
}

void function Climatizer_Activate_LargeTowerFX_Thread( int largeTower )
{
	EndSignal( GetLocalClientPlayer(), "OnDeath" )

	ClimatizerLargeTowerData data = file.climatizerLargeTowers[ largeTower ]

	foreach ( fx in data.fxArray )
		Climatizer_FX_WakeAndRestart( fx )

	entity ambientGeneric = CreateClientSideAmbientGeneric( data.largeTowerVec, CLIMATIZER_BURST_LARGE_SFX, 0 )

	wait CLIMATIZER_WAIT_LONG

	foreach ( fx in data.fxArray )
	{
		if ( EffectDoesExist( fx ) )
			EffectSleep( fx )
	}

	if ( IsValid( ambientGeneric ) )
		ambientGeneric.Destroy()
}

void function Climatizer_Activate_SmallTowerFX_Thread( int firstTower, int lastTower )
{
	EndSignal( GetLocalClientPlayer(), "OnDeath" )

	for ( int i = firstTower; i <= lastTower; i++ )
	{
		ClimatizerSmallTowerData data = file.climatizerSmallTowers[ i ]

		Climatizer_FX_WakeAndRestart( data.smallTowerFX )
		entity ambientGeneric = CreateClientSideAmbientGeneric( data.smallTowerVec, CLIMATIZER_BURST_SMALL_SFX, 0 )

		thread Climatizer_FX_Cleanup_Thread( data.smallTowerFX, ambientGeneric )

		wait CLIMATIZER_WAIT_SHORT
	}
}

void function Climatizer_FX_WakeAndRestart( int fx )
{
	if ( EffectDoesExist( fx ) )
	{
		EffectRestart( fx, true, true )
		EffectWake( fx )
	}
}

void function Climatizer_FX_Cleanup_Thread( int smallTowerFX, entity ambientGeneric )
{
	wait CLIMATIZER_WAIT_LONG

	if ( EffectDoesExist( smallTowerFX ) )
		EffectSleep( smallTowerFX )

	if ( IsValid( ambientGeneric ) )
		ambientGeneric.Destroy()
}

bool function IsClimatizerEnabled()
{
	bool climatizerTowersExist = true
	array< entity > smallTowers = GetEntArrayByScriptName( CLIMATIZER_SMALL_FX_SCRIPTNAME )
	array< entity > largeTowers = GetEntArrayByScriptName( CLIMATIZER_LARGE_FX_SCRIPTNAME )
	if ( smallTowers.len() == 0 || largeTowers.len() == 0 )
		climatizerTowersExist = false

	return climatizerTowersExist
}