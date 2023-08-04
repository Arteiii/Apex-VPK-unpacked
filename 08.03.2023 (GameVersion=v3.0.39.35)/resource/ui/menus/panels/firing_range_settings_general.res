"resource/ui/menus/panels/firing_range_settings_general.res"
{
	ScreenFrame
    {
        ControlName				ImagePanel
        xpos					0
        ypos					0
        wide					%100
        tall					%100
        visible					1
        enabled 				1
        scaleImage				1
        image					"vgui/HUD/white"
        drawColor				"0 0 0 0"
    }


	ModeOptionsPanel
    {
        ControlName			    CNestedPanel
        InheritProperties       SettingsTabPanel

		visible                 1
        pin_to_sibling			ScreenFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP

        ScrollFrame
        {
            ControlName				ImagePanel
            InheritProperties       SettingsScrollFrame
        }

        ScrollBar
        {
            ControlName				RuiButton
            InheritProperties       SettingsScrollBar

            pin_to_sibling			ScrollFrame
            pin_corner_to_sibling	TOP_RIGHT
            pin_to_sibling_corner	TOP_RIGHT
        }

        ContentPanel
        {
            ControlName				CNestedPanel
            InheritProperties       SettingsContentPanel
			tall                    1780
			visible                 1
            tabPosition             1

			SwitchDynamicStats
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navDown					SwitchDynamicTimer
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchDynamicTimer
	        {
	            ControlName				RuiButton
	            InheritProperties		SwitchButton
	            className               "SettingScrollSizer"
	            style					DialogListButton
	            navUp                   SwitchDynamicStats
	            navDown					SwitchInfiniteAmmo
	            list
	            {
	                "#SETTING_OFF"	0
	                "#SETTING_ON"	1
	            }
	            pin_to_sibling			SwitchDynamicStats
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
	            childGroupAlways        ChoiceButtonAlways
	        }
            SwitchInfiniteAmmo
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDynamicTimer
                navDown					SwitchHitIndicators
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }
				pin_to_sibling			SwitchDynamicTimer
				pin_corner_to_sibling	TOP_LEFT
				pin_to_sibling_corner	BOTTOM_LEFT
				childGroupAlways        ChoiceButtonAlways
            }
            SwitchHitIndicators
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchInfiniteAmmo
                navDown					Switch3rdPerson
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }
                pin_to_sibling			SwitchInfiniteAmmo
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            Switch3rdPerson
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchHitIndicators
                navDown					SwitchFriendlyFire
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }
                pin_to_sibling			SwitchHitIndicators
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }

            SwitchFriendlyFire
	        {
	            ControlName				RuiButton
	            InheritProperties		SwitchButton
	            className               "SettingScrollSizer"
	            style					DialogListButton
	            navUp					Switch3rdPerson
	            navDown					SwitchTargetSpeed
	            list
	            {
	                "#SETTING_OFF"	0
	                "#SETTING_ON"	1
	            }

	            pin_to_sibling			Switch3rdPerson
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
	            childGroupAlways        ChoiceButtonAlways
	        }
	        SwitchTargetSpeed
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchFriendlyFire
                navDown					SwitchDummieShield
                list
                {
                    "#FR_TARGETSPEED_NAME_1"    1
                    "#FR_TARGETSPEED_NAME_2"	2
                    "#FR_TARGETSPEED_NAME_3"	3
                    "#FR_TARGETSPEED_NAME_4"	4
                }

                pin_to_sibling			SwitchFriendlyFire
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        MultiChoiceButtonAlways
            }
            DummieSettingsHeader
            {
                ControlName				ImagePanel
                InheritProperties		SubheaderBackgroundWide
                className               "SettingScrollSizer"
                xpos					0
                ypos					6
                pin_to_sibling			SwitchTargetSpeed
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
           }
           DummieSettingsHeaderText
           {
                ControlName				Label
                InheritProperties		SubheaderText
                pin_to_sibling			DummieSettingsHeader
                pin_corner_to_sibling	LEFT
                pin_to_sibling_corner	LEFT
                use_pin_locale_direction    1
                labelText				"#FRSETTING_LABEL_DUMMIES_SETTINGS"
           }
           SwitchDummieShield
           {
               ControlName				RuiButton
               InheritProperties		SwitchButton
               className               "SettingScrollSizer"
               style					DialogListButton
               navUp					SwitchTargetSpeed
               navDown					SwitchDummieMovement
               list
               {
                   "#LOOT_TIER1"    1
                   "#LOOT_TIER2"	2
                   "#LOOT_TIER3"	3
                   "#LOOT_TIER5"	4
               }
               pin_to_sibling			DummieSettingsHeader
               pin_corner_to_sibling	TOP_LEFT
               pin_to_sibling_corner	BOTTOM_LEFT
               childGroupAlways        MultiChoiceButtonAlways
           }
           SwitchDummieHelmetMatchShields
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDummieShield
                navDown					SwitchDummieMovement
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			SwitchDummieShield
                   pin_corner_to_sibling	TOP_LEFT
                   pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
           SwitchDummieMovement
           {
               ControlName				RuiButton
               InheritProperties		SwitchButton
               className               "SettingScrollSizer"
               style					DialogListButton
               navUp					SwitchDummieHelmetMatchShields
               navDown					SwitchDummieStance
               list
               {
                   "#DUMMIE_MOVEMENT_STAYINPLACE"   0
                   "#DUMMIE_MOVEMENT_STRAFECONST"   1
                   "#DUMMIE_MOVEMENT_STRAFERANDOM"  2
                   "#DUMMIE_MOVEMENT_RANDOM"        3
               }
               pin_to_sibling			SwitchDummieHelmetMatchShields
               pin_corner_to_sibling	TOP_LEFT
               pin_to_sibling_corner	BOTTOM_LEFT
               childGroupAlways        MultiChoiceButtonAlways
           }
            SwitchDummieStance
           {
              ControlName				RuiButton
              InheritProperties		    SwitchButton
              className               "SettingScrollSizer"
              style					    DialogListButton
              navUp					    SwitchDummieMovement
              navDown				    SwitchDummieSpeed
              list
              {
                  "#DUMMIE_STATE_STAND"    0
                  "#DUMMIE_STATE_CROUCH"   1
                  "#DUMMIE_STATE_RANDOM"   2
              }
              pin_to_sibling			SwitchDummieMovement
              pin_corner_to_sibling	TOP_LEFT
              pin_to_sibling_corner	BOTTOM_LEFT
              childGroupAlways        MultiChoiceButtonAlways
          }
          SwitchDummieSpeed
          {
              ControlName				RuiButton
              InheritProperties		SwitchButton
              className               "SettingScrollSizer"
              style					DialogListButton
              navUp					SwitchDummieStance
                                 
              navDown				SwitchDummieShooting
                    
              list
              {
                  "#FRSETTING_DUMMIESTRAFESPEED_NAME_1"   1
                  "#FRSETTING_DUMMIESTRAFESPEED_NAME_2"   2
                  "#FRSETTING_DUMMIESTRAFESPEED_NAME_3"   3
              }
              pin_to_sibling			SwitchDummieStance
              pin_corner_to_sibling	TOP_LEFT
              pin_to_sibling_corner	BOTTOM_LEFT
              childGroupAlways        MultiChoiceButtonAlways
         }
                           
	        SwitchDummieShooting
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDummieSpeed
                navDown					SwitchDummieSpawnDists
                list
                {
                    "#DUMMIE_SHOOTING_OFF"          0
                    "#DUMMIE_SHOOTING_EASY"	        1
                    "#DUMMIE_SHOOTING_MEDIUM"	    2
                    "#DUMMIE_SHOOTING_HARD"	        3
                    "#DUMMIE_SHOOTING_FULLCOMBAT"   4
                }
                pin_to_sibling			SwitchDummieSpeed
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        MultiChoiceButtonAlways
            }
            DynamicDummiesHeader
             {
                 ControlName				ImagePanel
                 InheritProperties		SubheaderBackgroundWide
                 className               "SettingScrollSizer"
                 xpos					0
                 ypos					6

                 pin_to_sibling			SwitchDummieShooting
                 pin_corner_to_sibling	TOP_LEFT
                 pin_to_sibling_corner	BOTTOM_LEFT
             }
             DynamicDummiesHeaderText
             {
                 ControlName				Label
                 InheritProperties		SubheaderText
                 pin_to_sibling			DynamicDummiesHeader
                 pin_corner_to_sibling	LEFT
                 pin_to_sibling_corner	LEFT
                 use_pin_locale_direction    1
                 labelText				"#DYNDUMMIE_SETTINGS_SECTION_LABEL"
            }
	        SwitchDynDummieSpawn
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }
                navUp					SwitchDummieShooting
                navDown					SwitchDummieSpawnDists

                pin_to_sibling			DynamicDummiesHeader
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchDummieSpawnDists
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDynDummieSpawn
                navDown					SwitchCombatRefreshDummies
                list
                {
                    "#DUMMIE_SPAWNDISTS_CQB"        0
                    "#DUMMIE_SPAWNDISTS_MID"	    1
                    "#DUMMIE_SPAWNDISTS_FAR"	    2
                    "#DUMMIE_SPAWNDISTS_VFAR"	    3
                    "#DUMMIE_SPAWNDISTS_RANDOM"	    4
                }
                pin_to_sibling			SwitchDynDummieSpawn
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        MultiChoiceButtonAlways
            }
            CombatRangeDummiesHeader
            {
                ControlName				ImagePanel
                InheritProperties		SubheaderBackgroundWide
                className               "SettingScrollSizer"
                xpos					0
                ypos					6

                pin_to_sibling			SwitchDummieSpawnDists
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
            CombatRangeDummiesHeaderText
            {
                ControlName				Label
                InheritProperties		SubheaderText
                pin_to_sibling			CombatRangeDummiesHeader
                pin_corner_to_sibling	LEFT
                pin_to_sibling_corner	LEFT
                use_pin_locale_direction    1
                labelText				"#RESET_FUNCS_SECTION_LABEL"
            }
            SwitchCombatRefreshDummies
            {
                ControlName				RuiButton
                InheritProperties		SettingBasicButton
                className               "SettingScrollSizer"
                navUp					SwitchDynDummieSpawn
                navDown					SwitchCombatClearAndSpawnNewDummies

                pin_to_sibling			CombatRangeDummiesHeader
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
            SwitchCombatClearAndSpawnNewDummies
            {
                ControlName				RuiButton
                InheritProperties		SettingBasicButton
                className               "SettingScrollSizer"

                pin_to_sibling			SwitchCombatRefreshDummies
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
                                 
	        SwitchResetDoors
            {
                ControlName				RuiButton
                InheritProperties		SettingBasicButton
                className               "SettingScrollSizer"

                pin_to_sibling			SwitchCombatClearAndSpawnNewDummies
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
                                       
                                  
        }
    }
}