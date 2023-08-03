global function RTKWeaponLoreScreen_InitMetaData
global function RTKWeaponLoreScreen_OnInitialize
global function RTKWeaponLoreScreen_OnDestroy
global function InitRTKWeaponLorePanel

global struct RTKWeaponLoreScreen_Properties
{
	rtk_behavior stopCamera
}

void function RTKWeaponLoreScreen_InitMetaData( string behaviorType, string structType )
{
	RTKMetaData_BehaviorIsRuiBehavior( behaviorType, true )

	RTKMetaData_SetAllowedBehaviorTypes( structType, "stopCamera", [ "Button" ] )
}


void function RTKWeaponLoreScreen_OnInitialize( rtk_behavior self )
{
	UI_SetPresentationType( ePresentationType.WEAPON_SKIN )
	RunClientScript( "EnableModelTurn" )

	ItemFlavor ornull weaponOrNull = CategoryWeaponPanel_GetActiveWeapon()
	                                  
	if ( weaponOrNull != null )
	{
		expect ItemFlavor( weaponOrNull )

		ItemFlavor weaponSkinFlavor = LoadoutSlot_GetItemFlavor( LocalClientEHI(), Loadout_WeaponSkin( weaponOrNull  ) )
		ItemFlavor charmFlavor = LoadoutSlot_GetItemFlavor( LocalClientEHI(), Loadout_WeaponCharm( WeaponSkin_GetWeaponFlavor( weaponSkinFlavor ) ) )

		int weaponCharmId      = ItemFlavor_GetGUID( charmFlavor )
		int weaponSkinId       = ItemFlavor_GetGUID( weaponSkinFlavor )

		RunClientScript( "UIToClient_PreviewWeaponSkin", weaponSkinId, weaponCharmId, true )

		RTKWeaponLoreScreen_PopulateData( self, weaponOrNull )
	}

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


}

void function RTKWeaponLoreScreen_PopulateData( rtk_behavior self, ItemFlavor weapon )
{
	rtk_struct rtkModel = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "lore", "LoreModel", ["weapon"] )

	string weaponName = Localize( ItemFlavor_GetLongName( weapon ) )
	RTKStruct_SetString( rtkModel, "name", weaponName )

	asset ornull lore = Loadout_GetLore( weapon )
	if( lore != null )
	{
		expect asset( lore )
		array< LoreBioModel > weaponBio = Lore_GetBio( lore )
		rtk_array propertyArray         = RTKStruct_GetArray( rtkModel, "bio" )

		foreach( int index, LoreBioModel bio in weaponBio )
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
	}
}

void function RTKWeaponLoreScreen_OnDestroy( rtk_behavior self )
{
	RTKDataModelType_DestroyStruct( RTK_MODELTYPE_MENUS, "lore", ["weapon"] )
}


void function InitRTKWeaponLorePanel( var panel )
{
	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, WeaponLorePanel_OnShow )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, WeaponLorePanel_OnHide )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )

	#if NX_PROG || PC_PROG_NX_UI
		AddPanelFooterOption( panel, LEFT, BUTTON_TRIGGER_LEFT, false, "#MENU_ZOOM_CONTROLS_GAMEPAD", "#MENU_ZOOM_CONTROLS", null )
	#else
		AddPanelFooterOption( panel, RIGHT, BUTTON_TRIGGER_LEFT, false, "#MENU_ZOOM_CONTROLS_GAMEPAD", "#MENU_ZOOM_CONTROLS", null )
	#endif
}


void function WeaponLorePanel_OnShow( var panel )
{
	SetCurrentTabForPIN( Hud_GetHudName( panel ) )

	var parentMenu = Hud_GetParent( panel )

	Hud_SetVisible( Hud_GetChild( parentMenu, "WeaponLorePanelModelRotateMouseCapture"), true )
}


void function WeaponLorePanel_OnHide( var panel )
{
	var parentMenu = Hud_GetParent( panel )

	Hud_SetVisible( Hud_GetChild( parentMenu, "WeaponLorePanelModelRotateMouseCapture"), false )
}
