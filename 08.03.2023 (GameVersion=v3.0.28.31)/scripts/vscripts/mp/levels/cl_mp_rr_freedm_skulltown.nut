global function ClientCodeCallback_MapInit

void function ClientCodeCallback_MapInit()
{
	Skulltown_MapInit_Common()

	vector victorySequencePosition = <3500, 3100, 1500>
	vector victorySequenceAngles = <0, 20, 0>
	float victorySequenceSunIntensity = 1.15
	float victorySequenceSkyIntensity = 1
                     
		if ( GetTDMIsActive() )
		{
			victorySequencePosition = <1358.82422, -1499.49658, -2373.40796>
			victorySequenceAngles   = <0, 201.828598, 0>
		}
       
	SetVictorySequenceLocation( victorySequencePosition, victorySequenceAngles )
	SetVictorySequenceSunSkyIntensity(victorySequenceSunIntensity, victorySequenceSkyIntensity)
}