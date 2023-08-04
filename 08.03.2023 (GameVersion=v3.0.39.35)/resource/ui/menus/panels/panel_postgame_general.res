"resource/ui/menus/panels/panel_postgame_general.res"
{
    ScreenFrame
    {
        ControlName				Label
        wide			        %100
        tall			        %100
        labelText				""
        visible					0
    }

    CombinedCard
    {
        ControlName				RuiPanel

        xpos                    48
        xpos_nx_handheld        225			[$NX || $NX_UI_PC]
        ypos                    "%-12"
        ypos_nx_handheld        "%-15"		[$NX || $NX_UI_PC]

        wide					850
        wide_nx_handheld		870			[$NX || $NX_UI_PC]
        tall					850
        tall_nx_handheld		870   		[$NX || $NX_UI_PC]
        rui                     "ui/combined_card.rpak"
        visible					1

        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP
    }

    MenuFrame
    {
        ControlName				Label
        xpos					0
        xpos_nx_handheld		300			[$NX || $NX_UI_PC]
        ypos					c-420
        wide					%100
        tall					906
        labelText				""
        bgcolor_override		"70 70 70 0"
        visible					1
        paintbackground			1
    }

    Divider
    {
        ControlName				ImagePanel
        wide					%75
        ypos                    -60
        tall                    2
        visible				    1
        image                   "vgui/gradient_center"
        drawColor               "255 255 255 0"
        scaleImage              1
        pin_to_sibling			MenuFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }

    BadgeEarned
    {
        ControlName		        RuiPanel

        rui                     "ui/badge_earned_box.rpak"
        xpos                    48
        ypos                    "%-12"
        wide                    850
        tall                    850
        visible                 1

        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	TOP_RIGHT
        pin_to_sibling_corner	TOP
    }

    XPEarned1
    {
        ControlName				RuiPanel
        rui                     "ui/xp_earned_box.rpak"
        xpos                    6
        wide                    461
        wide_nx_handheld        625			[$NX || $NX_UI_PC]
        tall                    280
        tall_nx_handheld        350			[$NX || $NX_UI_PC]
        visible					1

        zpos                    500

        pin_to_sibling          XPEarned2
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   TOP_LEFT
    }

    XPEarned2
    {
        ControlName             RuiPanel
        rui                     "ui/xp_earned_box.rpak"
        xpos                    32
        ypos                    "%-10"
        wide                    461
        wide_nx_handheld        625			[$NX || $NX_UI_PC]
        tall                    280
        tall_nx_handheld        350			[$NX || $NX_UI_PC]
        visible                 1

        zpos                    500

        pin_to_sibling          MenuFrame
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   TOP
    }

    XPEarned3
    {
        ControlName             RuiPanel
        rui                     "ui/xp_earned_box.rpak"
        xpos                    172
        ypos                    0
        wide                    480
        wide_nx_handheld        625			[$NX || $NX_UI_PC]
        tall                    280
        tall_nx_handheld        350			[$NX || $NX_UI_PC]
        visible                 1

        zpos                    500

        pin_to_sibling          XPEarned2
        pin_corner_to_sibling   TOP_LEFT
        pin_to_sibling_corner   TOP_RIGHT
    }

    RewardDisplay
    {
        ControlName             RuiPanel
        rui                     "ui/reward_display.rpak"
        wide                    %100
        tall                    %100
        visible                 1

        zpos                    501

        pin_to_sibling          ScreenFrame
        pin_corner_to_sibling   CENTER
        pin_to_sibling_corner   CENTER
    }

    XPProgressBarAccount
    {
        ControlName				RuiPanel
        rui                     "ui/xp_progress_bars.rpak"
        xpos                    0
        ypos                    16
        ypos_nx_handheld        -43			[$NX || $NX_UI_PC]
        wide                    512
        tall                    360
        visible					1

        zpos                    500

        pin_to_sibling          XPEarned2
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   BOTTOM_RIGHT
    }

    XPProgressBarBattlePass
    {
        ControlName				RuiPanel
        rui                     "ui/xp_progress_bars.rpak"
        xpos                    0
        ypos                    16
        wide                    512
        tall                    360
        visible					0

        zpos                    500

        pin_to_sibling          XPEarned3
        pin_corner_to_sibling   TOP_RIGHT
        pin_to_sibling_corner   BOTTOM_RIGHT
    }

}