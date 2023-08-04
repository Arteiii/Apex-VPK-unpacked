global function RTKEventShopTierDialogPanel_OnInitialize

global struct RTKEventShopTierDialogPanel_Properties
{
	rtk_panel backButton
	rtk_panel radioPlayButton
}

void function RTKEventShopTierDialogPanel_OnInitialize( rtk_behavior self )
{
	self.GetPanel().SetBindingRootPath( GetActiveTierBindingPath() )

	                                                                    
	rtk_panel ornull backButtonPanel = self.PropGetPanel( "backButton" )
	if ( backButtonPanel != null )
	{
		expect rtk_panel( backButtonPanel )
		rtk_behavior ornull button = backButtonPanel.FindBehaviorByTypeName( "Button" )
		if ( button != null )
		{
			self.AutoSubscribe( button, "onPressed", function( rtk_behavior button, int keycode, int prevState ) : ( self ) {
				UI_CloseEventShopTierDialog()
			} )
		}
	}

	rtk_struct tierModel = RTKDataModel_GetStruct( GetActiveTierBindingPath() )
	bool isLocked  = RTKStruct_GetBool( tierModel, "isLocked" )

	if ( !isLocked )
	{
		                                                                                                           
		rtk_panel ornull radioPlayButtonPanel = self.PropGetPanel( "radioPlayButton" )
		if ( radioPlayButtonPanel != null )
		{
			expect rtk_panel( radioPlayButtonPanel )
			rtk_behavior ornull button = radioPlayButtonPanel.FindBehaviorByTypeName( "Button" )
			if ( button != null )
			{
				self.AutoSubscribe( button, "onPressed", function( rtk_behavior button, int keycode, int prevState ) : ( self ) {
					UI_CloseEventShopTierDialog()
					AdvanceMenu( GetMenu( "RadioPlayDialog" ) )
				} )
			}
		}
	}
}