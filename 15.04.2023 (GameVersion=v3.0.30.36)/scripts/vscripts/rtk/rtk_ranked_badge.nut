global function RTKRankedBadge_InitMetaData
global function RTKRankedBadge_OnInitialize
global function RTKRankedBadge_OnDrawBegin
global function RTKRankedBadge_OnDestroy

global struct RTKRankedBadge_Properties
{
	asset badgeRuiAsset
	asset rankedIcon

	bool isPlacementMode = false
	int completedMatches
	int startPip
	array<bool> wonMatches
}

void function RTKRankedBadge_InitMetaData( string behaviorType, string structType )
{
	RTKMetaData_BehaviorIsRuiBehavior( behaviorType, true )
}

void function RTKRankedBadge_OnInitialize( rtk_behavior self )
{
	self.AddPropertyCallback( "badgeRuiAsset", UpdateBadgeRuiAsset )

	UpdateBadgeRuiAsset( self )
}

void function RTKRankedBadge_OnDrawBegin( rtk_behavior self )
{
	rtk_panel panel = self.GetPanel()

	if ( panel.HasRui() )
	{
		bool isPlacementMode = expect bool( self.rtkprops.isPlacementMode )
		if ( isPlacementMode )
		{
			panel.SetRuiArgInt( "placementProgress", expect int( self.rtkprops.completedMatches ) )
			panel.SetRuiArgInt( "startPip", expect int( self.rtkprops.startPip ) )

			var wonMatches = self.rtkprops.wonMatches
			for ( int i = 0; i < RTKArray_GetCount( wonMatches ); i++ )
			{
				bool val = RTKArray_GetBool( wonMatches, i )
				panel.SetRuiArgBool( "wonGame" + i, val )
			}
		}
		else
		{
			panel.SetRuiArgImage( "rankedIcon", expect asset( self.rtkprops.rankedIcon ) )
		}
	}
}

void function RTKRankedBadge_OnDestroy( rtk_behavior self )
{
	rtk_panel panel = self.GetPanel()

	if ( panel.HasRui() )
		panel.DestroyRui()
}

void function UpdateBadgeRuiAsset( rtk_behavior self )
{
	rtk_panel panel = self.GetPanel()

	asset badgeRuiAsset = expect asset( self.rtkprops.badgeRuiAsset )
	if ( badgeRuiAsset != "" )
		panel.CreateRui( badgeRuiAsset )
	else if ( panel.HasRui() )
		panel.DestroyRui()
}
