resource/ui/menus/panels/character_abilities.res
{
    ScreenFrame
    {
        ControlName				Label
        wide					%100
        tall					%100
		ypos_nx_handheld		30    [$NX || $NX_UI_PC]

        labelText				""
    }

	GCard
    {
        ControlName             RuiPanel
        xpos					50
        ypos					-105
        zpos					5
        wide 					502
        wide_nx_handheld		0			[$NX || $NX_UI_PC]
        tall					866
        tall_nx_handheld		0			[$NX || $NX_UI_PC]
        rui 					"ui/gladiator_card_squadscreen.rpak"
        visible					1

        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }

    ContentRui
    {
        ControlName				RuiPanel
        rui                     "ui/character_skills_panel.rpak"
        wide			        1920 //%100
        ypos                    84
        ypos_nx_handheld		64			[$NX || $NX_UI_PC]
        tall			        870
        visible				    1

        pin_to_sibling			DarkenBackground
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }
}
