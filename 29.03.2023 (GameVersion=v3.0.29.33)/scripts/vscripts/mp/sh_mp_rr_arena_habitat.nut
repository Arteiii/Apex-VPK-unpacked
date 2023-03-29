global function ShInit_Habitat


void function ShInit_Habitat()
{
	CryptoDrone_SetMaxZ( 3040 )
	SetVictorySequencePlatformModel( $"mdl/dev/empty_model.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )
	#if CLIENT
	  SetVictorySequenceLocation(<1358.82422, -1499.49658, -2373.40796>, <0, 201.828598, 0> )
	#endif
}