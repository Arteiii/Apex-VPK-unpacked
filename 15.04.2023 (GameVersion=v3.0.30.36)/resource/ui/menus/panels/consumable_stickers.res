"resource/ui/menus/panels/consumable_stickers.res"
{
	PanelFrame
	{
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
//		bgcolor_override		"70 70 70 255"
//		visible					1
//		paintbackground			1
        proportionalToParent    1
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    StickersOwned
    {
        ControlName             RuiPanel
        xpos                    242
		ypos                    100
        wide                    550
        tall                    33
        rui                     "ui/stickers_owned.rpak"
    }

	SkinBlurb
    {
        ControlName             RuiPanel
        xpos                    -48
        ypos                    -607
        zpos                    0
        wide                    308
        wide_nx_handheld        380		[$NX || $NX_UI_PC]
        tall                    308
        tall_nx_handheld        380		[$NX || $NX_UI_PC]
        rui                     "ui/character_skin_blurb.rpak"
        visible                 0

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_RIGHT
        pin_to_sibling_corner	TOP_RIGHT
    }

    StickerListPanel
    {
        ControlName				GridButtonListPanel
		xpos                    242
        ypos                    151
        columns                 4
        rows                    4
        buttonSpacing           6
        scrollbarSpacing        10
        scrollbarOnLeft         0
        visible					1
        tabPosition             1

        ButtonSettings
        {
            rui                     "ui/card_badge_button.rpak"
            clipRui                 1
            wide					140
            tall					140
            cursorVelocityModifier  0.7
            sound_focus             "UI_Menu_Focus_Small"
            rightClickEvents		1
			doubleClickEvents       1
			middleClickEvents       1
			bubbleNavEvents         1
        }
    }

    ModelRotateMouseCapture
    {
        ControlName				CMouseMovementCapturePanel
        xpos                    846
        ypos                    0
        wide                    1194
        tall                    %100
    }
}
