"resource/ui/menus/panels/custom_match_options_select.res"
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

    SelectOptionsSubHeader
    {
        ControlName             RuiPanel

        wide                    770
        tall                    48
        tall_nx_handheld        64			[$NX || $NX_UI_PC]
        clipRui                 1

		className               "SettingScrollSizer"
        rui                     "ui/custom_match_settings_sub_header.rpak"
        ruiArgs
        {
            headerText          "#CUSTOM_MATCH_OPTIONS_SELECT"
        }

        pin_to_sibling          PanelFrame
        pin_corner_to_sibling   TOP_LEFT
        pin_to_sibling_corner   TOP_LEFT
    }

    ChatPermissions
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"
        list
        {
            "#CUSTOM_MATCH_CHAT_MODE_ALL"       0
            "#CUSTOM_MATCH_CHAT_MODE_ADMIN"		1
        }

		wide                    770
        childGroupAlways        ChoiceButtonAlways

	    navDown					RenameTeam
        bubbleNavEvents         1


        pin_to_sibling          SelectOptionsSubHeader
        pin_corner_to_sibling   TOP_LEFT
        pin_to_sibling_corner   BOTTOM_LEFT
    }

    RenameTeam
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"
        list
        {
            "#SETTING_ON"       1
            "#SETTING_OFF"		0
        }

		wide                    770
        childGroupAlways        ChoiceButtonAlways

	    navUp					ChatPermissions
	    navDown					SelfAssign

	    pin_to_sibling			ChatPermissions
	    pin_corner_to_sibling	TOP_LEFT
	    pin_to_sibling_corner	BOTTOM_LEFT
    }

    SelfAssign
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"
        list
        {
            "#SETTING_ON"       1
            "#SETTING_OFF"		0
        }

		wide                    770
        childGroupAlways        ChoiceButtonAlways

	    navUp					RenameTeam
	    navDown					AimAssist

	    pin_to_sibling			RenameTeam
	    pin_corner_to_sibling	TOP_LEFT
	    pin_to_sibling_corner	BOTTOM_LEFT
    }

    AimAssist
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"
        list
        {
            "#SETTING_ON"       1
            "#SETTING_OFF"		0
        }

		wide                    770
        childGroupAlways        ChoiceButtonAlways

	    navUp					SelfAssign
	    navDown					AnonymousMode

	    pin_to_sibling			SelfAssign
	    pin_corner_to_sibling	TOP_LEFT
	    pin_to_sibling_corner	BOTTOM_LEFT
    }

    AnonymousMode
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"
        list
        {
            "#SETTING_ON"       1
            "#SETTING_OFF"		0
        }

		wide                    770
        childGroupAlways        ChoiceButtonAlways

	    navUp					AimAssist
	    navDown					ModeVariant

	    pin_to_sibling			AimAssist
	    pin_corner_to_sibling	TOP_LEFT
	    pin_to_sibling_corner	BOTTOM_LEFT
    }

    ModeVariant
    {
        ControlName				RuiButton
        InheritProperties		SwitchButton
        style					DialogListButton
		className               "SettingScrollSizer"

		wide                    770
        childGroupAlways        MultiChoiceButtonAlways

	    navUp					AnonymousMode
        bubbleNavEvents         1

	    pin_to_sibling			AnonymousMode
	    pin_corner_to_sibling	TOP_LEFT
	    pin_to_sibling_corner	BOTTOM_LEFT
    }
}