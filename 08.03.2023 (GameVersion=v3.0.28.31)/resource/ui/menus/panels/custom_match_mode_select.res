"resource/ui/menus/panels/custom_match_mode_select.res"
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


    SelectModeGrid
    {
        ControlName             GridButtonListPanel

		xpos					0
		ypos                    0
        wide                    %100
        tall                    580

        pin_to_sibling          SelectModeHeader
        pin_corner_to_sibling   TOP_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT

        columns                 1
        rows                    4
        buttonSpacing           10
        scrollbarSpacing        10
        scrollbarOnLeft         0
        selectOnDpadNav         0

        ButtonSettings
        {
            rui                     "ui/custom_match_mode_button.rpak"
            clipRui                 1
            wide                    542
            tall                    138
            cursorVelocityModifier  0.7
            bubbleNavEvents         1
            sound_focus             "UI_Menu_Focus"
            sound_accept            "UI_Menu_Accept"
            sound_deny              "UI_Menu_Deny"
        }
    }
}