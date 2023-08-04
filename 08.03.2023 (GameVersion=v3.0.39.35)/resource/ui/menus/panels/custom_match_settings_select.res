"resource/ui/menus/panels/custom_match_settings_select.res"
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

    SelectSettingsHeader
    {
        ControlName             RuiPanel

        wide                    1280
        wide_nx_handheld        1390 		[$NX || $NX_UI_PC]
        tall                    48
        clipRui                 1

        rui                     "ui/custom_match_settings_header.rpak"
        ruiArgs
        {
            headerText          "#CUSTOM_MATCH_SETTINGS_SELECT"
        }

        pin_to_sibling          PanelFrame
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   TOP_LEFT
    }
	SelectOptions
	{
	    ControlName              CNestedPanel

	    wide                    796
	    tall                    580
	    visible                 1

		ScrollFrame
	    {
	        ControlName             ImagePanel
	        xpos					0
	        ypos					0
	        wide					796
	        tall					580
	        visible					1
	        proportionalToParent	1
	    }
	    ScrollBar
	    {
	        ControlName             RuiButton
	        xpos                    0
            ypos                    0
            wide					16
            tall					580
            visible					1
            enabled 				1
            rui						"ui/survival_scroll_bar.rpak"
            zpos                    101

	        pin_to_sibling       ScrollFrame
	        pin_corner_to_sibling  TOP_RIGHT
	        pin_to_sibling_corner  TOP_RIGHT

	    }
        ContentPanel
	    {
	        ControlName             CNestedPanel
	        InheritProperties       SettingsContentPanel
	        tall                    1334

		    MapSelectPanel
		    {
		        ControlName				CNestedPanel
		        xpos					0
		        ypos					0
		        wide                    770
		        tall					334
		        visible					1
		        enabled 				1

		        controlSettingsFile     "resource/ui/menus/panels/custom_match_map_select.res"

                pin_to_sibling			Spacer1
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
		    }
		    OptionsSelectPanel
            {
                ControlName				CNestedPanel
                xpos					0
                ypos					0
                wide                    770
                tall					434
                tall_nx_handheld			584			[$NX || $NX_UI_PC]
                visible					1
                enabled 				1

                pin_to_sibling			MapSelectPanel
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT

                controlSettingsFile     "resource/ui/menus/panels/custom_match_options_select.res"
            }
            PanelBottom
            {
                ControlName				Label
                labelText               ""

                zpos                    0
                wide					1
                tall					1
                visible					1
                enabled 				0

                pin_to_sibling			OptionsSelectPanel
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
		}
    }
    SubmitButton
    {
        ControlName				RuiButton
        classname               "MenuButton"
        xpos                    -25
        ypos                    10
        wide					290
        tall					80


        pin_to_sibling          SelectOptions
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   BOTTOM_RIGHT

        rui                     "ui/generic_button.rpak"
        ruiArgs
        {
            buttonText          "#APPLY"
        }
    }

    CancelButton
    {
        ControlName				RuiButton
        classname               "MenuButton"
        xpos                    10
        wide					290
        tall					80
        visible					0


        pin_to_sibling          SubmitButton
        pin_corner_to_sibling   RIGHT
        pin_to_sibling_corner   LEFT

        rui                     "ui/generic_button.rpak"
        ruiArgs
        {
            buttonText          "#CUSTOMMATCH_UNDO_BUTTON"
        }
    }
}