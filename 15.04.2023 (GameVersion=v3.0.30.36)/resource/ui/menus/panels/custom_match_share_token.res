"resource/ui/menus/panels/custom_match_share_token.res"
{
    ShareTokenPanelFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		visible				    0
        paintbackground         1

        proportionalToParent    1
    }

    ShareTokenTextEntryBackground
    {
        ControlName				RuiPanel
        xpos                    0   [!$RTL]
        xpos                    200 [$RTL]
        ypos                    0
        wide					200
        tall					48
        visible				    1
        rui                     "ui/basic_image.rpak"

        ruiArgs
        {
            basicImageColor     "0 0 0"
            basicImageAlpha        0.3
        }

        pin_to_sibling			ShareTokenPanelFrame
        pin_corner_to_sibling   TOP_LEFT
        pin_to_sibling_corner   TOP_LEFT
    }

    ShareTokenTextEntryCode
    {
        ControlName				TextEntry
        zpos					100
        xpos                    0   [!$RTL]
        xpos                    100 [$RTL]
        ypos                    0
        wide					200
        tall					48
        visible					1
        enabled					0 [!$PC]
        textHidden				1
        editable				0
        maxchars				8
        textAlignment			"center"
        ruiFont                 DefaultRegularFont
        ruiFontHeight           32
        ruiMinFontHeight        32
        keyboardTitle			""
        keyboardDescription		""
        allowRightClickMenu		0
        allowSpecialCharacters	0
        unicode					0
        selectOnFocus           0
        cursorVelocityModifier  0.7
        cursorPriority          1
        disabledFgColor_override       "232 232 232 255"

        pin_to_sibling			ShareTokenPanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }

    ShareTokenHeader
    {
        ControlName             Label

        xpos                    15  [!$RTL]
        xpos                    -200 [$RTL]
        ypos					0
        wide                    160
        tall                    48
        textAlignment			"east"
		labelText               ""
        pin_to_sibling          ShareTokenPanelFrame
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   TOP_LEFT
    }

    ShareTokenToggleButton
    {
        ControlName				RuiButton
        classname               "MenuButton"
        wide					84
        tall					48
        xpos                    0
        ypos                    0
        zpos                    120
        rui                     "ui/generic_button.rpak"
        ruiArgs
	    {
	                            buttonText     "#CUSTOMMATCH_ACCESS_TOKEN_REVEAL"
	    }
        labelText               ""
        visible					1
        cursorVelocityModifier  0.7

        proportionalToParent    1

        pin_to_sibling						ShareTokenPanelFrame
        pin_corner_to_sibling				TOP_RIGHT
        pin_to_sibling_corner				TOP_RIGHT

        sound_focus             "UI_Menu_Focus_Large"
    }
}