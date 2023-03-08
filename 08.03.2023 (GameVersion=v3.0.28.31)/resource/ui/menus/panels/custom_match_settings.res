resource/ui/menus/dialogs/custom_match_settings.res
{
    ScreenFrame
    {
        ControlName				Label
        wide					%100
        tall					%100
        labelText				""
        visible				    0
        bgcolor_override        "255 255 0 10"
        paintbackground         1
    }

    PanelFrame
    {
        ControlName				Label
        xpos                    0
        ypos                    -60
		wide					1800
		tall					980
        labelText				""
        visible				    0
        bgcolor_override        "255 255 0 64"
        paintbackground         1

        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }

    ScreenBlur
    {
        ControlName				Label
        labelText               ""
        visible                 0
    }

    BgColor
	{
	    ControlName			ImagePanel
	    xpos				0
	    ypos				0
	    wide				f0
	    tall				980
	    visible				1
	    enabled             1
	    scaleImage			1
	    image				vgui/white
        drawColor				"0 0 0 222"
	}

    SelectModeHeader
    {
        ControlName             RuiPanel

        wide                    500
        wide_nx_handheld        530			[$NX || $NX_UI_PC]
        tall                    48
        tall_nx_handheld        32			[$NX || $NX_UI_PC]
        ypos_nx_handheld        30			[$NX || $NX_UI_PC]
        clipRui                 1

        rui                     "ui/custom_match_settings_header.rpak"
        ruiArgs
        {
            headerText          "#CUSTOM_MATCH_MODE_SELECT"
        }

        pin_to_sibling          ModeSelectPanel
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   TOP_LEFT
    }

    ModeSelectPanel
    {
        ControlName				CNestedPanel
        xpos					-190
        ypos					-35
        wide                    600
        tall					580
        visible					1
        enabled 				1

		clip                    0
        navDown                 SubmitButton

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT

        controlSettingsFile     "resource/ui/menus/panels/custom_match_mode_select.res"
    }

	SelectSettingsHeader
    {
        ControlName             RuiPanel

        wide                    500
        wide_nx_handheld        530			[$NX || $NX_UI_PC]
        tall                    48
        tall_nx_handheld        32			[$NX || $NX_UI_PC]
        ypos_nx_handheld        30			[$NX || $NX_UI_PC]
        clipRui                 1

        rui                     "ui/custom_match_settings_header.rpak"
        ruiArgs
        {
            headerText          "#CUSTOM_MATCH_SETTINGS_SELECT"
        }

        pin_to_sibling          SettingsSelectPanel
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   TOP_LEFT
    }
    SettingsSelectPanel
    {
        ControlName				CNestedPanel
        xpos					140
        ypos					0
        wide                    1290
        wide_nx_handheld        1440 		[$NX || $NX_UI_PC]
        tall					772
        visible					1
        enabled 				1

        navDown                 SubmitButton

        pin_to_sibling			ModeSelectPanel
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT

        controlSettingsFile     "resource/ui/menus/panels/custom_match_settings_select.res"
    }

    ToolTip
    {
        ControlName				RuiPanel
        InheritProperties       ToolTip
    }
}
