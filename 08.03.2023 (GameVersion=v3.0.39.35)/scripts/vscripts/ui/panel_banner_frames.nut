global function InitCardFramesPanel

struct
{
	var                    panel
	var                    listPanel
	array<ItemFlavor>      cardFrameList

	var 						blurbPanel = null
} file


void function InitCardFramesPanel( var panel )
{
	file.panel = panel
	file.listPanel = Hud_GetChild( panel, "FrameList" )

	SetPanelTabTitle( panel, "#FRAME" )

	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, CardFramesPanel_OnShow )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, CardFramesPanel_OnHide )
	AddPanelEventHandler_FocusChanged( panel, CardFramesPanel_OnFocusChanged )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
	AddPanelFooterOption( panel, LEFT, BUTTON_A, false, "#A_BUTTON_SELECT", "", null, CustomizeMenus_IsFocusedItem )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_UNLOCK_LEGEND", "#X_BUTTON_UNLOCK_LEGEND", null, CustomizeMenus_IsFocusedItemParentItemLocked )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_EQUIP", "#X_BUTTON_EQUIP", null, CustomizeMenus_IsFocusedItemEquippable )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_UNLOCK", "#X_BUTTON_UNLOCK", null, CustomizeMenus_IsFocusedItemLocked )
	file.blurbPanel = Hud_GetChild( Hud_GetParent( panel ), "SkinBlurb" )
	                                                                                                                                           
	                                                                                                                     
	                                                                                                                       
	                                                                                                                        
}


void function CardFramesPanel_OnShow( var panel )
{
	AddCallback_OnTopLevelCustomizeContextChanged( panel, CardFramesPanel_Update )
	CardFramesPanel_Update( panel )
}


void function CardFramesPanel_OnHide( var panel )
{
	RemoveCallback_OnTopLevelCustomizeContextChanged( panel, CardFramesPanel_Update )
	CardFramesPanel_Update( panel )
	var scrollPanel = Hud_GetChild( file.listPanel, "ScrollPanel" )
	Hud_SetSelected( Hud_GetChild( scrollPanel, "GridButton0" ), true )
	Hud_SetVisible( file.blurbPanel, false )
}


void function CardFramesPanel_Update( var panel )
{
	var scrollPanel = Hud_GetChild( file.listPanel, "ScrollPanel" )

	          
	foreach ( int flavIdx, ItemFlavor unused in file.cardFrameList )
	{
		var button = Hud_GetChild( scrollPanel, "GridButton" + flavIdx )
		CustomizeButton_UnmarkForUpdating( button )
	}
	file.cardFrameList.clear()

	SendMenuGladCardPreviewCommand( eGladCardPreviewCommandType.FRAME, -1, null )

	                                  
	if ( IsPanelActive( file.panel ) )
	{
		LoadoutEntry entry = Loadout_GladiatorCardFrame( GetTopLevelCustomizeContext() )
		file.cardFrameList = GetLoadoutItemsSortedForMenu( [entry], GladiatorCardFrame_GetSortOrdinal )
		FilterFrameList( file.cardFrameList )

		Hud_InitGridButtons( file.listPanel, file.cardFrameList.len() )
		foreach ( int flavIdx, ItemFlavor flav in file.cardFrameList )
		{
			var button = Hud_GetChild( scrollPanel, "GridButton" + flavIdx )
			CustomizeButton_UpdateAndMarkForUpdating( button, [entry], flav, PreviewCardFrame, CanEquipCanBuyCharacterItemCheck )
		}
	}
}


void function CardFramesPanel_OnFocusChanged( var panel, var oldFocus, var newFocus )
{
	if ( !IsValid( panel ) )                  
		return
	if ( GetParentMenu( panel ) != GetActiveMenu() )
		return

	UpdateFooterOptions()
}


void function PreviewCardFrame( ItemFlavor flav )
{
	Hud_SetVisible( file.blurbPanel, false )


	if ( GladiatorCardFrame_HasStoryBlurb( flav ) )
	{
		Hud_SetVisible( file.blurbPanel, true )
		int quality = 0
		if ( ItemFlavor_HasQuality( flav ) )
			quality = ItemFlavor_GetQuality( flav )

		var rui = Hud_GetRui( file.blurbPanel )
		RuiSetString( rui, "characterName", ItemFlavor_GetShortName( flav ) )
		RuiSetString( rui, "skinNameText", ItemFlavor_GetLongName( flav ) )
		RuiSetString( rui, "bodyText", GladiatorCardFrame_GetStoryBlurbBodyText( flav ) )
		RuiSetFloat3( rui, "characterColor", SrgbToLinear( GetKeyColor( COLORID_TEXT_LOOT_TIER0, quality + 1 ) / 255.0 ) )
		RuiSetGameTime( rui, "startTime", ClientTime() )
	}

	SendMenuGladCardPreviewCommand( eGladCardPreviewCommandType.FRAME, 0, flav )
}

void function FilterFrameList( array<ItemFlavor> frameList )
{
	for ( int i = frameList.len() - 1; i >= 0; i-- )
	{
		if ( !ShouldDisplayFrame( frameList[i] ) )
			frameList.remove( i )
	}
}

bool function ShouldDisplayFrame( ItemFlavor frame )
{
	if ( GladiatorCardFrame_ShouldHideIfLocked( frame ) )
	{
		ItemFlavor ornull character = GladiatorCardFrame_GetCharacterFlavor( frame )
		if ( character == null )
			character = LoadoutSlot_GetItemFlavor( LocalClientEHI(), Loadout_Character() )
		
		LoadoutEntry entry = Loadout_GladiatorCardFrame( expect ItemFlavor( character ) )
		if ( !IsItemFlavorUnlockedForLoadoutSlot( LocalClientEHI(), entry, frame ) )
			return false
	}

	return true
}