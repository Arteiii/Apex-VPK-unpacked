global function InitCustomizeWeaponMenu

struct
{
	var        menu
	array<var> weaponTabBodyPanelList

	var skinsPanel
	var charmsPanel

	array<ItemFlavor> weaponList
} file


void function InitCustomizeWeaponMenu( var newMenuArg )                                               
{
	var menu = GetMenu( "CustomizeWeaponMenu" )
	file.menu = menu

	SetTabRightSound( menu, "UI_Menu_ArmoryTab_Select" )
	SetTabLeftSound( menu, "UI_Menu_ArmoryTab_Select" )

	file.weaponTabBodyPanelList = [
		Hud_GetChild( menu, "CategoryWeaponPanel0" )
		Hud_GetChild( menu, "CategoryWeaponPanel1" )
		Hud_GetChild( menu, "CategoryWeaponPanel2" )
		Hud_GetChild( menu, "CategoryWeaponPanel3" )
		Hud_GetChild( menu, "CategoryWeaponPanel4" )
		Hud_GetChild( menu, "CategoryWeaponPanel5" )
	]

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, CustomizeWeaponMenu_OnOpen )
	AddMenuEventHandler( menu, eUIEvent.MENU_SHOW, CustomizeWeaponMenu_OnShow )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, CustomizeWeaponMenu_OnClose )
	AddMenuEventHandler( menu, eUIEvent.MENU_NAVIGATE_BACK, CustomizeWeaponMenu_OnNavigateBack )
}


void function CustomizeWeaponMenu_OnOpen()
{
	RunClientScript( "UIToClient_ResetWeaponRotation" )
	RunClientScript( "EnableModelTurn" )

	ItemFlavor category =  GetTopLevelCustomizeContext()

	AddCallback_OnTopLevelCustomizeContextChanged( file.menu, CustomizeWeaponMenu_Update )
	CustomizeWeaponMenu_Update( file.menu )

	TabData tabData = GetTabDataForPanel( file.menu )
	tabData.centerTabs = true
	                                                                                                      

	if ( GetLastMenuNavDirection() == MENU_NAV_FORWARD )
	{
		ActivateTab( tabData, 0 )
	}

	UpdateMenuTabs()
}

void function CustomizeWeaponMenu_OnShow()
{
}

void function CustomizeWeaponMenu_OnClose()
{
	RemoveCallback_OnTopLevelCustomizeContextChanged( file.menu, CustomizeWeaponMenu_Update )
	CustomizeWeaponMenu_Update( file.menu )
}

void function CustomizeWeaponMenu_Update( var menu )
{
	for ( int panelIdx = 0; panelIdx < file.weaponTabBodyPanelList.len(); panelIdx++ )
	{
		var tabBodyPanel = file.weaponTabBodyPanelList[panelIdx]
		CategoryWeaponPanel_SetWeapon( tabBodyPanel, null )
		if ( panelIdx < file.weaponList.len() )
		{
			ItemFlavor weapon = file.weaponList[panelIdx]

			Newness_RemoveCallback_OnRerverseQueryUpdated( NEWNESS_QUERIES.WeaponTab[weapon], OnNewnessQueryChangedUpdatePanelTab, tabBodyPanel )
		}
	}
	file.weaponList.clear()

	ClearTabs( menu )

	                                   
	if ( GetActiveMenu() == menu )
	{
		ItemFlavor category = GetTopLevelCustomizeContext()
		file.weaponList = GetWeaponsInCategory( category )

		foreach ( int weaponIdx, ItemFlavor weapon in file.weaponList )
		{
			var tabBodyPanel = file.weaponTabBodyPanelList[weaponIdx]

			TabDef tabdef = AddTab( menu, tabBodyPanel, Localize( ItemFlavor_GetShortName( weapon ) ).toupper() )
			SetTabBaseWidth( tabdef, 220 )

			CategoryWeaponPanel_SetWeapon( tabBodyPanel, weapon )
			Newness_AddCallbackAndCallNow_OnRerverseQueryUpdated( NEWNESS_QUERIES.WeaponTab[weapon], OnNewnessQueryChangedUpdatePanelTab, tabBodyPanel )
		}

		TabData tabData = GetTabDataForPanel( menu )
		tabData.centerTabs = true
		SetTabBackground( tabData, Hud_GetChild( menu, "TabsBackground" ), eTabBackground.STANDARD )
		SetTabDefsToSeasonal(tabData)
	}

	UpdateMenuTabs()
}



void function CustomizeWeaponMenu_OnNavigateBack()
{
	Assert( GetActiveMenu() == file.menu )

	CloseActiveMenu()
}


