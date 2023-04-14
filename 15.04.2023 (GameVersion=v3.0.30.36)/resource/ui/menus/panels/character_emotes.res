"resource/ui/menus/panels/character_emotes.res"
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
          tall                  48
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
        ypos                    64
        zpos                    4
        wide                    550
        tall                    33
        rui                     "ui/character_items_header.rpak"
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    LinePanel
    {
        ControlName				CNestedPanel
        xpos					289
        xpos_nx_handheld		36			[$NX || $NX_UI_PC]
        ypos					116
        ypos_nx_handheld		80			[$NX || $NX_UI_PC]
        wide					550
		wide_nx_handheld		800			[$NX || $NX_UI_PC]
        tall					840
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/quips.res"
        zpos                    100
		
        pin_to_sibling_nx_handheld			SectionButton0		[$NX || $NX_UI_PC]
        pin_corner_to_sibling_nx_handheld	TOP_LEFT			[$NX || $NX_UI_PC]
        pin_to_sibling_corner_nx_handheld	TOP_RIGHT			[$NX || $NX_UI_PC]
    }

    EmotesPanel
    {
        ControlName				CNestedPanel
        xpos					289
        xpos_nx_handheld		36			[$NX || $NX_UI_PC]
        ypos					116
        ypos_nx_handheld		80			[$NX || $NX_UI_PC]
        wide					550
		wide_nx_handheld		800			[$NX || $NX_UI_PC]
        tall					840
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/emotes.res"
        zpos                    100
		
        pin_to_sibling_nx_handheld			SectionButton0		[$NX || $NX_UI_PC]
        pin_corner_to_sibling_nx_handheld	TOP_LEFT			[$NX || $NX_UI_PC]
        pin_to_sibling_corner_nx_handheld	TOP_RIGHT			[$NX || $NX_UI_PC]
    }

    HoloSpraysPanel
    {
        ControlName				CNestedPanel
        xpos					289
        xpos_nx_handheld		36			[$NX || $NX_UI_PC]
        ypos					116
        ypos_nx_handheld		80			[$NX || $NX_UI_PC]
        wide					550
        wide_nx_handheld		800			[$NX || $NX_UI_PC]
        tall					840
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/emotes.res"
        zpos                    100

        pin_to_sibling_nx_handheld			SectionButton0		[$NX || $NX_UI_PC]
        pin_corner_to_sibling_nx_handheld	TOP_LEFT			[$NX || $NX_UI_PC]
        pin_to_sibling_corner_nx_handheld	TOP_RIGHT			[$NX || $NX_UI_PC]
    }

	SkydiveEmotesPanel
	{
        ControlName				CNestedPanel
        xpos					289
        xpos_nx_handheld		36			[$NX || $NX_UI_PC]
        ypos					116
        ypos_nx_handheld		80			[$NX || $NX_UI_PC]
        wide					750
		wide_nx_handheld		800			[$NX || $NX_UI_PC]
        tall					840
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/skydive_emotes.res"
        zpos                    100
		ruiClip                 0
        pin_to_sibling_nx_handheld			SectionButton0		[$NX || $NX_UI_PC]
        pin_corner_to_sibling_nx_handheld	TOP_LEFT			[$NX || $NX_UI_PC]
        pin_to_sibling_corner_nx_handheld	TOP_RIGHT			[$NX || $NX_UI_PC]
	}
    SkinBlurb
    {
        ControlName             RuiPanel
        xpos                    -96
        ypos                    -650
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
    ModelRotateMouseCapture
    {
        ControlName				CMouseMovementCapturePanel
        xpos                    700
        ypos                    0
        wide                    1340
        tall                    %100
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	HintGamepad
	{
		ControlName			    RuiPanel
        ypos				    -650
        xpos				    -312
		xpos_nx_handheld		-790		[$NX || $NX_UI_PC]
		zpos			        3
		wide			        492
		tall			        196
		tall_nx_handheld        296			[$NX || $NX_UI_PC]
		visible			        1
		labelText               ""
        rui					    "ui/character_section_button.rpak"
        activeInputExclusivePaint	gamepad

        ruiArgs
        {
            textBreakWidth 400.0
        }

        pin_to_sibling			TabsFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
	}

	HintMKB
	{
		ControlName			    RuiPanel
        ypos				    -650
        xpos				    -312
		xpos_nx_handheld		-790		[$NX || $NX_UI_PC]
		zpos			        3
		wide			        492
		tall			        196
		tall_nx_handheld        296			[$NX || $NX_UI_PC]
		visible			        1
		labelText               ""
        rui					    "ui/character_section_button.rpak"
		activeInputExclusivePaint		keyboard

		ruiArgs
		{
		    textBreakWidth 400.0
        }

        pin_to_sibling			TabsFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
	}
}
