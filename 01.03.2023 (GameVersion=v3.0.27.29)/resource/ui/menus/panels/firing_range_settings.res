"resource/ui/menus/panels/survival_mode_settings.res"
{
	ScreenFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		visible				    1
    }

	PanelFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		visible				    1
        bgcolor_override        "0 255 0 32"
        paintbackground         0

        proportionalToParent    1
    }
	TabsBackground
	{
	   ControlName           RuiPanel
	   InheritProperties     TabsBackgroundShort

	   zpos                  999
	   visible               0

	   pin_to_sibling           ScreenFrame
	   pin_corner_to_sibling    TOP
	   pin_to_sibling_corner    TOP
	}
	TabsCommon
	{
	   ControlName           CNestedPanel
	   classname             "TabsCommonClass"
	   zpos                  1000
	   ypos                  0
	   wide                  %100
	   tall                  48
	   visible               0
	   controlSettingsFile   "resource/ui/menus/panels/common_tabs_short.res"

	   pin_to_sibling         ScreenFrame
	   pin_corner_to_sibling    TOP
	   pin_to_sibling_corner    TOP
	}
	FiringRangeSettingsGeneralPanel
    {
        ControlName				CNestedPanel
		wide					%100
        tall			        %100
        xpos                    0
        ypos                    0
        zpos                    1
        visible                 1
        enabled                 1
        controlSettingsFile		"resource/ui/menus/panels/firing_range_settings_general.res"

        xcounterscroll			0.0
        ycounterscroll			0.0

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }
	DetailsPanel
    {
        ControlName				RuiPanel
        InheritProperties       SettingsDetailsFiringRangePanel
        visible					1
        xpos_nx_handheld        600   [$NX || $NX_UI_PC]
        wide_nx_handheld		640   [$NX || $NX_UI_PC]

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }
}