global function InitLangAoCDialog
global function OpenLangAoCDialog

struct
{
	var menu
} file


void function InitLangAoCDialog( var menu )
{
	file.menu = menu

	SetDialog( menu, true )
	SetGamepadCursorEnabled( menu, false )

	AddMenuFooterOption( menu, LEFT, BUTTON_A, true, "#A_BUTTON_CONTINUE", "#A_BUTTON_CONTINUE", GotToEShop )
	AddMenuFooterOption( menu, LEFT, BUTTON_B, true, "#B_BUTTON_DECLINE", "#B_BUTTON_DECLINE", null )
	
	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, LangAoCDialog_OnOpen )
	                                                                         
}

void function OpenLangAoCDialog()
{
	AdvanceMenu( file.menu )
}


void function LangAoCDialog_OnOpen()
{
	var frameElem = Hud_GetChild( file.menu, "DialogFrame" )
	RuiSetImage( Hud_GetRui( frameElem ), "basicImage", $"rui/menu/common/dialog_gradient" )
}


                                       
   
   


void function GotToEShop( var button )
{
#if NX_PROG
	GoToNXEShop()
#endif
	CloseActiveMenu()
}