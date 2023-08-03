global function RTKLegendLoreScreen_InitMetaData
global function RTKLegendLoreScreen_OnInitialize
global function RTKLegendLoreScreen_OnDestroy
global function InitRTKLegendLorePanel

global struct RTKLegendLoreScreen_Properties
{
	rtk_behavior stopCamera
}

void function RTKLegendLoreScreen_InitMetaData( string behaviorType, string structType )
{
	RTKMetaData_BehaviorIsRuiBehavior( behaviorType, true )

	RTKMetaData_SetAllowedBehaviorTypes( structType, "stopCamera", [ "Button" ] )
}

void function RTKLegendLoreScreen_OnInitialize( rtk_behavior self )
{
	RunClientScript( "EnableModelTurn" )
	RunMenuClientFunction( "ClearAllCharacterPreview" )
	UI_SetPresentationType( ePresentationType.CHARACTER_SKIN )

	rtk_behavior ornull stopCamera = self.PropGetBehavior( "stopCamera" )
	if ( stopCamera != null )
	{
		self.AutoSubscribe( stopCamera, "onHighlighted", function( rtk_behavior button, int prevState ) : ( self ) {
			RunClientScript( "DisableModelTurn" )
		} )

		self.AutoSubscribe( stopCamera, "onIdle", function( rtk_behavior button, int prevState ) : ( self ) {
			RunClientScript( "EnableModelTurn" )
		} )
	}

	RTKLegendLoreScreen_PopulateData( self )
}

void function RTKLegendLoreScreen_PopulateData( rtk_behavior self )
{
	rtk_struct rtkModel = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "lore", "LoreModel", ["legend"] )
	ItemFlavor character = GetTopLevelCustomizeContext()

	string legendName = Localize( ItemFlavor_GetLongName( character ) )
	RTKStruct_SetString( rtkModel, "name", legendName )

	ItemFlavor skin = LoadoutSlot_GetItemFlavor( LocalClientEHI(), Loadout_CharacterSkin(character ) )
	RunClientScript( "UIToClient_PreviewCharacterSkinFromCharacterSkinPanel", ItemFlavor_GetGUID( skin ) , ItemFlavor_GetGUID( GetTopLevelCustomizeContext() ) )

	asset ornull lore = CharacterClass_GetLore( character )

	rtk_struct propertyLegendInfo = RTKStruct_AddStructProperty( rtkModel, "legendInfo", "LoreLegendModel" )
	if( lore != null )
	{
		expect asset( lore )
		array< LoreBioModel > characterBio = Lore_GetBio( lore )

		rtk_array propertyArray = RTKStruct_GetArray( rtkModel, "bio" )

		foreach( int index, LoreBioModel bio in characterBio )
		{
			rtk_struct properyBio = RTKArray_InsertNewStruct( propertyArray, index )

			RTKStruct_SetString( properyBio, "line", bio.line )
			RTKStruct_SetInt( properyBio, "marginTop", bio.marginTop )
			RTKStruct_SetInt( properyBio, "marginBottom", bio.marginBottom )
			RTKStruct_SetInt( properyBio, "marginLeft", bio.marginLeft )
			RTKStruct_SetInt( properyBio, "marginRight", bio.marginRight )

			RTKStruct_AddVariantProperty( properyBio, "margin" )
			RTKStruct_SetFloat4( properyBio, "margin", < float( bio.marginLeft ), float( bio.marginRight ), float( bio.marginTop) >, float( bio.marginBottom )  )
		}

		LoreLegendModel loreLegend = Lore_GetLegendInfo( lore )
		RTKStruct_SetString( propertyLegendInfo, "realName", loreLegend.realName )
		RTKStruct_SetString( propertyLegendInfo, "alias", loreLegend.alias )
		RTKStruct_SetString( propertyLegendInfo, "age", loreLegend.age )
		RTKStruct_SetString( propertyLegendInfo, "homeWorld", loreLegend.homeWorld )
	}
}

void function RTKLegendLoreScreen_OnDestroy( rtk_behavior self )
{
	UI_SetPresentationType( ePresentationType.INACTIVE )

	RTKDataModelType_DestroyStruct( RTK_MODELTYPE_MENUS, "lore", ["legend"] )
}


void function InitRTKLegendLorePanel( var panel )
{
	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, LegendLorePanel_OnShow )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, LegendLorePanel_OnHide )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )

	#if NX_PROG || PC_PROG_NX_UI
		AddPanelFooterOption( panel, LEFT, BUTTON_TRIGGER_LEFT, false, "#MENU_ZOOM_CONTROLS_GAMEPAD", "#MENU_ZOOM_CONTROLS", null )
	#else
		AddPanelFooterOption( panel, RIGHT, BUTTON_TRIGGER_LEFT, false, "#MENU_ZOOM_CONTROLS_GAMEPAD", "#MENU_ZOOM_CONTROLS", null )
	#endif
}


void function LegendLorePanel_OnShow( var panel )
{
	SetCurrentTabForPIN( Hud_GetHudName( panel ) )

	var parentMenu = Hud_GetParent( panel )

	Hud_SetVisible( Hud_GetChild( parentMenu, "LegendLorePanelModelRotateMouseCapture"), true )
}


void function LegendLorePanel_OnHide( var panel )
{
	var parentMenu = Hud_GetParent( panel )

	Hud_SetVisible( Hud_GetChild( parentMenu, "LegendLorePanelModelRotateMouseCapture"), false )
}
