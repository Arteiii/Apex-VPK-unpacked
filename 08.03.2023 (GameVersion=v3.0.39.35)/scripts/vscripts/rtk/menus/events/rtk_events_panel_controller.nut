global function RTKEventsPanel_OnInitialize
global function RTKEventsPanel_OnDestroy
global function InitRTKEventsPanel

global const string FEATURE_EVENT_SHOP_TUTORIAL = "event_shop"

global struct RTKEventsPanel_Properties
{
}

global struct RTKEventInfoModel
{
	string pageTitle
	string name
	string remainingDays
	asset mainIcon
	asset leftCornerHeaderBg
	asset rightPanelBg
	asset gridItemsBg
	int currencyInWallet
	asset currencyIcon
	string currencyName
	vector leftCornerTitleColor
	vector leftCornerEventNameColor
	vector leftCornerTimeRemainingColor
	float backgroundDarkening
	float rightPanelDarkening
	float leftPanelDarkening
	vector barsColor
}

struct PrivateData
{
	string rootCommonPath = ""
}

struct
{
} file

void function RTKEventsPanel_OnInitialize( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	UI_SetPresentationType( ePresentationType.COLLECTION_EVENT )

	rtk_struct activeEvents = RTKDataModelType_CreateStruct( RTK_MODELTYPE_COMMON, "activeEvents" )
	rtk_array eventsArray   = RTKStruct_AddArrayOfStructsProperty(activeEvents, "events", "RTKEventInfoModel")

	if ( RTKArray_GetCount( eventsArray ) > 0 )
		RTKArray_Clear( eventsArray )

	                                                              
	                                                                                                              
	array<ItemFlavor> eventsList = [ expect ItemFlavor(GetActiveEventShop( GetUnixTimestamp() ) ) ]

	foreach (ItemFlavor ornull event in eventsList)
	{
		if (event != null)
		{
			expect ItemFlavor( event )

			rtk_struct eventArrayItem = RTKArray_PushNewStruct( eventsArray )

			             
			RTKEventInfoModel infoModel
			RTKStruct_GetValue( eventArrayItem, infoModel )

			DisplayTime dt = SecondsToDHMS( maxint( 0, CalEvent_GetFinishUnixTime( event ) - GetUnixTimestamp() ) )

			                
			infoModel.pageTitle = Localize("#EVENTS_EVENT_SHOP")
			infoModel.name = ItemFlavor_GetShortName( event )
			infoModel.remainingDays = Localize( GetDaysHoursRemainingLoc( dt.days, dt.hours ), dt.days, dt.hours )
			infoModel.mainIcon = EventShop_GetEventMainIcon( event )
			infoModel.leftCornerHeaderBg = EventShop_GetLeftCornerHeaderBackground( event )
			infoModel.rightPanelBg = EventShop_GetRightPanelBackground( event )
			infoModel.gridItemsBg = EventShop_GetShopPageItemsBackground( event )
			infoModel.currencyInWallet = GRXCurrency_GetPlayerBalance( GetLocalClientPlayer(), EventShop_GetEventShopGRXCurrency() )
			infoModel.currencyIcon = ItemFlavor_GetIcon( EventShop_GetEventShopCurrency( event ) )
			infoModel.currencyName = ItemFlavor_GetShortName( EventShop_GetEventShopCurrency( event ) )
			infoModel.leftCornerTitleColor = EventShop_GetLeftPanelTitleColor(  event )
			infoModel.leftCornerEventNameColor = EventShop_GetLeftPanelEventNameColor(  event )
			infoModel.leftCornerTimeRemainingColor = EventShop_GetLeftPanelTimeRemainingColor(  event )
			infoModel.backgroundDarkening = EventShop_GetBackgroundDarkeningOpacity(  event )
			infoModel.rightPanelDarkening = EventShop_GetRightPanelOpacity(  event )
			infoModel.leftPanelDarkening = EventShop_GetLeftPanelOpacity(  event )
			infoModel.barsColor = EventShop_GetBarsColor(  event )

			             
			RTKStruct_SetValue( eventArrayItem, infoModel )
		}
	}

	p.rootCommonPath = RTKDataModelType_GetDataPath( RTK_MODELTYPE_COMMON, "events", true, ["activeEvents"] )
	self.GetPanel().SetBindingRootPath( p.rootCommonPath + "[0]")

	RegisterButtonPressedCallback( KEY_H, OpenEventShopTutorial )
}

void function RTKEventsPanel_OnDestroy( rtk_behavior self )
{
	DeregisterButtonPressedCallback( KEY_H, OpenEventShopTutorial )
}

            
void function InitRTKEventsPanel( var panel )
{
	AddCallback_UI_FeatureTutorialDialog_PopulateTabsForMode( EventShop_PopulateAboutText, FEATURE_EVENT_SHOP_TUTORIAL )
	AddCallback_UI_FeatureTutorialDialog_SetTitle( EventShop_PopulateAboutTitle, FEATURE_EVENT_SHOP_TUTORIAL )

	AddPanelFooterOption( panel, LEFT, BUTTON_B, true, "#B_BUTTON_BACK", "#B_BUTTON_BACK" )
#if NX_PROG
	AddPanelFooterOption( panel, LEFT, BUTTON_Y, true, "#EVENTS_EVENT_SHOP_GET_CURRENCY", "#EVENTS_EVENT_SHOP_GET_CURRENCY", OpenEventShopTutorial )
#else
    AddPanelFooterOption( panel, LEFT, BUTTON_X, true, "#EVENTS_EVENT_SHOP_GET_CURRENCY", "#EVENTS_EVENT_SHOP_GET_CURRENCY", OpenEventShopTutorial )
#endif
}

array<featureTutorialTab> function EventShop_PopulateAboutText()
{
	array<featureTutorialTab> tabs
	featureTutorialTab tab1
	array<featureTutorialData> tab1Rules

	                                              
	tab1.tabName = 	"#GAMEMODE_RULES_OVERVIEW_TAB_NAME"

	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#EVENTS_EVENT_SHOP_TUTORIAL_0_TITLE", 	"#EVENTS_EVENT_SHOP_TUTORIAL_0_TEXT", 		$"rui/menu/events/event_shop/about_rewardshop_image_01" ) )
	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#EVENTS_EVENT_SHOP_TUTORIAL_1_TITLE", 		"#EVENTS_EVENT_SHOP_TUTORIAL_1_TEXT", 		$"rui/menu/events/event_shop/about_rewardshop_image_02" ) )
	tab1Rules.append( UI_FeatureTutorialDialog_BuildDetailsData( "#EVENTS_EVENT_SHOP_TUTORIAL_2_TITLE", 		"#EVENTS_EVENT_SHOP_TUTORIAL_2_TEXT", 		$"rui/menu/events/event_shop/about_rewardshop_image_03" ) )

	tab1.rules = tab1Rules
	tabs.append( tab1 )

	return tabs
}

string function EventShop_PopulateAboutTitle()
{
	return "#EVENTS_EVENT_SHOP"
}

void function OpenEventShopTutorial( var button )
{
	UI_OpenFeatureTutorialDialog( FEATURE_EVENT_SHOP_TUTORIAL )
}
