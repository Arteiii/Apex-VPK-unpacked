"resource/ui/menus/panels/character_select_portraits_new.res"
{
	PanelFrame
    {
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		visible				    1
        bgcolor_override        "0 0 0 0"
        paintbackground         1

        proportionalToParent    1
    }

    Anchor
    {
        ControlName             Label

        labelText               ""
        xpos                    1400
        xpos_nx_handheld        1220		[$NX || $NX_UI_PC]
                   
        ypos                    230
        ypos_nx_handheld        230			[$NX || $NX_UI_PC]
		
     
                             
                                                  
      
        
        wide					50
        tall                    50
        //bgcolor_override		"0 255 0 100"
        //paintbackground			1
    }

    Button0
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
        //tabPosition             1
    }
    Button1
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button2
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button3
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button4
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button5
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button6
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button7
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button8
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button9
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button10
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button11
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button12
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button13
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button14
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button15
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button16
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button17
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button18
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button19
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button20
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button21
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button22
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button23
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button24
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button25
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button26
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button27
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button28
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }
    Button29
    {
        ControlName				RuiButton
        InheritProperties		MatchCharacterButton
    }

//Assault Class List

    Top_List_Anchor
    {
        ControlName				Label
        xpos					-700
        ypos					-282
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
