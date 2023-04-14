resource/ui/menus/dialogs/role_info.menu
{
    ScreenFrame
    {
        ControlName				Label
        wide					1920
        tall					%100

        labelText				""
    }

	PanelFrame
    {
        ControlName				Label
        wide					1920
        tall					%100

        labelText				""
        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }

    RolePanel_1
    {
        ControlName				RuiPanel
        rui                     "ui/role_info_panel.rpak"
        classname               "RoleInfoPanel"
        scriptID            	1
        wide			        493
        tall			        375
        xpos                    -20
        ypos                    35
        visible				    1

		ruiArgs
		{
			animationOffset  0.1
		}
        pin_to_sibling			RolePanel_4
        pin_corner_to_sibling	BOTTOM_RIGHT
        pin_to_sibling_corner	TOP
    }

    RolePanel_2
    {
        ControlName				RuiPanel
        rui                     "ui/role_info_panel.rpak"
        classname               "RoleInfoPanel"
        scriptID            	2
        wide			        493
        tall			        375
        xpos                    20
        ypos                    35
        visible				    1

		ruiArgs
        {
            animationOffset  0.1
        }

        pin_to_sibling			RolePanel_4
        pin_corner_to_sibling	BOTTOM_LEFT
        pin_to_sibling_corner	TOP
    }

    RolePanel_3
    {
        ControlName				RuiPanel
        rui                     "ui/role_info_panel.rpak"
        classname               "RoleInfoPanel"
        scriptID            	3
        wide			        493
        tall			        375
        xpos                    40
        ypos                    0
        visible				    1

		ruiArgs
        {
            animationOffset  0.1
        }

        pin_to_sibling			RolePanel_4
        pin_corner_to_sibling	TOP_RIGHT
        pin_to_sibling_corner	TOP_LEFT
    }

    RolePanel_4
    {
        ControlName				RuiPanel
        rui                     "ui/role_info_panel.rpak"
        classname               "RoleInfoPanel"
        scriptID            	5
        wide			        493
        tall			        375
        xpos                    0
        ypos                    305
        visible				    1

		ruiArgs
        {
            animationOffset  0.1
        }

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	BOTTOM
        pin_to_sibling_corner	CENTER
    }

    RolePanel_5
    {
        ControlName				RuiPanel
        rui                     "ui/role_info_panel.rpak"
        classname               "RoleInfoPanel"
        scriptID            	4
        wide			        493
        tall			        375
        xpos                    40
        ypos                    0
        visible				    1

		ruiArgs
        {
            animationOffset  0.1
        }

        pin_to_sibling			RolePanel_4
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }

    LegendsList1
    {
        ControlName             GridButtonListPanel
        classname               "LegendsLists"

        wide                    480
        tall                    57

        pin_to_sibling          RolePanel_1
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        xpos                    -27
        ypos                    -33

        columns                 7
        rows                    1
        buttonSpacing           4
        scrollbarSpacing        1
        scrollbarOnLeft         0
        selectOnDpadNav         1

        ButtonSettings
        {
            rui                     "ui/role_info_legend_button.rpak"
            clipRui                 1
            wide                    56
            tall                    57
            sound_focus             ""
            sound_accept            ""
            sound_deny              ""
        }
    }

    LegendsList2
    {
        ControlName             GridButtonListPanel
        classname               "LegendsLists"

        wide                    480
        tall                    57

        pin_to_sibling          RolePanel_2
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        xpos                    -27
        ypos                    -33

        columns                 7
        rows                    1
        buttonSpacing           4
        scrollbarSpacing        1
        scrollbarOnLeft         0
        selectOnDpadNav         1

        ButtonSettings
        {
            rui                     "ui/role_info_legend_button.rpak"
            clipRui                 1
            wide                    56
            tall                    57
            sound_focus             ""
            sound_accept            ""
            sound_deny              ""
        }
    }

    LegendsList3
    {
        ControlName             GridButtonListPanel
        classname               "LegendsLists"

        wide                    480
        tall                    57

        pin_to_sibling          RolePanel_3
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        xpos                    -27
        ypos                    -33

        columns                 7
        rows                    1
        buttonSpacing           4
        scrollbarSpacing        1
        scrollbarOnLeft         0
        selectOnDpadNav         1

        ButtonSettings
        {
            rui                     "ui/role_info_legend_button.rpak"
            clipRui                 1
            wide                    56
            tall                    57
            sound_focus             ""
            sound_accept            ""
            sound_deny              ""
        }
    }

    LegendsList5
    {
        ControlName             GridButtonListPanel
        classname               "LegendsLists"

        wide                    480
        tall                    57

        pin_to_sibling          RolePanel_5
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        xpos                    -27
        ypos                    -33

        columns                 7
        rows                    1
        buttonSpacing           4
        scrollbarSpacing        1
        scrollbarOnLeft         0
        selectOnDpadNav         1

        ButtonSettings
        {
            rui                     "ui/role_info_legend_button.rpak"
            clipRui                 1
            wide                    56
            tall                    57
            sound_focus             ""
            sound_accept            ""
            sound_deny              ""
        }
    }

    LegendsList4
    {
        ControlName             GridButtonListPanel
        classname               "LegendsLists"

        wide                    480
        tall                    57

        pin_to_sibling          RolePanel_4
        pin_corner_to_sibling   BOTTOM_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        xpos                    -27
        ypos                    -33

        columns                 7
        rows                    1
        buttonSpacing           4
        scrollbarSpacing        1
        scrollbarOnLeft         0
        selectOnDpadNav         1

        ButtonSettings
        {
            rui                     "ui/role_info_legend_button.rpak"
            clipRui                 1
            wide                    56
            tall                    57
            sound_focus             ""
            sound_accept            ""
            sound_deny              ""
        }
    }

}
