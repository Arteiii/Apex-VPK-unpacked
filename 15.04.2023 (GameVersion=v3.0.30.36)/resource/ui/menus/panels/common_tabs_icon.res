resource/ui/menus/panels/common_tabs_short.res
{
    Anchor
    {
		ControlName				Label
		wide					%100
		tall					%100
		labelText				""
		visible				    1
        bgcolor_override        "0 0 0 0"
        paintbackground         1
    }

	LeftNavButton
    {
        ControlName				RuiPanel
        xpos                    0
        wide                    76
        tall					28
        visible					1
        rui                     "ui/shoulder_navigation_shortcut_angle.rpak"
        activeInputExclusivePaint	gamepad

        pin_to_sibling			Tab0
        pin_corner_to_sibling	RIGHT
        pin_to_sibling_corner	LEFT
    }
	Tab0
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				0
		xpos                    0

		pin_to_sibling			Anchor
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP
	}

	Tab1
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				1

		pin_to_sibling			Tab0
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab2
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				2

		pin_to_sibling			Tab1
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab3
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				3

		pin_to_sibling			Tab2
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab4
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				4

		pin_to_sibling			Tab3
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab5
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				5

		pin_to_sibling			Tab4
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab6
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				6

		pin_to_sibling			Tab5
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	Tab7
	{
		ControlName				RuiButton
		InheritProperties		TabButtonIcon
		scriptID				7

		pin_to_sibling			Tab6
		pin_corner_to_sibling	TOP_LEFT
		pin_to_sibling_corner	TOP_RIGHT
	}

	RightNavButton
    {
        ControlName				RuiPanel
        xpos                    0
        wide                    76
        tall					28

        visible					1
        rui                     "ui/shoulder_navigation_shortcut_angle.rpak"
        activeInputExclusivePaint	gamepad

        pin_to_sibling			Tab7
        pin_corner_to_sibling	LEFT
        pin_to_sibling_corner	RIGHT
    }
}