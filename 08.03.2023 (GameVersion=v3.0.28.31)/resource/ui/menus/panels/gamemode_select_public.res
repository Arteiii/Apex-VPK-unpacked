"resource/ui/menus/panels/gamemode_select_public.res"
{
		ScreenFrame
        {
            ControlName				Label
            wide					%100
            tall					%100
            labelText				""
            bgcolor_override        "0 0 0 0"
            visible				    0
            paintbackground         1
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER
        }
		PanelFrame
        {
            ControlName				Label
            wide					1920
            tall					%100
            labelText				""
            bgcolor_override        "0 0 0 0"
            visible				    0
            paintbackground         1
            pin_to_sibling			ScreenFrame
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER
        }

        DisabledCover
        {
            ControlName				RuiPanel
            xpos					0
            ypos					0
            zpos					9
            wide					%100
            tall					%100
            visible					1
            enabled 				1
            scaleImage				1
            rui                     "ui/modal_background.rpak"

            pin_to_sibling			ScreenFrame
            pin_corner_to_sibling	CENTER
            pin_to_sibling_corner	CENTER

            ruiArgs
            {
                useAnimation    1
                alpha           0.8

            }
        }

        Header
        {
            ControlName				RuiPanel
            wide					1920
            tall					145
            xpos                    0
            ypos                    0
            zpos                    10
            rui                     "ui/gamemode_header.rpak"
            visible					1

            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_LEFT
        }

		//
		// Survival
		//
		SurvivalCategory
        {
            ControlName				RuiPanel
            wide					799
            tall					37
            xpos                    0
            ypos                    0
            zpos                    5
            rui                     "ui/gamemode_category.rpak"
            visible					1

            pin_to_sibling			GameModeButtonBg
            pin_corner_to_sibling	BOTTOM_LEFT
            pin_to_sibling_corner	TOP_LEFT
            ruiArgs
	        {
	            useAnimation    1
	        }
        }
        GameModeButtonBg
        {
            ControlName				RuiPanel
            wide					457
            tall					572
            xpos                    -48
            ypos                    -280
            zpos                    8
            visible					1
            rui					    "ui/gamemode_select_button.rpak"

			ruiArgs
			{
				isLarge         1
				isSurvival      1
				useAnimation    1

			}

            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_LEFT
        }
		//Trios
        GameModeButton2
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					361
            tall					124
            xpos                    0
            ypos                    -142
            zpos                    9
            rui                     "ui/gamemode_select_flat_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"
			tabPosition             1

            navUp                   GameModeButton8
            navRight                GameModeButton5
            navDown                 GameModeButton3
            navLeft                 GameModeButton8

            pin_to_sibling			GameModeButtonBg
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	TOP

            ruiArgs
            {
                useAnimation    1
            }
        }
		//Duos
        GameModeButton3
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					361
            tall					124
            xpos                    0
            ypos                    12
            zpos                    9
            rui                     "ui/gamemode_select_flat_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            navUp                   GameModeButton2
            navRight                GameModeButton5
            navDown                 GameModeButton4
            navLeft                 GameModeButton8

            pin_to_sibling			GameModeButton2
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	BOTTOM

            ruiArgs
            {
                useAnimation    1
            }
        }
		//solos
        GameModeButton4
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					361
            tall					124
            xpos                    0
            ypos                    -36
            zpos                    7
            rui                     "ui/gamemode_select_flat_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            navUp                   GameModeButton3
            navRight                GameModeButton5
            navLeft                 GameModeButton8

            pin_to_sibling			GameModeButtonBg
            pin_corner_to_sibling	BOTTOM
            pin_to_sibling_corner	BOTTOM

            ruiArgs
            {
                useAnimation    1
            }
        }
		//
		// Ranked Survival
		//
        GameModeButton5
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					330
            tall					572     // 340 + 24 + 340
            xpos                    12
            zpos                    5
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            navLeft                 GameModeButton2
            navUp                   GameModeButton8
            navRight                GameModeButton6

            pin_to_sibling			GameModeButtonBg
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_RIGHT

            ruiArgs
            {
                isLarge         1
                isSurvival      1
                useAnimation    1

            }
        }

		//
        // MIXTAPE
        //
        MixtapeCategory
        {
            ControlName				RuiPanel
            wide					330
            tall					37
            xpos                    0
            ypos                    0
            zpos                    4
            rui                     "ui/gamemode_category.rpak"
            visible					1

            pin_to_sibling			GameModeButton6
            pin_corner_to_sibling	BOTTOM_LEFT
            pin_to_sibling_corner	TOP_LEFT
            ruiArgs
            {
                useAnimation    1
            }
        }
		//
		// LTMs
		//
        GameModeButton6
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					330
            tall					572
            xpos                    12
            ypos                    0
            zpos                    3
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            navLeft                 GameModeButton5
            navUp                   GameModeButton8
            navRight                GameModeButton7

            pin_to_sibling			GameModeButton5
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner   TOP_RIGHT

            ruiArgs
            {
                isLarge         1
                isArena         1
                useAnimation    1
            }
        }

        GameModeButton7
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					330
            tall					572
            xpos                    12
            ypos                    0
            zpos                    2
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            navLeft                 GameModeButton6
            navUp                   GameModeButton8
            navRight                GameModeButton0

            pin_to_sibling			GameModeButton6
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner   TOP_RIGHT

            ruiArgs
            {
                isLarge         1
                useAnimation    1
                isLimitedTime           1
            }
        }


		PracticeCategory
        {
            ControlName				RuiPanel
            wide					330
            tall					37
            xpos                    0
            ypos                    0
            zpos                    4
            rui                     "ui/gamemode_category.rpak"
            visible					1

            pin_to_sibling			GameModeButton0
            pin_corner_to_sibling	BOTTOM_LEFT
			pin_to_sibling_corner	TOP_LEFT
			ruiArgs
			{
			   useAnimation    1
		 	}
        }
		//
        //Training
        //
        GameModeButton0
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					330
            tall					280
            xpos                    12
            ypos                    0
            zpos                    11
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            ruiArgs
            {
                lockIconEnabled 0
                useAnimation    1
                isLarge         1
                isPractice      1
            }


            navUp                   GameModeButton8
            navDown                 GameModeButton1
            navLeft                 GameModeButton7

            pin_to_sibling			GameModeButton7
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	TOP_RIGHT
        }
        //
        //Firing Range
        //
        GameModeButton1
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					330
            tall					280
            xpos                    0
            ypos                    12
            zpos                    8
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            ruiArgs
            {
                lockIconEnabled 0
                useAnimation    1
                isLarge         1
                isPractice      1
            }


            navUp                 GameModeButton0
            navLeft                 GameModeButton7

            pin_to_sibling			GameModeButton0
            pin_corner_to_sibling	TOP_LEFT
            pin_to_sibling_corner	BOTTOM_LEFT
        }

		//
        //Event Playlist
        //
        GamemodeButton8
        {
            ControlName				RuiButton
            classname               "MenuButton"
            wide					247
            wide_nx_handheld		309		[$NX || $NX_UI_PC]
            tall					108
            tall_nx_handheld		135		[$NX || $NX_UI_PC]
            xpos                    -48
            ypos                    -110
            zpos                    10
            rui                     "ui/gamemode_select_button.rpak"
            labelText               ""
            visible					1
            cursorVelocityModifier  0.7
            cursorPriority          1
            cursorPriority          1
            sound_accept            "UI_Menu_GameMode_Select"

            ruiArgs
            {
                lockIconEnabled 0
                useAnimation    1
            }


            navDown                 GameModeButton0

            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	TOP_RIGHT
            pin_to_sibling_corner	TOP_RIGHT
        }
		//
        // LTM
        //
        LTMCategory
        {
            ControlName				RuiPanel
            wide					330
            tall					37
            xpos                    0
            ypos                    0
            zpos                    5
            rui                     "ui/gamemode_category.rpak"
            visible					1
            pin_to_sibling			GameModeButton7
            pin_corner_to_sibling	BOTTOM_LEFT
            pin_to_sibling_corner	TOP_LEFT
            ruiArgs
            {
                useAnimation    1
            }
        }

                            
				TournamentConnectButton
				{
		            ControlName				RuiButton
					classname               MenuButton
					xpos                    -50
					ypos                    -84
		            wide					106
		            tall					106
		            zpos                    10
		            rui                     "ui/generic_icon_button.rpak"
		            labelText               ""
		            visible					0
		            cursorVelocityModifier  0.7
		            cursorPriority          1

					sound_focus             "UI_Menu_Focus_Small"

		            pin_to_sibling			PanelFrame
		            pin_corner_to_sibling	TOP_RIGHT
		            pin_to_sibling_corner	TOP_RIGHT

		            ruiArgs
                    {
                        useAnimation    1
                    }
				}
        
                  
		        CraftingPreview
                {
                    ControlName				RuiButton
                    wide					820
                    wide_nx_handheld		850		[$NX || $NX_UI_PC]
                    tall					175 // 80 + 340 + 24 + 340 + 48
                    tall_nx_handheld		201		[$NX || $NX_UI_PC]
                    xpos                    -47
                    xpos_nx_handheld        -12		[$NX || $NX_UI_PC]
                    ypos                    18
                    ypos_nx_handheld        35		[$NX || $NX_UI_PC]
                    zpos                    5
                    rui                     "ui/crafting_game_mode_preview.rpak"
                    labelText               ""
                    visible					1

                    pin_to_sibling			PanelFrame
                    pin_corner_to_sibling	BOTTOM_RIGHT
                    pin_to_sibling_corner	BOTTOM_RIGHT

                    ruiArgs
                    {
                        useAnimation    1
                    }
                }
        
		MixtapePreview
        {
            ControlName				RuiPanel
            wide					625 // 48 + 340 + 48 + 48
            tall					175 // 80 + 340 + 24 + 340 + 48
            xpos                    -5
            ypos                    10
            zpos                    5
            rui                     "ui/gamemode_mixtape_rotation.rpak"
            labelText               ""
            visible					0

            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	BOTTOM_RIGHT
            pin_to_sibling_corner	BOTTOM_RIGHT
            ruiArgs
            {
                useAnimation    1
            }
        }
		PlaylistWarning
        {
            ControlName            Label
            auto_wide_tocontents   1
            tall                   27
            visible                1
            labelText              ""
            font                   DefaultBold_27_DropShadow
            allcaps                0
            fgcolor_override       "222 222 222 255"
            ypos                   10
            xpos                   0
            zpos                   5
            pin_to_sibling         GameModeButtonBg
            pin_corner_to_sibling  TOP_LEFT
            pin_to_sibling_corner  BOTTOM_LEFT
        }
		CloseButton
        {
            ControlName             BaseModHybridButton
            xpos					0
            ypos					0
            wide					%100
            tall					%100
            labelText               ""
            visible                 1
            sound_accept            "UI_Menu_SelectMode_Close"
        }

}