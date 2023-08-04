global function InitEventShopTierDialog

global function UI_OpenEventShopTierDialog
global function UI_CloseEventShopTierDialog

const string SFX_MENU_OPENED = "UI_Menu_Focus_Large"

struct {
	var menu
	var contentElm
} file

void function InitEventShopTierDialog( var newMenuArg )
{
	var menu = newMenuArg
	file.menu = menu

	SetPopup( menu, true )

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, EventShopTierDialog_OnOpen )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, EventShopTierDialog_OnClose )
	AddMenuEventHandler( menu, eUIEvent.MENU_NAVIGATE_BACK, EventShopTierDialog_OnNavigateBack )

	file.contentElm = Hud_GetChild( menu, "DialogContent" )
}

void function EventShopTierDialog_OnOpen()
{
	RuiSetString( Hud_GetRui( file.contentElm ), "messageText", Localize( "#EVENTS_EVENT_SHOP_STORY_PROGRESSION" ) )
	EmitUISound( SFX_MENU_OPENED )
}

void function EventShopTierDialog_OnClose()
{
}

void function EventShopTierDialog_OnNavigateBack()
{
	UI_CloseEventShopTierDialog()
}

void function OnOpenRadioPlay( var button )
{
	AdvanceMenu( GetMenu( "RadioPlayDialog" ) )
}

void function UI_OpenEventShopTierDialog()
{
	if ( !IsFullyConnected() )
		return

	AdvanceMenu( GetMenu( "EventShopTierDialog" ) )
}


void function UI_CloseEventShopTierDialog()
{
	if ( GetActiveMenu() == file.menu )
	{
		CloseActiveMenu()
	}
	else if ( MenuStack_Contains( file.menu ) )
	{
		if( IsDialog( GetActiveMenu() ) )
		{
			                                                                                                  
			CloseAllMenus()
		}
		else
		{
			                                                                                                                                                
			MenuStack_Remove( file.menu )
		}
	}
}
