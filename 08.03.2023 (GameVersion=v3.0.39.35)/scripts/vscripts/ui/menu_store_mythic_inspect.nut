global function InitStoreMythicInspectMenu
global function StoreMythicInspectMenu_SetStoreOfferData
global function StoreMythicInspectMenu_AttemptOpenWithOffer

struct
{
	var menu
	var inspectPanel
	var mouseCaptureElem

	var pageHeader
	var itemGrid
	var itemInfo
	var purchaseLimit
	var ownedIndicator

	array< var > mythicInspectButtons
	var          mythicExecutionButton
	var			 mythicSkydiveTrailButton

	int activeTierIndex
	int lastItemIndex                                                                         
} file

StoreInspectOfferData s_inspectOffers
StoreInspectUIData s_inspectUIData

const int MYTHIC_TIERS = 3
const int MYTHIC_FINISHER_TIER = 3
const int MYTHIC_SKYDIVE_TRAIL_TIER = 1
const string MYTHIC_INSPECT_BUTTON_NAME = "MythicInspectButton"
const string MYTHIC_EXECUTION_BUTTON_NAME = "MythicExecutionInspectButton"
const string MYTHIC_SKYDIVE_TRAIL_BUTTON_NAME = "MythicSkydiveTrailInspectButton"

void function InitStoreMythicInspectMenu( var newMenuArg )
{
	file.menu = newMenuArg

	AddMenuEventHandler( newMenuArg, eUIEvent.MENU_OPEN, StoreMythicInspectMenu_OnOpen )
	AddMenuEventHandler( newMenuArg, eUIEvent.MENU_SHOW, StoreMythicInspectMenu_OnShow )
	AddMenuEventHandler( newMenuArg, eUIEvent.MENU_CLOSE, StoreMythicInspectMenu_OnClose )
	AddMenuEventHandler( newMenuArg, eUIEvent.MENU_HIDE, StoreMythicInspectMenu_OnHide )

	file.inspectPanel = Hud_GetChild( newMenuArg, "InspectPanel" )
	file.mouseCaptureElem = Hud_GetChild( newMenuArg, "ModelRotateMouseCapture" )

	file.pageHeader = Hud_GetChild( file.inspectPanel, "InspectHeader" )
	s_inspectUIData.discountInfo = Hud_GetChild( file.inspectPanel, "DiscountInfo" )
	file.itemInfo = Hud_GetChild( file.inspectPanel, "IndividualItemInfo" )
	s_inspectUIData.purchaseButton = Hud_GetChild( file.inspectPanel, "PurchaseOfferButton" )
	file.purchaseLimit = Hud_GetChild( file.inspectPanel, "PurchaseLimit" )
	file.ownedIndicator = Hud_GetChild( file.inspectPanel, "MythicOwned" )

	AddButtonEventHandler( s_inspectUIData.purchaseButton, UIE_CLICK, PurchaseOfferButton_OnClick )

	for ( int index = 0; index < MYTHIC_TIERS; index++ )
	{
		string inspectIndexName	= MYTHIC_INSPECT_BUTTON_NAME + string( index )
		var inspectButton = Hud_GetChild( file.inspectPanel, inspectIndexName )
		Hud_AddEventHandler( inspectButton, UIE_GET_FOCUS, MythicInspectButtonHover )

		file.mythicInspectButtons.append( inspectButton )
	}

	var executionInspectButton = Hud_GetChild( file.inspectPanel, MYTHIC_EXECUTION_BUTTON_NAME )
	Hud_AddEventHandler( executionInspectButton, UIE_GET_FOCUS, MythicInspectButtonHover )
	file.mythicExecutionButton = executionInspectButton

	var skydiveTrailInspectButton = Hud_GetChild( file.inspectPanel, MYTHIC_SKYDIVE_TRAIL_BUTTON_NAME )
	Hud_AddEventHandler( skydiveTrailInspectButton, UIE_GET_FOCUS, MythicInspectButtonHover )
	file.mythicSkydiveTrailButton = skydiveTrailInspectButton

	var prestigeHelpText = Hud_GetChild( file.inspectPanel, "SkydiveTrailDesc" )
	Hud_SetText( prestigeHelpText, Localize( "#PRESTIGE_PLUS_SET_UNLOCK" ) )

	Hud_AddEventHandler( Hud_GetChild( newMenuArg, "CoinsPopUpButton" ), UIE_CLICK, OpenVCPopUp )

	AddMenuFooterOption( newMenuArg, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
}

void function StoreMythicInspectMenu_OnOpen()
{
}

void function StoreMythicInspectMenu_OnShow()
{
	UI_SetPresentationType( ePresentationType.STORE_INSPECT )
	Lobby_AdjustScreenFrameToMaxSize( Hud_GetChild( file.menu, "ScreenFrame" ), true )

	AddCallbackAndCallNow_OnGRXInventoryStateChanged( StoreMythicInspectMenu_OnGRXUpdated )
	AddCallback_OnGRXOffersRefreshed( StoreMythicInspectMenu_OnGRXUpdated )
	AddCallback_OnGRXBundlesRefreshed( StoreMythicInspectMenu_OnGRXBundlesUpdated )

	RegisterButtonPressedCallback( KEY_TAB, ToggleVCPopUp )
	RegisterButtonPressedCallback( BUTTON_BACK, ToggleVCPopUp )

	file.lastItemIndex = -1
	if( file.mythicInspectButtons.len() > 0 && IsValid( file.mythicInspectButtons[0] ) )
		MythicInspectButtonHover( file.mythicInspectButtons[0] )
	StoreMythicUpdateInspectButtons()

}

void function StoreMythicInspectMenu_OnClose()
{
	RunClientScript( "UIToClient_UnloadItemInspectPakFile" )
}

void function StoreMythicInspectMenu_OnHide()
{
	DeregisterButtonPressedCallback( KEY_TAB, ToggleVCPopUp )
	DeregisterButtonPressedCallback( BUTTON_BACK, ToggleVCPopUp )

	RemoveCallback_OnGRXInventoryStateChanged( StoreMythicInspectMenu_OnGRXUpdated )
	RemoveCallback_OnGRXOffersRefreshed( StoreMythicInspectMenu_OnGRXUpdated )
	RemoveCallback_OnGRXBundlesRefreshed( StoreMythicInspectMenu_OnGRXBundlesUpdated )

}

void function StoreMythicInspectMenu_OnGRXBundlesUpdated()
{
	if ( s_inspectOffers.currentOffers.len() == 0 )
		return

	if( !GRX_IsInventoryReady() )
		return

	StoreInspectMenu_UpdatePrices( s_inspectOffers, s_inspectOffers.currentOffers[0], true, s_inspectUIData )
	StoreInspectMenu_UpdatePurchaseButton( s_inspectOffers.currentOffers[0], s_inspectOffers, s_inspectUIData )
}

void function StoreMythicInspectMenu_OnGRXUpdated()
{
	if( !GRX_IsInventoryReady() || !GRX_AreOffersReady() )
		return

	GRXScriptOffer storeOffer = s_inspectOffers.currentOffers[0]
	s_inspectOffers.itemFlavors.clear()

	var currMenu = GetActiveMenu()
	uiGlobal.menuData[ currMenu ].pin_metaData[ "tab_name" ] <- Hud_GetHudName( file.inspectPanel )
	uiGlobal.menuData[ currMenu ].pin_metaData[ "item_name" ] <- storeOffer.offerAlias

	foreach( ItemFlavor flav in storeOffer.output.flavors )
		s_inspectOffers.itemFlavors.append( flav )

	s_inspectOffers.purchaseLimit = ( "purchaselimit" in storeOffer.attributes ? storeOffer.attributes["purchaselimit"].tointeger() : -1 )

	StoreInspectMenu_UpdatePrices( s_inspectOffers, storeOffer, false, s_inspectUIData )
	StoreInspectMenu_UpdatePurchaseButton( storeOffer, s_inspectOffers, s_inspectUIData)

	HudElem_SetRuiArg( file.pageHeader, "offerName", storeOffer.titleText )
	HudElem_SetRuiArg( file.pageHeader, "offerDesc", storeOffer.descText )

	if( file.mythicInspectButtons.len() > 0 && IsValid( file.mythicInspectButtons[0] ) )
		MythicInspectButtonHover( file.mythicInspectButtons[0] )
	StoreMythicUpdateInspectButtons()

	bool hasPurchaseLimit = s_inspectOffers.purchaseLimit > 0
	HudElem_SetRuiArg( file.purchaseLimit, "limitText", Localize( "#STORE_LIMIT_N", s_inspectOffers.purchaseLimit ) )
	Hud_SetVisible( file.purchaseLimit, hasPurchaseLimit )
}

ItemFlavor ornull function GetItemFromButtonIndex( int index )
{
	GRXScriptOffer storeOffer = s_inspectOffers.currentOffers[0]
	if( storeOffer.items.len() < 1 )
		return null

	if ( index >= 0 && index <= 2 )
		return GetSkinItemFlavorByTier( index + 1 )
	else if ( index == 3 )
		return GetExecutionItemFlavor()
	else if (index == 4)
		return GetSkydiveTrailItemFlavor()

	return null
}

ItemFlavor ornull function GetBaseItemFlavor()
{
	GRXScriptOffer storeOffer = s_inspectOffers.currentOffers[0]

	if( storeOffer.items.len() < 1 )
		return null

	return GetItemFlavorByGRXIndex( storeOffer.items[0].itemIdx )
}

ItemFlavor ornull function GetSkinItemFlavorByTier( int tier )
{
	if (GetBaseItemFlavor() == null || tier < 1 || tier > MYTHIC_TIERS)
		return null

	return Mythics_GetItemTierForSkin( expect ItemFlavor( GetBaseItemFlavor() ), tier - 1 )
}

ItemFlavor ornull function GetExecutionItemFlavor()
{
	if (GetBaseItemFlavor() == null)
		return null

	return Mythics_GetCustomExecutionForCharacterOrSkin( expect ItemFlavor( GetSkinItemFlavorByTier ( MYTHIC_FINISHER_TIER ) ) )
}

ItemFlavor ornull function GetSkydiveTrailItemFlavor()
{
	if (GetBaseItemFlavor() == null || !Mythics_SkinHasCustomSkydivetrail( expect ItemFlavor( GetBaseItemFlavor() ) ) )
		return null

	return Mythics_GetCustomSkydivetrailForCharacterOrSkin( expect ItemFlavor( GetBaseItemFlavor() ) )
}

bool function IsSkinUnlocked( int tierToUnlock )
{
	if ( GetBaseItemFlavor() == null )
		return false

	if ( !GRX_IsItemOwnedByPlayer( expect ItemFlavor( GetBaseItemFlavor() ) ) )
		return false

	int tiersUnlocked = Mythics_GetNumTiersUnlockedForSkin( GetLocalClientPlayer(), expect ItemFlavor( GetBaseItemFlavor() ) )
	return tiersUnlocked >= tierToUnlock
}

void function SetupSkinButton( int index )
{
	ItemFlavor ornull itemFlav = GetSkinItemFlavorByTier( index + 1 )
	if( itemFlav == null )
		return
	expect ItemFlavor( itemFlav )

	var rui = Hud_GetRui( file.mythicInspectButtons[index] )
	RuiSetBool( rui, "hasLink", (index == 2) || (index == 0 && Mythics_SkinHasCustomSkydivetrail( expect ItemFlavor( GetBaseItemFlavor() ) ) ) )
	SetupInspectButton( rui, itemFlav, index + 1, index )
}

void function SetupExecutionButton()
{
	ItemFlavor ornull itemFlav = GetExecutionItemFlavor()
	if( itemFlav == null )
		return
	expect ItemFlavor( itemFlav )

	var rui = Hud_GetRui( file.mythicExecutionButton )
	SetupInspectButton( rui, itemFlav, 3, 3 )
}

void function SetupSkydiveTrailButton()
{
	ItemFlavor ornull itemFlav = GetSkydiveTrailItemFlavor()
	if( itemFlav == null )
		return
	expect ItemFlavor( itemFlav )

	var rui = Hud_GetRui( file.mythicSkydiveTrailButton )
	RuiSetBool( rui, "hasLink", false )
	SetupInspectButton( rui, itemFlav, 1, 4 )
}

void function SetupInspectButton( var rui, ItemFlavor itemFlav, int itemTier, int buttonID )
{
	int tiersUnlocked = Mythics_GetNumTiersUnlockedForSkin( GetLocalClientPlayer(), expect ItemFlavor( GetBaseItemFlavor() ) )
	asset itemThumbnail = CustomizeMenu_GetRewardButtonImage( itemFlav )
	bool isOwned = GRX_IsItemOwnedByPlayer( itemFlav ) && tiersUnlocked >= itemTier

	if ( isOwned )
	{
		Hud_SetVisible( file.ownedIndicator, isOwned )                                          
	}

	RuiSetBool( rui, "isOwned", isOwned )
	RuiSetImage( rui, "itemThumbnail", itemThumbnail )
	RuiSetInt( rui, "buttonID", buttonID )
}

void function MythicInspectButtonHover( var button )
{
	int index = int( Hud_GetScriptID( button ) )
	if( index == file.lastItemIndex || GetBaseItemFlavor() == null)
		return

	file.lastItemIndex = index

	ItemFlavor itemFlav
	string tierText
	string itemTypeText
	string itemNameText
	string unlockDescText
	string extraDescText
	int itemTier
	ItemFlavor characterItemFlav = Mythics_GetCharacterForSkin( expect ItemFlavor ( GetBaseItemFlavor() ) )

	if ( index == 3 )                                     
	{
		bool executionUsableOnTier1And2 = Mythics_IsExecutionUsableOnTier1AndTier2( characterItemFlav )
		string skinName = Localize( ItemFlavor_GetLongName( expect ItemFlavor( GetBaseItemFlavor() ) ) )

		itemFlav = expect ItemFlavor( GetExecutionItemFlavor() )
		itemTier = MYTHIC_FINISHER_TIER
		itemTypeText = "itemtype_character_execution_NAME"
		unlockDescText = Challenge_GetDescription ( Mythics_GetChallengeForSkin( expect ItemFlavor( GetSkinItemFlavorByTier( MYTHIC_FINISHER_TIER ) ) ), 1 )
		extraDescText = Localize( executionUsableOnTier1And2 ? "#PRESTIGE_PLUS_EQUIP_FINISHER" : "#EQUIP_MYTHIC_SKIN_TO_USE", skinName )
	}
	else if ( index == 4 )                                
	{
		itemFlav = expect ItemFlavor( GetSkydiveTrailItemFlavor() )
		itemTier = MYTHIC_SKYDIVE_TRAIL_TIER
		itemTypeText = "#PRESTIGE_PLUS_SKYDIVE_TRAIL"
		unlockDescText = "#S12ACE_MYTHIC_INSPECT_UNLOCK_DESC"
		extraDescText = "#PRESTIGE_PLUS_EQUIP_SKYDIVE_TRAIL"
	}
	else                       
	{
		itemFlav = expect ItemFlavor( GetSkinItemFlavorByTier( index + 1 ) )
		itemTier = index + 1
		itemTypeText = Localize( "#PRESTIGE_PLUS_LEGEND_SKIN", Localize( ItemFlavor_GetLongName( characterItemFlav ) ) )

		if ( index == 0 )
			unlockDescText = "#S12ACE_MYTHIC_INSPECT_UNLOCK_DESC"
		else
			unlockDescText = Challenge_GetDescription( Mythics_GetChallengeForSkin( itemFlav ), index - 1  )
	}

	tierText     = Localize( "#TIER", itemTier )
	itemNameText = ItemFlavor_GetLongName( itemFlav )

	int tiersUnlocked = Mythics_GetNumTiersUnlockedForSkin( GetLocalClientPlayer(), expect ItemFlavor( GetBaseItemFlavor() ) )
	bool isOwned      = GRX_IsItemOwnedByPlayer( expect ItemFlavor( GetBaseItemFlavor() ) )
	bool isLocked     = !isOwned || tiersUnlocked < itemTier

	var rui = Hud_GetRui( file.itemInfo )
	RuiSetBool( rui, "isOwned", isOwned )
	RuiSetBool( rui, "isLocked", isLocked )
	RuiSetString( rui, "tierText", tierText )
	RuiSetString( rui, "itemTypeText", itemTypeText )
	RuiSetString( rui, "itemNameText", itemNameText )
	RuiSetString( rui, "unlockDescText", unlockDescText )
	RuiSetString( rui, "extraDescText", extraDescText )

	if( IsItemFlavorStructValid( itemFlav.guid, eValidation.DONT_ASSERT ) )
		RunClientScript( "UIToClient_PreviewStoreItem", ItemFlavor_GetGUID( itemFlav ) )

	if( index == 0 )
	{
		StoreInspectMenu_UpdatePurchaseButton( s_inspectOffers.currentOffers[index], s_inspectOffers, s_inspectUIData )
	}
	else if ( isOwned )
	{
		MythicInspect_UpdatePurchaseButton( itemFlav, s_inspectOffers, s_inspectUIData, isLocked )
	}

	file.activeTierIndex = isOwned ? index : 0
}

void function MythicInspect_UpdatePurchaseButton( ItemFlavor itemFlav, StoreInspectOfferData offerData, StoreInspectUIData uiData, bool isLocked )
{
	Hud_SetVisible( uiData.discountInfo, false )

	string buttonText = isLocked ? offerData.purchaseText + " | "  + Localize( "#LOCKED" ) : offerData.purchaseText

	HudElem_SetRuiArg( uiData.purchaseButton, "buttonText", buttonText )
	HudElem_SetRuiArg( uiData.purchaseButton, "buttonDescText", offerData.purchaseDescText )

	bool isEquiped = IsItemEquipped( itemFlav )
	Hud_SetLocked( uiData.purchaseButton, isEquiped || isLocked )
	HudElem_SetRuiArg( uiData.purchaseButton, "isDisabled", isEquiped || isLocked )

	if( isLocked )
		s_inspectOffers.isOwnedItemEquippable = false
	else
		MythicInspect_UpdateButtonForEquips( itemFlav, uiData )
}

void function MythicInspect_UpdateButtonForEquips( ItemFlavor itemFlav, StoreInspectUIData uiData )
{
	int itemType = ItemFlavor_GetType( itemFlav )
	var rui = Hud_GetRui( uiData.purchaseButton )

	if ( IsItemEquipped( itemFlav ) )
	{
		int rarity = ItemFlavor_HasQuality( itemFlav ) ? ItemFlavor_GetQuality( itemFlav ) : 0

		RuiSetString( rui, "buttonText", "#EQUIPPED_LOOT_REWARD" )
		RuiSetString( rui, "buttonDescText", Localize( "#CURRENTLY_EQUIPPED_ITEM", Localize( ItemFlavor_GetLongName( itemFlav ) ) ) )
		RuiSetInt( rui, "buttonDescRarity", rarity )
	}
	else
	{
		RuiSetString( rui, "buttonText", "#EQUIP_LOOT_REWARD" )
		RuiSetString( rui, "buttonDescText", Localize( "#CURRENTLY_EQUIPPED_ITEM", Localize( GetCurrentlyEquippedItemNameForItemTypeSlot( itemFlav ) ) ) )
		RuiSetInt( rui, "buttonDescRarity", GetCurrentlyEquippedItemRarityForItemTypeSlot( itemFlav ) )
	}
}

void function PurchaseOfferButton_OnClick( var button )
{
	if ( Hud_IsLocked( button ) )
	{
		EmitUISound( "menu_deny" )
		return
	}

	if ( file.activeTierIndex == 0 )
	{
		GRXScriptOffer offer = s_inspectOffers.currentOffers[file.activeTierIndex]
		bool isBaseOwned = GRX_IsItemOwnedByPlayer( offer.output.flavors[0] )

		if ( s_inspectOffers.isOwnedItemEquippable && offer.output.flavors.len() == 1 && isBaseOwned )
		{
			StoreInspectMenu_EquipOwnedItem( offer.output.flavors[0], s_inspectUIData )
			return
		}

		PurchaseDialogConfig pdc
		pdc.offer = offer
		pdc.quantity = 1
		PurchaseDialog( pdc )
	}
	else
	{
		ItemFlavor ornull skinFlav = GetItemFromButtonIndex( file.activeTierIndex )

		if ( skinFlav == null )
			return

		expect ItemFlavor( skinFlav )

		StoreInspectMenu_EquipOwnedItem( skinFlav, s_inspectUIData )
	}
}

void function StoreMythicInspectMenu_SetStoreOfferData( array<GRXScriptOffer> storeOffers )
{
	s_inspectOffers.currentOffers.clear()
	foreach( GRXScriptOffer offer in storeOffers )
		s_inspectOffers.currentOffers.append( offer )

	GRXScriptOffer storeOffer = s_inspectOffers.currentOffers[0]

	Assert( storeOffer.output.flavors.len() == storeOffer.output.quantities.len() )

	s_inspectOffers.itemCount = storeOffer.output.flavors.len()

	Assert( s_inspectOffers.itemCount > 0,"Mythic skin offer was not found" )

	for( int i; i < file.mythicInspectButtons.len(); i++ )
	{
		if( !IsValid( file.mythicInspectButtons[i] ) )
			continue
		Hud_SetVisible( file.mythicInspectButtons[i], s_inspectOffers.itemCount > 0  )
	}

	Hud_SetVisible( file.itemInfo, s_inspectOffers.itemCount > 0 )
}

void function StoreMythicInspectMenu_AttemptOpenWithOffer( GRXScriptOffer offer )
{
	StoreMythicInspectMenu_SetStoreOfferData( [offer] )
	AdvanceMenu( GetMenu( "StoreMythicInspectMenu" ) )
}

void function StoreMythicUpdateInspectButtons()
{
	if ( !IsFullyConnected() )
		return

	for( int i; i < file.mythicInspectButtons.len(); i++ )
	{
		if( !IsValid( file.mythicInspectButtons[i] ) )
			continue

		SetupSkinButton( i )
	}

	                                                                            
	bool hasSkydiveTrail = Mythics_SkinHasCustomSkydivetrail( expect ItemFlavor( GetBaseItemFlavor() ) )
	Hud_SetVisible( file.mythicSkydiveTrailButton, hasSkydiveTrail )
	Hud_SetPinSibling( file.mythicInspectButtons[1], hasSkydiveTrail ? "MythicSkydiveTrailInspectButton" : "MythicInspectButton0" )
	Hud_SetWidth( file.ownedIndicator, ContentScaledXAsInt( hasSkydiveTrail ? 672 : 564 ) )
	if ( hasSkydiveTrail )
		SetupSkydiveTrailButton()

	SetupExecutionButton()

	Hud_SetVisible( file.ownedIndicator, GRX_IsItemOwnedByPlayer( expect ItemFlavor( GetBaseItemFlavor() ) ) )                                          
}