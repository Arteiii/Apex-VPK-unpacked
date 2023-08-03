global function RTKWeaponMasteryTrialsScreen_OnEnable
global function RTKWeaponMasteryTrialsScreen_OnInitialize
global function RTKWeaponMasteryTrialsScreen_OnDestroy

global function RTKWeaponMasteryTrialsScreen_SetWeapon

global function InitWeaponMasteryTrialsMenu
global function WeaponMastery_OpenMasteryTutorial

global struct RTKWeaponMasteryTrialsScreen_Properties
{
	rtk_behavior pagination
}

struct PrivateData
{
	int menuGUID = -1
}

struct
{
	var menu = null
	string weaponId = ""
	string commonMasteryPath = ""
	int savedPage = 0
} file

void function RTKWeaponMasteryTrialsScreen_OnEnable( rtk_behavior self )
{
	rtk_behavior ornull pagination = self.PropGetBehavior( "pagination" )
	if ( pagination != null )
	{
		expect rtk_behavior( pagination )
		if ( GetLastMenuNavDirection() == MENU_NAV_FORWARD )
			pagination.PropSetInt( "startPageIndex", 0 )
		else
			pagination.PropSetInt( "startPageIndex", file.savedPage )
	}
}

void function RTKWeaponMasteryTrialsScreen_OnInitialize( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	UI_SetPresentationType( ePresentationType.WEAPON_SKIN )

	file.commonMasteryPath = RTKDataModelType_GetDataPath( RTK_MODELTYPE_COMMON, "mastery", true, [ "weapons" ] )

	if ( file.weaponId != "" )
	{
		self.GetPanel().SetBindingRootPath( file.commonMasteryPath + "." + file.weaponId )
	}
}

void function RTKWeaponMasteryTrialsScreen_OnDestroy( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	RTKFooters_RemoveAll( p.menuGUID )
	RTKFooters_Update()

	rtk_behavior ornull pagination = self.PropGetBehavior( "pagination" )
	if ( pagination != null )
	{
		expect rtk_behavior( pagination )
		file.savedPage = RTKPagination_GetCurrentPage( pagination )
	}
}

void function RTKWeaponMasteryTrialsScreen_SetWeapon( string weaponId )
{
	file.weaponId = weaponId
}

               
void function InitWeaponMasteryTrialsMenu( var menu )
{
	file.menu = menu
	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, RTKWeaponMasteryTrialsScreen_OnOpen )

	AddMenuFooterOption( menu, LEFT, BUTTON_B, true,"#B_BUTTON_BACK", "#B_BUTTON_BACK", PCBackButton_Activate )
	AddMenuFooterOption( menu, LEFT, BUTTON_X, true,"#FOOTER_PACK_INFO", "#FOOTER_PACK_INFO_MOUSE", OpenPackInfoDialog )
	AddMenuFooterOption( menu, LEFT, BUTTON_Y, true,"#FOOTER_WEAPON_MASTERY_XP_INFO", "#MASTERY_XP_BREAKDOWN", WeaponMastery_OpenMasteryTutorial )
}

void function RTKWeaponMasteryTrialsScreen_OnOpen()
{
	Lobby_AdjustScreenFrameToMaxSize( Hud_GetChild( file.menu, "WeaponMasteryTrials" ), true )
}

void function WeaponMastery_OpenMasteryTutorial( var button )
{
	UI_OpenFeatureTutorialDialog( FEATURE_WEAPON_MASTERY_TUTORIAL )
}