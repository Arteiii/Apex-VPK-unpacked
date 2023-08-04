global function RTKRadioPlayScreen_InitMetaData
global function RTKRadioPlayScreen_OnInitialize
global function RTKRadioPlayScreen_OnDestroy

global function InitRadioPlayDialog
global function RadioPlay_SetGUID

global struct RTKRadioPlayScreen_Properties
{
	rtk_behavior ruiAnimation
}

global struct RTKRadioPlayLayerModel
{
	array< asset > ruis = []
	array< float > durations = []
	array< string > sounds = []
}

struct {
	string GUID = ""
} file

void function RTKRadioPlayScreen_InitMetaData( string behaviorType, string structType )
{
	RegisterSignal( "RTKRadioPlayScreen_Stop" )

	RTKMetaData_BehaviorIsRuiBehavior( behaviorType, true )
}

void function RTKRadioPlayScreen_OnInitialize( rtk_behavior self )
{
	rtk_struct rtkModel = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "radioPlay", "" )
	rtk_array offersArray = RTKStruct_AddArrayOfStructsProperty(rtkModel, "layers", "RadioPlayLayerModel")

	SettingsAssetGUID GUID = ConvertItemFlavorGUIDStringToGUID( file.GUID )

	if( IsValidItemFlavorGUID( GUID ) )
	{
		ItemFlavor radioPlay = GetItemFlavorByGUID( GUID )

		array< RadioPlayLayerModel > layers = RadioPlays_GetAnimations( radioPlay )

		float maxDuration = 0
		foreach( RadioPlayLayerModel layer in layers )
		{
			float layerDuration
			foreach( float duration in layer.durations)
			{
				layerDuration += duration
			}

			maxDuration = max( maxDuration, layerDuration )
		}

		RTKArray_SetValue( offersArray, layers )

		thread RTKRadioPlayScreen_CloseOnDelay( self, maxDuration )
	}
}

void function RTKRadioPlayScreen_OnDestroy( rtk_behavior self )
{
	file.GUID = ""
	RTKDataModelType_DestroyStruct( RTK_MODELTYPE_MENUS, "radioPlay" )
	Signal( self, "RTKRuiAnimationStop" )
}

void function RTKRadioPlayScreen_CloseOnDelay( rtk_behavior self, float delay )
{
	EndSignal( self, "RTKRuiAnimationStop" )

	wait delay

	CloseActiveMenu()
}

void function InitRadioPlayDialog( var menu )
{
	SetDialog( menu, true )

	AddMenuFooterOption( menu, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
}

void function RadioPlay_SetGUID( string GUID )
{
	file.GUID = GUID
}
