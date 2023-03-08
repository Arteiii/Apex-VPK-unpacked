global function Skulltown_MapInit_Common

void function Skulltown_MapInit_Common()
{
	SetVictorySequencePlatformModel( $"mdl/rocks/victory_platform.rmdl", < 0, 0, -10 >, < 0, 130, 0 > )
                    
	if ( GetTDMIsActive() )
	{
	SetVictorySequencePlatformModel( $"mdl/dev/empty_model.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )
	#if CLIENT
		SetVictorySequenceLocation(<1358.82422, -1499.49658, -2373.40796>, <0, 201.828598, 0> )
	#endif
	}
      
}