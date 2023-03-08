"resource/ui/menus/panels/promo_page.res"
{
		Anchor
		{
			ControlName				Label

			xpos					0
			ypos					0
			zpos                    0

			wide					%100
			tall					%100
			labelText               ""
		}

		PromoPage
		{
			ControlName				RuiPanel
			wide					1400
			tall                    664

			ypos                    -110
			zpos                    4
			visible					1
			rui                     "ui/promo_page_um.rpak"

			pin_to_sibling			Anchor
			pin_corner_to_sibling	CENTER
			pin_to_sibling_corner	CENTER
		}

		ViewButton
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					240
            wide_nx_handheld		280		[$NX || $NX_UI_PC]
            tall					72
            tall_nx_handheld		80		[$NX || $NX_UI_PC]
            fontHeight				27
            fontHeight_nx_handheld	36	    [$NX || $NX_UI_PC]

            xpos                    -110
            ypos                    6
            zpos                    5

            rui                     "ui/generic_button.rpak"
            labelText               ""
            visible					0
            cursorVelocityModifier  0.7

            pin_to_sibling			PromoPage
            pin_corner_to_sibling	BOTTOM_RIGHT
            pin_to_sibling_corner	BOTTOM_RIGHT
        }

        PrevPageButton
        {
            ControlName				RuiButton
            wide					260
            tall					594

            ypos                    -70
            xpos                    90
            zpos                    6

            rui                     "ui/promo_page_change_button_um.rpak"
            labelText               ""
            visible					1
            proportionalToParent    1
            sound_accept            "UI_Menu_MOTD_Tab"

            pin_to_sibling			PromoPage
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_LEFT
        }

        NextPageButton
        {
            ControlName				RuiButton
            wide					260
            tall					594

            ypos                    -70
            xpos                    90
            zpos                    6

            rui                     "ui/promo_page_change_button_um.rpak"
            labelText               ""
            visible					1
            proportionalToParent    1
            sound_accept            "UI_Menu_MOTD_Tab"

            pin_to_sibling			PromoPage
            pin_corner_to_sibling	TOP_RIGHT
            pin_to_sibling_corner	TOP_RIGHT
        }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		PromoPreviewButtons
        {
			ControlName             CNestedPanel
			controlSettingsFile     "resource/ui/menus/panels/promo_preview_buttons.res"

			wide                    1694
			tall                    135
			ypos                    -180
			zpos                    5

			pin_to_sibling			Anchor
			pin_corner_to_sibling	CENTER
			pin_to_sibling_corner	BOTTOM

			visible                 1
        }

        PromoPreviewActiveIndicator
        {
            ControlName				RuiPanel
            wide					240
            tall                    135
            xpos					0
            zpos                    6
            visible					1
            rui                     "ui/promo_page_preview_active_indicator.rpak"

            pin_to_sibling			PromoPreviewButtons
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_LEFT
        }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


       	ControlIndicator
        {
            ControlName				RuiPanel
            wide					100
            tall                    60

            xpos					-57
            ypos                    -65
            zpos                    4

            visible					1
            rui                     "ui/promo_page_change_control_indicator.rpak"

            pin_to_sibling			Anchor
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	BOTTOM
        }

}