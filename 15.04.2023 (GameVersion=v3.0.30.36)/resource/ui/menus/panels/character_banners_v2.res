"resource/ui/menus/panels/character_banners_v2.res"
{
    PanelFrame
    {
		ControlName				Label
		wide					%100
		tall					%100
		labelText				""
        bgcolor_override        "0 0 0 0"
		visible				    0
        paintbackground         1
    }
	TabsFrame
    {
		ControlName				Label
		wide					1920
		tall					%100
		labelText				""
        bgcolor_override        "0 0 0 0"
		visible				    0
        paintbackground         1
        pin_corner_to_sibling    TOP
        pin_to_sibling_corner    TOP
    }
    TabsBackground
    {
        ControlName				RuiPanel
		InheritProperties		TabsBackgroundShort
        zpos					999

        pin_to_sibling           TabsFrame
        pin_corner_to_sibling    TOP
        pin_to_sibling_corner    TOP
    }
	TabsCommon
    {
          ControlName           CNestedPanel
		  classname				"TabsCommonClass"
          zpos                  1000
          ypos                  0
          wide                  %100
          tall                  44
          visible               1
          controlSettingsFile   "resource/ui/menus/panels/common_tabs_short.res"

          pin_to_sibling         TabsFrame
          pin_corner_to_sibling    TOP
          pin_to_sibling_corner    TOP
    }
    Header
    {
        ControlName             RuiPanel
        xpos                    163 //22
        ypos                    0//64
        zpos                    4
        wide                    550
        tall                    33
        rui                     "ui/character_items_header.rpak"

		pin_to_sibling           TabsCommon
		pin_corner_to_sibling    BOTTOM
		pin_to_sibling_corner    TOP
    }

	SkinBlurb
    {
        ControlName             RuiPanel
        xpos                    -96
        ypos                    -143
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

    CardFramesPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld    	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/card_frames.res"
    }

    CardPosesPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld    	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/card_poses.res"
    }

    CardBadgesPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld   	 	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        tall_nx_handheld		800  [$NX || $NX_UI_PC]
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/card_badges.res"
    }

    CardTrackersPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld    	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/card_trackers.res"
    }

    IntroQuipsPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld    	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/quips.res"
    }

    KillQuipsPanel
    {
        ControlName				CNestedPanel
		classname				"TabPanelClass"
        xpos					399
        xpos_nx_handheld		411  [$NX || $NX_UI_PC]
		ypos			    	125
		ypos_nx_handheld    	80	 [$NX || $NX_UI_PC]
        wide					1408
        tall					840
        visible					1
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/quips.res"
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//    DebugBG
//    {
//        ControlName				Label
//        wide					800
//        tall					800
//        labelText				""
//        bgcolor_override		"70 70 70 100"
//        visible					1
//        paintbackground			1
//
//        pin_to_sibling			CombinedCard
//        pin_corner_to_sibling	TOP_LEFT
//        pin_to_sibling_corner	TOP_LEFT
//    }
    CombinedCard
    {
        ControlName				RuiPanel
        xpos                    -820
        xpos_nx_handheld        -1065 		[$NX || $NX_UI_PC]
        ypos                    -44
        ypos_nx_handheld        -15	 		[$NX || $NX_UI_PC]
        wide					850 //800
        wide_nx_handheld		870 		[$NX || $NX_UI_PC]//800
        tall					850 //800
        tall_nx_handheld		870 		[$NX || $NX_UI_PC]//800
        rui                     "ui/combined_card.rpak"
        visible					1

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }
}
