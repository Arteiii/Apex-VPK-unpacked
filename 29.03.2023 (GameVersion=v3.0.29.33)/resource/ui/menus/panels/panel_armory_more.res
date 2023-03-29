"resource/ui/menus/panels/panel_armory_more.res"
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
        bgcolor_override        "0 0 0 0"
        paintbackground         1
		proportionalToParent    1
    }

	ArmoryStickersBackground
    {
        ControlName				RuiPanel
        xpos					-8
        ypos					-130
        wide					650
        tall					650
        zpos					0
        visible					1
        enabled 				1
        scaleImage				1
        rui                     "ui/armory_more_category.rpak"
        drawColor				"255 255 255 1"

		ruiargs
		{
			title   #STICKERS
		}
        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_RIGHT
        pin_to_sibling_corner	TOP
    }

    HealthInjectorButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    -25
        ypos                    -100
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0


        ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_health_injector
            buttonText #HEALTH_INJECTOR
        }

        navDown                ShieldBatteryButton
        navRight               ShieldCellButton

        pin_to_sibling			ArmoryStickersBackground
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }
    ShieldCellButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    22
        ypos                    0
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

		ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_shield_cell
            buttonText #SURVIVAL_PICKUP_HEALTH_COMBO_SMALL
        }

        navDown                PhoenixKitButton
        navLeft                HealthInjectorButton
        navRight               TransitionsButton

        pin_to_sibling			HealthInjectorButton
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    ShieldBatteryButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    0
        ypos                    22
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

		ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_shield_battery
            buttonText #SURVIVAL_PICKUP_HEALTH_COMBO_LARGE
        }

	    navUp                  HealthInjectorButton
	    navRight               PhoenixKitButton

        pin_to_sibling			HealthInjectorButton
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
    PhoenixKitButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    22
        ypos                    0
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

		ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_phoenix_kit
            buttonText #SURVIVAL_PICKUP_HEALTH_COMBO_FULL
        }

        navUp                  ShieldCellButton
        navLeft                ShieldBatteryButton
        navRight               SkydiveButton

        pin_to_sibling			ShieldBatteryButton
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    //misc
    ArmoryMiscBackground
    {
        ControlName				RuiPanel
        xpos					16
        ypos					0
        wide					650
        tall					650
        zpos					0
        visible					1
        enabled 				1
        scaleImage				1
        rui                     "ui/armory_more_category.rpak"
        drawColor				"255 255 255 1"

        ruiargs
        {
            title   #MISC_CUSTOMIZATION
        }
        pin_to_sibling			ArmoryStickersBackground
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }

    TransitionsButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    -25
        ypos                    -100
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

        ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_transition_screen
            buttonText #TAB_CUSTOMIZE_LOADSCREEN
        }

        navDown                SkydiveButton
        navLeft                ShieldCellButton
        navRight               MusicButton

        pin_to_sibling			ArmoryMiscBackground
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }
    MusicButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    22
        ypos                    0
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

        ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_music_pack
            buttonText #TAB_CUSTOMIZE_MUSIC_PACK
        }

        navLeft                TransitionsButton

        pin_to_sibling			TransitionsButton
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    SkydiveButton
    {
        ControlName				RuiButton
        scriptID				6
        wide					290
        tall					230
        xpos                    0
        ypos                    22
        rui						"ui/armory_more_button.rpak"
        labelText				""
        visible                 1
        cursorVelocityModifier  0.7
        sound_focus             "UI_Menu_Focus"
        sound_accept            "UI_Menu_WeaponClass_Select"
        visible 0

        ruiArgs
        {
            buttonImage rui/menu/buttons/weapon_categories/more_skydive_trails
            buttonText #TAB_CUSTOMIZE_SKYDIVE_TRAIL
        }

        navUp                  TransitionsButton
        navLeft                PhoenixKitButton

        pin_to_sibling			TransitionsButton
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
}