"resource/ui/menus/panels/characters.res"
{
    PanelFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					1920
		tall					%100
		labelText				""
		visible				    1
        bgcolor_override        "0 0 0 0"
        paintbackground         1

        proportionalToParent    1
    }

    ActionLabel
    {
        ControlName				Label
        auto_wide_tocontents 	1
        auto_tall_tocontents 	1
        visible					0
        labelText				"This is a Label"
        fgcolor_override		"220 220 220 255"
        fontHeight              36
        fontHeight_nx_handheld  48			[$NX || $NX_UI_PC]
        ypos                    420
        ypos_nx_handheld        650			[$NX || $NX_UI_PC]
        xpos                    -178

        pin_to_sibling			CharacterSelectInfo
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }

    CharacterSelectInfo
    {
        ControlName		        RuiPanel
        xpos                    -150
                   
        ypos                    -30
        ypos_nx_handheld        -30			[$NX || $NX_UI_PC]
     
                                    
                                                        
      
        wide                    740
        tall                    153
        visible			        1
        rui                     "ui/character_select_info.rpak"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }

    LobbyClassPerkInfo
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    125
        wide                    1920
        tall                    %100
        visible			        1
        rui                     "ui/character_select_class_name_plate.rpak"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }

    LobbyClassLegendInfo
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    0
        wide                    1920
        tall                    %100
        visible			        1
        rui                     "ui/lobby_character_screen_name_plate.rpak"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_LEFT
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Anchor
    {
        ControlName             Label

        labelText               ""
                   
            xpos                    300
            ypos                    210
            ypos_nx_handheld        320			[$NX || $NX_UI_PC]
     
                                       
                                       
                                                            
      
        xpos_nx_handheld        640			[$NX || $NX_UI_PC]
        
        wide					50
        tall                    50
        //bgcolor_override		"0 255 0 100"
        //paintbackground			1
    }

    CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
        tabPosition             1
    }
    CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		LobbyCharacterButton
    }
    CharacterButton12
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton13
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton14
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton15
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton16
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton17
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton18
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton19
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton20
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton21
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton22
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton23
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton24
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton25
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton26
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton27
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton28
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
    CharacterButton29
    {
        ControlName             RuiButton
        InheritProperties       LobbyCharacterButton
    }
//Assault Class List

    Top_List_Anchor
    {
        ControlName				Label
        xpos					-700
        ypos					-282
        ypos_nx_handheld			-300		[$NX || $NX_UI_PC]
        wide					1
        tall					1
        visible					0
        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	BOTTOM
    }

    Assault_CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

    Assault_CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterAssaultButton
        pin_to_sibling			Top_List_Anchor
    }

//Skirmisher Class List

    Skirmisher_CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

    Skirmisher_CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSkirmisherButton
        pin_to_sibling			Top_List_Anchor
    }

//Recon Class List

    Bot_List_Anchor
    {
        ControlName					Label
        xpos						-900
        ypos						-143
        ypos_nx_handheld				-150		[$NX || $NX_UI_PC]
        wide						1
        tall						1
        visible						0
        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	BOTTOM
    }

    Recon_CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

    Recon_CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterReconButton
        pin_to_sibling			Bot_List_Anchor
    }

//Defense Class List

    Defense_CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

    Defense_CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterDefenseButton
        pin_to_sibling			Bot_List_Anchor
    }

//Support Class List

    Support_CharacterButton0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

    Support_CharacterButton11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterSupportButton
        pin_to_sibling			Bot_List_Anchor
    }

                   
    assaultShelf
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    6
        wide                    %100
        tall                    %100
        visible			        1
        rui                     "ui/character_button_shelf.rpak"

        pin_to_sibling			Top_List_Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }

    SkirmisherShelf
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    6
        wide                    %100
        tall                    %100
        visible			        1
        rui                     "ui/character_button_shelf.rpak"

        pin_to_sibling			Top_List_Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }

    reconShelf
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    6
        wide                    %100
        tall                    %100
        visible			        1
        rui                     "ui/character_button_shelf.rpak"

        pin_to_sibling			Bot_List_Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }

    supportShelf
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    6
        wide                    %100
        tall                    %100
        visible			        1
        rui                     "ui/character_button_shelf.rpak"

        pin_to_sibling			Bot_List_Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }

    controllerShelf
    {
        ControlName		        RuiPanel
        xpos                    0
        ypos                    6
        wide                    %100
        tall                    %100
        visible			        1
        rui                     "ui/character_button_shelf.rpak"

        pin_to_sibling			Bot_List_Anchor
        pin_corner_to_sibling	CENTER
        pin_to_sibling_corner	CENTER
    }
      
}

