globalize_all_functions

string function RTKMutator_PanelName( rtk_panel input )
{
	return input.GetDisplayName()
}

vector function RTKMutator_QualityColor( int input, bool exception )
{
	if (exception)
		return GetKeyColor( COLORID_HUD_LOOT_TIER0, 1 ) / 255.0

	return GetKeyColor( COLORID_HUD_LOOT_TIER0, input ) / 255.0
}