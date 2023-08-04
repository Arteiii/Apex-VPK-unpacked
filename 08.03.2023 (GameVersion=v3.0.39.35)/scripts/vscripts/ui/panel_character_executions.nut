global function InitCharacterExecutionsPanel

struct
{
	var                    panel
	var                    headerRui
	var                    listPanel
	array<ItemFlavor>      characterExecutionList

	var   videoRui
	int   videoChannel = -1
	asset currentVideo = $""
	var   finisherIsSkinLockedLabel
	bool  isMythicExecutionUnlocked
	bool  isMythicExecutionAutoEquip
} file

void function InitCharacterExecutionsPanel( var panel )
{
	file.panel = panel
	file.listPanel = Hud_GetChild( panel, "CharacterExecutionList" )
	file.headerRui = Hud_GetRui( Hud_GetChild( panel, "Header" ) )
	file.videoRui = Hud_GetRui( Hud_GetChild( panel, "Video" ) )
	file.finisherIsSkinLockedLabel = Hud_GetChild( panel, "FinisherIsSkinLocked" )

	SetPanelTabTitle( panel, "#FINISHER" )
	RuiSetString( file.headerRui, "title", Localize( "#OWNED" ).toupper() )

	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, CharacterExecutionsPanel_OnShow )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, CharacterExecutionsPanel_OnHide )
	AddPanelEventHandler_FocusChanged( panel, CharacterExecutionsPanel_OnFocusChanged )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
	AddPanelFooterOption( panel, LEFT, BUTTON_A, false, "#A_BUTTON_SELECT", "", null, CustomizeMenus_IsFocusedItem )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_UNLOCK_LEGEND", "#X_BUTTON_UNLOCK_LEGEND", null, CustomizeMenus_IsFocusedItemParentItemLocked )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_EQUIP", "#X_BUTTON_EQUIP", null, CustomizeMenus_IsFocusedItemEquippable )
	AddPanelFooterOption( panel, LEFT, BUTTON_X, false, "#X_BUTTON_UNLOCK", "#X_BUTTON_UNLOCK", null, CustomizeMenus_IsFocusedItemLocked )
	                                                                                                                                           
	                                                                                                                     
	                                                                                                                       
	                                                                                                                        

	file.videoChannel = ReserveVideoChannel()
	RuiSetInt( file.videoRui, "channel", file.videoChannel )
}


void function CharacterExecutionsPanel_OnShow( var panel )
{
	AddCallback_OnTopLevelCustomizeContextChanged( panel, CharacterExecutionsPanel_Update )
	CharacterExecutionsPanel_Update( panel )

	UI_SetPresentationType( ePresentationType.CHARACTER_CARD )
}


void function CharacterExecutionsPanel_OnHide( var panel )
{
	RemoveCallback_OnTopLevelCustomizeContextChanged( panel, CharacterExecutionsPanel_Update )
	CharacterExecutionsPanel_Update( panel )
}


void function CharacterExecutionsPanel_Update( var panel )
{
	var scrollPanel = Hud_GetChild( file.listPanel, "ScrollPanel" )

	          
	foreach ( int flavIdx, ItemFlavor unused in file.characterExecutionList )
	{
		var button = Hud_GetChild( scrollPanel, "GridButton" + flavIdx )
		CustomizeButton_UnmarkForUpdating( button )
	}
	file.characterExecutionList.clear()

	StopVideoOnChannel( file.videoChannel )
	file.currentVideo = $""

	                                  
	if ( IsPanelActive( file.panel ) )
	{
		ItemFlavor character = GetTopLevelCustomizeContext()
		LoadoutEntry entry   = Loadout_CharacterExecution( character )
		file.characterExecutionList = GetExecutionsListForCharacterLoadout( entry )

		EHI playerEHI = LocalClientEHI()
		ItemFlavor skin = LoadoutSlot_GetItemFlavor( playerEHI, Loadout_CharacterSkin( character ) )

		                              
		                                                                                 
		                                          
		file.isMythicExecutionAutoEquip = Mythics_SkinHasCustomExecution( skin ) && CharacterExecution_IsNotEquippable( Mythics_GetCustomExecutionForCharacterOrSkin(skin) )
		file.isMythicExecutionUnlocked = Mythics_IsCustomExecutionUnlocked( FromEHI( playerEHI ), skin )

		Hud_InitGridButtons( file.listPanel, file.characterExecutionList.len() )
		foreach ( int flavIdx, ItemFlavor flav in file.characterExecutionList )
		{
			var button = Hud_GetChild( scrollPanel, "GridButton" + flavIdx )
			CustomizeButton_UpdateAndMarkForUpdating( button, [entry], flav, PreviewCharacterExecution, CanEquipCanBuyCharacterItemCheck, false, ExecutionButtonUpdateFunc )

			var rui = Hud_GetRui( button )

			                                  
			ExecutionButtonUpdateFunc( flav, rui )
		}

		                                                                                                  
		RuiSetString( file.headerRui, "title", "" )
		RuiSetString( file.headerRui, "collected", "" )                                                                                           
	}
}


void function CharacterExecutionsPanel_OnFocusChanged( var panel, var oldFocus, var newFocus )
{
	if ( !IsValid( panel ) )                  
		return
	if ( GetParentMenu( panel ) != GetActiveMenu() )
		return

	UpdateFooterOptions()
}


void function PreviewCharacterExecution( ItemFlavor flav )
{
	asset desiredVideo = CharacterExecution_GetExecutionVideo( flav )

	bool executionIsMythic = ItemFlavor_GetQuality( flav ) == eRarityTier.MYTHIC
	Hud_SetVisible( file.finisherIsSkinLockedLabel, executionIsMythic )
	if ( executionIsMythic )                                                                       
	{
		string skinName                 = Localize( Mythics_GetSkinBaseNameForCharacter( GetTopLevelCustomizeContext() ) )
		ItemFlavor character            = CharacterExecution_GetCharacterFlavor( flav )
		bool executionUsableOnTier1And2 = Mythics_IsExecutionUsableOnTier1AndTier2( character )
		string text = Localize( executionUsableOnTier1And2 ? "#PRESTIGE_PLUS_EQUIP_FINISHER" : "#EQUIP_MYTHIC_SKIN_TO_USE", skinName )
		if ( !file.isMythicExecutionUnlocked )
			text += "\n" + Localize( "#PRESTIGE_PLUS_FINISHER_UNLOCK", skinName, skinName )
		Hud_SetText( file.finisherIsSkinLockedLabel, text )
	}

	if ( file.currentVideo != desiredVideo )                                                
	{
		file.currentVideo = desiredVideo
		StartVideoOnChannel( file.videoChannel, desiredVideo, true, 0.0 )
	}
}


                                                                                      
void function ExecutionButtonUpdateFunc( ItemFlavor itemFlav, var rui )
{
	int itemRarity = ItemFlavor_GetQuality( itemFlav )
	                                                                                                                       
	if ( file.isMythicExecutionAutoEquip )
	{
		if( file.isMythicExecutionUnlocked )
		{
			RuiSetBool( rui, "isLocked", itemRarity != eRarityTier.MYTHIC )
			RuiSetBool( rui, "isEquipped", itemRarity == eRarityTier.MYTHIC )
		} else {
			RuiSetBool( rui, "isLocked", true)
		}
	}
	                                                  
	else
	{
		if( itemRarity == eRarityTier.MYTHIC && !file.isMythicExecutionUnlocked )
		{
			RuiSetBool( rui, "isLocked", true )
		}
	}
}

array<ItemFlavor> function GetExecutionsListForCharacterLoadout( LoadoutEntry loadoutEntry)
{
	array<ItemFlavor> list = GetLoadoutItemsSortedForMenu( [loadoutEntry], CharacterExecution_GetSortOrdinal )

	                                                                                  
	foreach ( int flavIdx, ItemFlavor flav in list )
	{
		if ( CharacterExecution_IsNotEquippable( flav ) && CharacterExecution_ShouldHideIfNotEquippable( flav ) )
			list.fastremove( flavIdx )
	}

	return list
}