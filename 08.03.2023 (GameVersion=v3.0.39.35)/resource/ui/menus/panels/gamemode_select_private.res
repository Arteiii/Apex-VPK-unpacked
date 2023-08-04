"resource/ui/menus/panels/gamemode_select_private.res"
{
	PanelFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		visible				    0
        bgcolor_override        "0 0 255 32"
        paintbackground         1

        proportionalToParent    1
    }
    Header
    {
        ControlName				RuiPanel
        wide					1920
        tall					145
        xpos                    0
        ypos                    0
        zpos                    1
        rui                     "ui/gamemode_header.rpak"
        visible					1

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP

        ruiArgs
        {
            useAnimation    0
        }
    }

    Title
    {
        ControlName				RuiPanel
        ypos					-56
        ypos_nx_handheld        -100			[$NX || $NX_UI_PC]
        wide					912
        tall					207
        visible				    1
        rui                     "ui/menu_header.rpak"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }

	CreateMatch
	{
		ControlName				CNestedPanel
		xpos				    -8
		ypos					-220
		wide					597//854 //long term size, missing functionality right now
		wide_nx_handheld		645			[$NX || $NX_UI_PC]
		tall					450//618
		visible					1
		controlSettingsFile		"resource/ui/menus/panels/tournament_connect_box.res"
		zpos                    2

		pin_to_sibling			PanelFrame
		pin_corner_to_sibling	TOP_RIGHT
		pin_to_sibling_corner	CENTER
	}

    JoinMatch
    {
        ControlName				CNestedPanel
        xpos					8
        ypos					-220
		wide					597//854
		wide_nx_handheld		645			[$NX || $NX_UI_PC]
		tall					450//618
        visible					1
        controlSettingsFile		"resource/ui/menus/panels/tournament_connect_box.res"
        zpos                    2

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	CENTER
    }

	CreateOrJoinMatch
	{
		ControlName				CNestedPanel
		xpos					0
		ypos					60
		wide					597//854
		tall					432//618
		visible					1
		controlSettingsFile		"resource/ui/menus/panels/tournament_connect_box.res"
		zpos                    2

		pin_to_sibling			PanelFrame
		pin_corner_to_sibling	CENTER
		pin_to_sibling_corner	CENTER
	}

// FOOTER //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}