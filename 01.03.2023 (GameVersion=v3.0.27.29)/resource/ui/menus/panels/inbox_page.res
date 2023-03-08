"resource/ui/menus/panels/inbox_page.res"
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

		GiftDisplayPanel
        {
        	ControlName				RuiPanel

        	xpos					225
        	ypos					30
        	zpos                    3

        	wide					800
        	tall					485
        	visible					1

        	rui                     "ui/gift_panel.rpak"

        	pin_to_sibling			Anchor
        	pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER
        }

		GiftButton
        {
            ControlName			    RuiButton
			classname               "MenuButton"

            xpos				    0
            ypos				    145
            zpos                    4

            wide				    229
            tall				    69
            cursorVelocityModifier  0.7
            visible                 1
            tabPosition             1

            rui					    "ui/generic_selectable_button.rpak"
            sound_focus             "UI_Menu_Focus_Small"

            pin_to_sibling			GiftDisplayPanel
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER
        }

		InboxList
        {
             ControlName			GridButtonListPanel
             xpos                    -225
             zpos                    7

             columns                 1
             rows                    5
             buttonSpacing           6
             scrollbarSpacing        6
             scrollbarOnLeft         0
             visible				 0
             tabPosition             1
             selectOnDpadNav         1

             pin_to_sibling			Anchor
             pin_corner_to_sibling	LEFT
             pin_to_sibling_corner	LEFT

             ButtonSettings
             {
                 rui                     "ui/inbox_notification_button.rpak"
                 clipRui                 1
                 wide					 450
                 tall					 80
                 cursorVelocityModifier  0.7
                 rightClickEvents		 1
                 doubleClickEvents       1
                 sound_focus             "UI_Menu_Focus_Small"
                 sound_accept            "UI_Menu_Accept"
             }
        }

        InboxTitle
        {
            ControlName             RuiPanel

            xpos                    100
            zpos                    65
            ypos_nx_handheld        75		[$NX || $NX_UI_PC]

            wide                    550
            wide_nx_handheld        633		[$NX || $NX_UI_PC]
            tall                    33
            tall_nx_handheld        38		[$NX || $NX_UI_PC]
            rui                     "ui/inbox_text.rpak"

            pin_to_sibling			InboxList
            pin_corner_to_sibling	BOTTOM
            pin_to_sibling_corner	TOP
        }

}