"resource/ui/menus/panels/store_loot.res"
{
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	Anchor
	{
    	ControlName				Label
    	wide					%100
    	tall					%100
    	labelText               ""
    	proportionalToParent    1
    }

    PanelFrame
    {
    	ControlName				Label
    	xpos					0
    	ypos					0
    	wide					%100
    	tall					%100
    	labelText				""
        bgcolor_override		"70 70 70 255"
    	visible					0
    	paintbackground			1

    	proportionalToParent    1

    	 pin_to_sibling			Anchor
         pin_corner_to_sibling	CENTER
         pin_to_sibling_corner	CENTER
    }

	LootPanelA
	{
		ControlName			CNestedPanel
		ypos			    -100
		zpos			    4
		wide			    832
		tall			    656
		visible			    1
		labelText           ""
		proportionalToParent	1

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_RIGHT
        pin_to_sibling_corner	TOP_RIGHT

        PanelFrame
        {
            ControlName				Label
            xpos					0
            ypos					0
            wide					%100
            tall					%100
            labelText				""
            bgcolor_override		"10 10 10 255"
            visible					0
            paintbackground			1
    		proportionalToParent	1
        }

        PanelContent
        {
            ControlName				RuiPanel
            xpos					0
            ypos					60
            wide					%100
            tall					%40
            rui					    "ui/store_panel_loot_details.rpak"
            visible					1
    		proportionalToParent	1
        }

        GiftButton
        {
            ControlName			    RuiButton
            classname               "MenuButton"
            xpos			        %-25
            ypos			        "%11"
            zpos			        4
            wide			        %40
            tall			        96
            visible			        1
            scriptID                0
            rui					    "ui/store_inspect_purchase_button.rpak"
            cursorVelocityModifier  0.7
            proportionalToParent	1
            sound_accept            ""

			navUp                   PackInfoButton
            navRight                PurchaseButton
            navDown                 OpenOwnedButton

            pin_to_sibling			PanelContent
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	BOTTOM_LEFT
        }

        PurchaseButton
        {
            ControlName			RuiButton
            classname           "MenuButton"
            xpos			    %-32
            ypos			    "%11"
            zpos			    4
            wide			    %40
            tall			    96
            visible			    1
            scriptID            0
            rui					"ui/store_inspect_purchase_button.rpak"
            cursorVelocityModifier  0.7
            proportionalToParent	1
            sound_accept            ""

			navUp                   PackInfoButton
            navLeft                 GiftButton
            navDown                 OpenOwnedButton

            pin_to_sibling			PanelContent
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	BOTTOM_RIGHT
        }

        PackInfoButton
        {
            ControlName			    RuiButton
            classname               "MenuButton"
            xpos                    -150    [!$RTL]
            xpos                    -50    [$RTL]
            ypos                    -25
            zpos			        4
            wide			        54
            tall			        54
            visible			        1
            scriptID                0
            rui					    "ui/info_button_icon.rpak"
            cursorVelocityModifier  0.7
            proportionalToParent	1
            sound_accept            ""

            navDown                 PurchaseButton

            pin_to_sibling			PanelContent
            pin_corner_to_sibling	TOP_RIGHT
            pin_to_sibling_corner	TOP_RIGHT
            use_pin_locale_direction    1
        }

        PackInfoButtonInvisible
        {
            ControlName			    RuiButton
            classname               "MenuButton"
            zpos			        5
            wide			        %100
            tall			        %40
            visible			        1
            scriptID                0
            rui					    "ui/info_button_invisible.rpak"
            cursorVelocityModifier  0.7
            proportionalToParent	1
            sound_accept            ""

            pin_to_sibling			PanelContent
            pin_corner_to_sibling	TOP_RIGHT
            pin_to_sibling_corner	TOP_RIGHT
        }
	}

	LootPanelB
	{
		ControlName			CNestedPanel
		xpos                0
		ypos			    450
		zpos			    0
		wide			    %120
		tall			    %175
		visible			    1
		labelText           ""
		proportionalToParent	1

        pin_to_sibling			Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER

        PanelFrame
        {
            ControlName				Label
            xpos					0
            ypos					0
            wide					%100
            tall					%100
            labelText				""
            bgcolor_override		"10 10 10 255"
            visible					0
            paintbackground			1
    		proportionalToParent	1
        }

        PanelContent
        {
            ControlName				RuiPanel
            xpos					0
            ypos					0
            wide					%100
            tall					%40
            rui					    "ui/store_panel_loot_background.rpak"
            visible					1
    		proportionalToParent	1
        }

		PanelTopArrow
        {
        	ControlName             RuiPanel
            zpos                    98
            xpos                    90
            ypos			        195
            wide					926.72
            tall					200
            rui                     "ui/store_panel_top_arrow_art.rpak"
            visible					1

            pin_to_sibling			Anchor
            pin_corner_to_sibling   LEFT
            pin_to_sibling_corner	LEFT
        }

        PanelBottomArrow
        {
        	ControlName             RuiPanel
            zpos                    98
            xpos                    92
            ypos			        265
            wide					751.75
            tall					80
            rui                     "ui/store_panel_bottom_arrow_art.rpak"
            visible					1

            pin_to_sibling			Anchor
            pin_corner_to_sibling   LEFT
            pin_to_sibling_corner	LEFT
        }

        PanelArtPack
        {
            ControlName             RuiPanel
            zpos                    99
        	ypos			        25
        	xpos                    325
            wide					644.1
            tall					551
            rui                     "ui/store_panel_loot_art.rpak"
            visible					1

            pin_to_sibling			Anchor
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER
        }

        OpenOwnedButton
        {
        	ControlName			RuiButton
        	classname           "MenuButton"
        	xpos			    0
            ypos			    -22.5
        	zpos			    4
        	wide			    600
        	wide_nx_handheld    620  [$NX || $NX_UI_PC]
        	tall			    96
        	tall_nx_handheld    104  [$NX || $NX_UI_PC]
        	visible			    1
        	labelText           ""
            rui					"ui/generic_loot_button.rpak"
            cursorVelocityModifier  0.7
        	proportionalToParent	1

            navUp                   PurchaseButton

        	tabPosition             1

            pin_to_sibling			PanelContent
            pin_corner_to_sibling	BOTTOM
            pin_to_sibling_corner	BOTTOM
        }

	}
}