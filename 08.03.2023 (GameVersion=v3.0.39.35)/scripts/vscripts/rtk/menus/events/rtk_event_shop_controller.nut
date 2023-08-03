global function RTKEventShopPanel_OnInitialize
global function RTKEventShopPanel_OnDestroy
global function RTKMutator_AlphaFromShopItemState
global function RTKMutator_TierXPosition
global function RTKMutator_TierYPosition
global function GetActiveTierBindingPath
global function IsOfferPartOfEventShop

global struct RTKEventShopPanel_Properties
{
	rtk_panel offersGrid
	rtk_panel tierList
}

global struct RTKEventShopOfferItemModel
{
	string title
	string description
	int price
	int quantity
	asset icon
	bool isGenericIcon
	int quality
	vector qualityColor
	int state
	bool isRecurring
	bool isAvailable
	bool isOwned
	bool canAfford
}

global struct RTKTierModalInfo
{
	asset icon
	string text
	bool isCustomSize
}

global struct RTKEventShopTierModel
{
	asset badgeIcon
	asset loadscreenIcon
	int accumulatedCurrency
	int unlockValue
	float progress
	string progressText
	bool isLocked
	string radioPlayGUID
	int tier
	array<RTKTierModalInfo> modalData
}

global struct RTKEventShopTooltipInfoModel
{
	int index
	bool showActionText
	bool showIcon
	bool isRecurring
	string titleText
	string bodyText
}

global enum eShopItemState
{
	UNAVAILABLE = -1,
	AVAILABLE = 0,
	OWNED = 1,
	LOCKED = 2,
	UNAFFORDABLE = 3,
	_COUNT,
}

struct PrivateData
{
	string rootCommonPath = ""
}

struct
{
	array<GRXScriptOffer> offers = []
	array<EventShopTierData> tiers = []
	bool isRecurringRewardAvailable = false
	int accumulatedCurrency = 0
	int ownedOffers = 0
	ItemFlavor ornull activeEventShop = null
	string activeTierBindingPath = ""
} file

void function RTKEventShopPanel_OnInitialize( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	                           
	entity player = GetLocalClientPlayer()
	file.accumulatedCurrency = GetStat_Int( player, ResolveStatEntry( CAREER_STATS.s17_eventrefactor_currency), eStatGetWhen.CURRENT )

	rtk_struct eventShop = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "eventShop" )
	rtk_array offersArray = RTKStruct_AddArrayOfStructsProperty(eventShop, "offers", "RTKEventShopOfferItemModel")
	rtk_array tiersArray = RTKStruct_AddArrayOfStructsProperty(eventShop, "tiers", "RTKEventShopTierModel")
	rtk_struct tooltipInfo = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "tooltipInfo", "RTKEventShopTooltipInfoModel", ["eventShop"] )

	if ( RTKArray_GetCount( offersArray ) > 0 )
		RTKArray_Clear( offersArray )

	if ( RTKArray_GetCount( tiersArray ) > 0 )
		RTKArray_Clear( tiersArray )

	file.activeEventShop = GetActiveEventShop( GetUnixTimestamp() )
	string offerLocation = EventShop_GetGRXOfferLocation( expect ItemFlavor( file.activeEventShop ) )

	                    
	file.offers = GRX_GetLocationOffers( offerLocation )

	file.offers.sort( int function( GRXScriptOffer a, GRXScriptOffer b ) {
		int aSlot = ( "slot" in a.attributes ? int( a.attributes["slot"] ) : 99999 )
		int bSlot = ( "slot" in b.attributes ? int( b.attributes["slot"] ) : 99999 )
		if ( aSlot != bSlot )
			return aSlot - bSlot

		return 0
	} )

	foreach (GRXScriptOffer offer in file.offers)
	{
		                    
		rtk_struct offerStruct = RTKArray_PushNewStruct( offersArray )
		RTKEventShopOfferItemModel offerModel
		RTKStruct_GetValue( offerStruct, offerModel )

		                                        
		                                                                                   
		ItemFlavor ornull coreItemFlav = EventShop_GetCoreItemFlav( offer )
		expect ItemFlavor( coreItemFlav )

		                                                          
		offerModel.title = offer.titleText
		offerModel.description = offer.descText
		offerModel.price = EventShop_GetItemPrice(offer)
		offerModel.quantity = EventShop_GetCoreItemQuantity(offer)
		offerModel.icon = ItemFlavor_GetIcon( coreItemFlav )
		offerModel.isGenericIcon = false
		offerModel.quality = ItemFlavor_GetQuality( coreItemFlav, 0 ) + 1
		offerModel.qualityColor = GetKeyColor( COLORID_HUD_LOOT_TIER0, ItemFlavor_GetQuality( coreItemFlav, 0 ) + 1 ) / 255.0
		offerModel.isRecurring = false
		offerModel.isOwned = GRXOffer_IsFullyClaimed( offer )
		offerModel.isAvailable = offer.isAvailable
		offerModel.canAfford = GRX_CanAfford( offer.prices[0], 1 )

		offerModel.state = ItemShopState( offer, false )

		if ( ItemFlavor_GetTypeName(coreItemFlav) == "#itemtype_battlepass_purchased_xp_NAME" )               
		{
			offerModel.isAvailable = IsRecurringOfferAvailableToPurchase()
			offerModel.isRecurring = true
			offerModel.state = ItemShopState( offer, true )
		}

		if ( ItemFlavor_GetTypeName(coreItemFlav) == "#itemtype_character_emote_icon_NAME" )
		{
			                                                                                                     
			offerModel.icon = $"rui/menu/buttons/battlepass/icon_holospray"

			                                                                                                               
			offerModel.isGenericIcon = true
		}

		file.ownedOffers += GRXOffer_IsFullyClaimed( offer ) ? 1 : 0

		             
		RTKStruct_SetValue( offerStruct, offerModel )
	}

	file.tiers = EventShop_GetTiersData( expect ItemFlavor( file.activeEventShop ) )
	for ( int i = 0; i < file.tiers.len(); i++ )
	{
		rtk_struct tierStruct = RTKArray_PushNewStruct( tiersArray )

		             
		RTKEventShopTierModel tierModel
		RTKStruct_GetValue(tierStruct, tierModel )

		                
		tierModel.unlockValue = file.tiers[i].unlockValue
		tierModel.accumulatedCurrency = file.accumulatedCurrency
		tierModel.progress = TierProgress( file.accumulatedCurrency, file.tiers[i].unlockValue)

		string formattedUnlockValue = FormatAndLocalizeNumber( "1", float( file.tiers[i].unlockValue ), true )
		string formattedAccumulatedCurrency = FormatAndLocalizeNumber( "1", float( file.accumulatedCurrency ), true )
		tierModel.progressText = Localize( "#VAL_SLASH_VAL", file.accumulatedCurrency > file.tiers[i].unlockValue ? formattedUnlockValue : formattedAccumulatedCurrency, formattedUnlockValue )

		tierModel.isLocked = TierProgress( file.accumulatedCurrency, file.tiers[i].unlockValue) < 1.0
		tierModel.tier = i + 1

		if ( file.tiers[i].badges.len() > 0 )
		{
			tierModel.badgeIcon = ItemFlavor_GetIcon( file.tiers[i].badges[0] )
			RTKTierModalInfo tierData
			tierData.icon = tierModel.badgeIcon
			tierData.text = ItemFlavor_GetLongName( file.tiers[i].badges[0] )
			tierModel.modalData.push(tierData)
		}

		if ( file.tiers[i].rewards.len() > 0 )
		{
			tierModel.loadscreenIcon = ItemFlavor_GetIcon( file.tiers[i].rewards[0] )
			RTKTierModalInfo tierData
			tierData.icon = tierModel.loadscreenIcon
			tierData.text = ItemFlavor_GetLongName( file.tiers[i].rewards[0] )
			tierData.isCustomSize = true
			tierModel.modalData.push(tierData)
		}

		if( file.tiers[i].radioPlays.len() > 0 )
			tierModel.radioPlayGUID = ItemFlavor_GetGUIDString( file.tiers[i].radioPlays[0] )
		             
		RTKStruct_SetValue( tierStruct, tierModel )
	}

	                                            
	UpdateItemPresentation( file.offers[file.offers.len() - 1] )

	                                                           
	rtk_panel ornull offersGrid = self.PropGetPanel( "offersGrid" )
	if ( offersGrid != null )
	{
		expect rtk_panel( offersGrid )
		self.AutoSubscribe( offersGrid, "onChildAdded", function ( rtk_panel newChild, int newChildIndex ) : ( self ) {
			array< rtk_behavior > gridItems = newChild.FindBehaviorsByTypeName( "Button" )
			foreach( button in gridItems )
			{
				self.AutoSubscribe( button, "onHighlighted", function( rtk_behavior button, int prevState ) : ( self, newChildIndex ) {
					UpdateItemPresentation( file.offers[newChildIndex] )
					UpdateTooltipInfo( true, newChildIndex )
				} )

				ItemFlavor ornull coreItemFlav = EventShop_GetCoreItemFlav( file.offers[newChildIndex] )
				expect ItemFlavor( coreItemFlav )

				if ( ItemFlavor_GetTypeName(coreItemFlav ) == "#itemtype_battlepass_purchased_xp_NAME" && !file.isRecurringRewardAvailable)
					continue

				self.AutoSubscribe( button, "onPressed", function( rtk_behavior button, int keycode, int prevState ) : ( self, newChildIndex ) {
					StoreInspectMenu_AttemptOpenWithOffer( file.offers[newChildIndex], true )
				} )
			}
		} )
	}

	                                                                   
	rtk_panel ornull tierList = self.PropGetPanel( "tierList" )
	if ( tierList != null )
	{
		expect rtk_panel( tierList )
		self.AutoSubscribe( tierList, "onChildAdded", function ( rtk_panel newChild, int newChildIndex ) : ( self ) {
			rtk_behavior ornull button = newChild.FindBehaviorByTypeName( "Button" )

			if ( button != null )
			{
				expect rtk_behavior( button )
				self.AutoSubscribe( button, "onPressed", function( rtk_behavior button, int keycode, int prevState ) : ( self, newChild, newChildIndex ) {
					rtk_struct rtkModel = RTKDataModel_GetStruct( newChild.GetBindingRootPath() )
					bool isLocked  = RTKStruct_GetBool( rtkModel, "isLocked" )
					array<ItemFlavor> radioPlayFlavs = EventShop_GetTierRadioPlays( expect ItemFlavor( file.activeEventShop ), newChildIndex )

					if ( !isLocked && radioPlayFlavs.len() > 0 )
					{
						RadioPlay_SetGUID( ItemFlavor_GetGUIDString( radioPlayFlavs[0] ) )
					}
					file.activeTierBindingPath = newChild.GetBindingRootPath()
					UI_OpenEventShopTierDialog()
				} )

				self.AutoSubscribe( button, "onHighlighted", function( rtk_behavior button, int prevState ) : ( self, newChildIndex ) {
					UpdateTooltipInfo( false, newChildIndex )
				} )
			}
		} )
	}

	p.rootCommonPath = RTKDataModelType_GetDataPath( RTK_MODELTYPE_COMMON, "events", true, ["activeEvents"] )
	self.GetPanel().SetBindingRootPath( p.rootCommonPath + "[0]")
}

string function GetActiveTierBindingPath()
{
	return file.activeTierBindingPath
}

int function ItemShopState( GRXScriptOffer offer, bool isRecurring )
{
	                                                                                                                       
	                                                                
	bool offerAvailableToPurchase = isRecurring ? IsRecurringOfferAvailableToPurchase() : offer.isAvailable

	if ( offerAvailableToPurchase )
	{
		                                                                                                         
		if ( GRXOffer_IsFullyClaimed( offer ) )
			return eShopItemState.OWNED

		                                      
		if ( !GRX_CanAfford( offer.prices[0], 1 ) )
			return eShopItemState.UNAFFORDABLE

		                                                                                             
		return eShopItemState.AVAILABLE
	}
	else
	{
		                                                                                                                               
		                                                                                                                
		return eShopItemState.LOCKED
	}

	return eShopItemState.UNAVAILABLE
}

float function TierProgress( int currentValue, int totalValue )
{
	if (totalValue <= 0)
		return 0.0

	return clamp( float( currentValue ) / float( totalValue ), 0.0, 1.0 )
}

void function UpdateTooltipInfo( bool showRecurringOfferInfo = true, int index = 0 )
{
	rtk_struct tooltipInfoModel = RTKDataModel_GetStruct( RTKDataModelType_GetDataPath( RTK_MODELTYPE_MENUS, "tooltipInfo", true, ["eventShop"] ) )

	RTKStruct_SetInt( tooltipInfoModel, "index", index )

	if ( showRecurringOfferInfo )
	{
		RTKStruct_SetString( tooltipInfoModel, "titleText", Localize( "#EVENTS_EVENT_SHOP_RECURRING_TITLE" ) )
		RTKStruct_SetString( tooltipInfoModel, "bodyText", Localize( "#EVENTS_EVENT_SHOP_RECURRING_BODY", file.ownedOffers, file.offers.len() - 1 ) )
		RTKStruct_SetBool( tooltipInfoModel, "isRecurring", true )
		RTKStruct_SetBool( tooltipInfoModel, "showActionText", false )
	}
	else
	{
		int tierUnlockValue = file.tiers[index].unlockValue
		string currencyName = ItemFlavor_GetShortName( EventShop_GetEventShopCurrency( expect ItemFlavor( file.activeEventShop ) ) )

		                                                                                           
		if ( index == 3 )
		{
			RTKStruct_SetString( tooltipInfoModel, "titleText", Localize( "#EVENTS_EVENT_SHOP_MILESTONE_TITLE_ALT" ) )
			RTKStruct_SetString( tooltipInfoModel, "bodyText", Localize( "#EVENTS_EVENT_SHOP_MILESTONE_BODY_ALT", FormatAndLocalizeNumber( "1", float( tierUnlockValue ), true ), Localize( currencyName ) ) )
		}
		else
		{
			RTKStruct_SetString( tooltipInfoModel, "titleText", Localize( "#EVENTS_EVENT_SHOP_MILESTONE_TITLE" ) )
			RTKStruct_SetString( tooltipInfoModel, "bodyText", Localize( "#EVENTS_EVENT_SHOP_MILESTONE_BODY", FormatAndLocalizeNumber( "1", float( tierUnlockValue ), true ), Localize( currencyName ) ) )
		}

		RTKStruct_SetBool( tooltipInfoModel, "showActionText", true )
		RTKStruct_SetBool( tooltipInfoModel, "showIcon", TierProgress( file.accumulatedCurrency, tierUnlockValue) >= 1.0 )
		RTKStruct_SetBool( tooltipInfoModel, "isRecurring", false )
	}
}

void function UpdateItemPresentation( GRXScriptOffer offer )
{
	ItemFlavor ornull offerCoreItem = EventShop_GetCoreItemFlav( offer )
	if ( offerCoreItem != null )
	{
		expect ItemFlavor( offerCoreItem )
		RunClientScript( "UIToClient_ItemPresentation", ItemFlavor_GetGUID( offerCoreItem ), -1, 1.19, false, null, false, "collection_event_ref", false, false, false, false )
	}
}

bool function IsRecurringOfferAvailableToPurchase()
{
	foreach (GRXScriptOffer offer in file.offers)
	{
		if (ItemFlavor_GetTypeName( expect ItemFlavor( EventShop_GetCoreItemFlav(offer ) ) ) == "#itemtype_battlepass_purchased_xp_NAME")
			continue

		if (!GRXOffer_IsFullyClaimed( offer ) )
		{
			file.isRecurringRewardAvailable = false
			return false
		}
	}

	if ( (GetPlayerBattlePassLevel( GetLocalClientPlayer(), expect ItemFlavor( GetActiveBattlePass() ), false ) + 1) >= 100 )
	{
		file.isRecurringRewardAvailable = false
		return false
	}

	file.isRecurringRewardAvailable = true
	return true
}

bool function IsOfferPartOfEventShop( GRXScriptOffer offer )
{
	                                                                                         
	                                                                                                              
	if ( GetActiveEventShop( GetUnixTimestamp() ) == null || offer.isCraftingOffer )
		return false

	                                                                                           
	ItemFlavor offerCoreItem = expect ItemFlavor( EventShop_GetCoreItemFlav( offer ) )
	array<EventShopOfferData> eventOffers = EventShop_GetOffers( expect ItemFlavor( GetActiveEventShop( GetUnixTimestamp() ) ) )

	foreach ( EventShopOfferData eventOffer in eventOffers )
	{
		if ( ItemFlavor_GetGUID( offerCoreItem ) == ItemFlavor_GetGUID( eventOffer.offer ) )
			return true
	}

	return false
}

void function RTKEventShopPanel_OnDestroy( rtk_behavior self )
{
	RTKDataModelType_DestroyStruct( RTK_MODELTYPE_MENUS, "eventShop" )
	file.ownedOffers = 0
}

           
float function RTKMutator_AlphaFromShopItemState( int input, float minAlpha, float maxAlpha )
{
	switch (input)
	{
		case eShopItemState.UNAVAILABLE:
		case eShopItemState.OWNED:
		case eShopItemState.LOCKED:
			return minAlpha
		case eShopItemState.UNAFFORDABLE:
		case eShopItemState.AVAILABLE:
			return maxAlpha
	}

	return maxAlpha
}

int function RTKMutator_TierXPosition( int input, int xOffset )
{
	return input % 2 == 0 ? 0 : xOffset
}

int function RTKMutator_TierYPosition( int input, int yOffset )
{
	return input * yOffset
}
