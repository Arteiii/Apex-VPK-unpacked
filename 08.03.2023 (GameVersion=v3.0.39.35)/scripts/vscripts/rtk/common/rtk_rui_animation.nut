global function RTKRuiAnimation_InitMetaData
global function RTKRuiAnimation_OnInitialize
global function RTKRuiAnimation_OnDestroy

global struct RTKRuiAnimation_Properties
{
	rtk_behavior ruiBehavior

	array< asset > ruis = []
	array< string > sounds = []
	array< float > durations = []

	bool writeStartTime = true
	bool clearWhenFinished = true

	bool isDone = false                     
}

struct PrivateData
{
	float startTime = 0
}

void function RTKRuiAnimation_InitMetaData( string behaviorType, string structType )
{
	RegisterSignal( "RTKRuiAnimationStop" )
}

void function RTKRuiAnimation_OnInitialize( rtk_behavior self )
{
	self.AddPropertyCallback( "ruis", RTKRuiAnimation_ThreadStart )

	RTKRuiAnimation_ThreadStart( self )
}

void function RTKRuiAnimation_OnDestroy( rtk_behavior self )
{
	Signal( self, "RTKRuiAnimationStop" )
}

void function RTKRuiAnimation_ThreadStart( rtk_behavior self )
{
	Signal( self, "RTKRuiAnimationStop" )

	thread RTKRuiAnimation_Start( self )
}

void function RTKRuiAnimation_Start( rtk_behavior self )
{
	EndSignal( self, "RTKRuiAnimationStop" )

	PrivateData p
	self.Private( p )

	rtk_panel ornull panel = self.GetPanel()
	rtk_behavior ornull ruiBehavior = self.PropGetBehavior( "ruiBehavior" )

	if( panel == null )
		return

	expect rtk_panel( panel )

	if ( ruiBehavior == null )
		return

	expect rtk_behavior( ruiBehavior )

	p.startTime = UITime()
	self.PropSetBool( "isDone", false )

	rtk_array ruis = self.PropGetArray( "ruis" )
	int ruisCount = RTKArray_GetCount( ruis )

	rtk_array durations = self.PropGetArray( "durations" )
	int durationsCount = RTKArray_GetCount( durations )

	rtk_array sounds = self.PropGetArray( "sounds" )
	int soundsCount = RTKArray_GetCount( sounds )

	if( ruisCount != durationsCount )
		return

	int ruiIndex = 0
	float run

	OnThreadEnd(
		function() : ( ruiIndex, sounds, soundsCount )
		{
			if( ruiIndex < soundsCount )
			{
				string sound = RTKArray_GetString( sounds, ruiIndex )
				if( sound != "" )
					StopUISoundByName( RTKArray_GetString( sounds, ruiIndex ) )
			}
		}
	)

	while( ruiIndex != ruisCount )
	{
		asset rui = RTKArray_GetAssetPath( ruis, ruiIndex )
		float duration = RTKArray_GetFloat( durations, ruiIndex )

		rtk_panel behaviorPanel = ruiBehavior.GetPanel()
		if( self.PropGetBool( "writeStartTime" ) )
		{
			rtk_struct argsStruct = ruiBehavior.PropGetStruct( "args" )
			RTKStruct_SetFloat( argsStruct, "startTime", ClientTime() )
		}

		ruiBehavior.PropSetAssetPath( "ruiAsset", rui )

		if( ruiIndex < soundsCount )
		{
			string sound = RTKArray_GetString( sounds, ruiIndex )
			if( sound != "" )
				EmitUISound( RTKArray_GetString( sounds, ruiIndex ) )
		}

		wait duration
		ruiIndex++
	}

	if( self.PropGetBool( "clearWhenFinished" ) )
		ruiBehavior.PropSetAssetPath( "ruiAsset", $"" )

	self.PropSetBool( "isDone", true )


}
