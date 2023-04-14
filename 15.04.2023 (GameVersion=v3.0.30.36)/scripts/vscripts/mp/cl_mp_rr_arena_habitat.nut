global function ClientCodeCallback_MapInit

const asset ARENA_LEVIATHAN_MODEL = $"mdl/creatures/leviathan/leviathan_kingscanyon_preview_animated.rmdl"
struct
{
	float lastLevAnimCycleChosen = -1.0
	array < bool > leviathanCreated = [ false, false, false ]
} file

void function ClientCodeCallback_MapInit()
{
	ShInit_Habitat()
	PrecacheModel( ARENA_LEVIATHAN_MODEL )
	AddTargetNameCreateCallback( "leviathan_marker", OnLeviathanMarkerCreated )
	AddTargetNameCreateCallback( "leviathan_marker2", OnLeviathanMarkerCreated )
	AddTargetNameCreateCallback( "leviathan_marker3", OnLeviathanMarkerCreated )
}

void function OnLeviathanMarkerCreated( entity marker )
{
	string markerTargetName = marker.GetTargetName()
	printt( "OnLeviathanMarkerCreated, targetName: " + markerTargetName  )

	int index = -1
	switch ( markerTargetName )
	{
		case "leviathan_marker":
			index = 0
			break
		case "leviathan_marker2":
			index = 1
			break
		case "leviathan_marker3":
			index = 2
			break
	}

	if ( index == -1 )
	{
		printt( "Habitat - OnLeviathanMarkerCreated - Unknown targetname: " + markerTargetName + " skipping creating leviathan at: " + marker.GetOrigin() )
		return
	}


	if ( file.leviathanCreated [index]  )
		return

	entity leviathan = CreateClientSidePropDynamic( marker.GetOrigin(), marker.GetAngles(), ARENA_LEVIATHAN_MODEL )
	file.leviathanCreated [index] = true
	SetAnimateInStaticShadow( leviathan, true )

	thread LeviathanThink( leviathan )
}

void function LeviathanThink( entity leviathan )
{

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