global function InitDownloadAoCNoticeDialog
global function OpenDownloadAoCNoticeDialog

struct
{
	var menu
} file


void function InitDownloadAoCNoticeDialog( var menu )
{
	file.menu = menu

	SetDialog( menu, true )
	SetGamepadCursorEnabled( menu, false )

	AddMenuFooterOption( menu, LEFT, BUTTON_B, true, "#B_BUTTON_DECLINE", "#B_BUTTON_DECLINE", CloseNotice )
	
	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, DownloadAoCNoticeDialog_OnOpen )
	                                                                                   
}

void function OpenDownloadAoCNoticeDialog()
{
	AdvanceMenu( file.menu )
	SetConVarBool( "NewAoCDownloadComplete", false )
}


void function DownloadAoCNoticeDialog_OnOpen()
{
	var frameElem = Hud_GetChild( file.menu, "DialogFrame" )
	RuiSetImage( Hud_GetRui( frameElem ), "basicImage", $"rui/menu/common/dialog_gradient" )
}


                                                 
   
   


void function CloseNotice( var button )
{
	CloseActiveMenu()
}