"resource/ui/menus/panels/armory.res"
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

	TabsBackground
    {
        ControlName				RuiPanel
        InheritProperties		TabsBackgroundShort
        ypos_nx_handheld		-50			[$NX || $NX_UI_PC]

        pin_to_sibling           PanelFrame
	    pin_corner_to_sibling    TOP
	    pin_to_sibling_corner    TOP
    }

    TabsCommon
    {
        ControlName				CNestedPanel
        classname				"TabsCommonClass"
        zpos					1
        wide					f0
        tall					72
        ypos_nx_handheld			-50			[$NX || $NX_UI_PC]
        visible					1
        controlSettingsFile		"resource/ui/menus/panels/common_tabs_short.res"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }

                                  
		ArmoryWeaponsPanel
        {
            ControlName             RTKVGUIPanel
            wide                    %100
            tall                    996
            prefab                  "ui_rtk/menus/armory/categories/armory_categories_panel.rpak"
            visible					0
            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	TOP
        }
        ArmoryMorePanel
        {
            ControlName             RTKVGUIPanel
            wide                    %100
            tall                    996
            prefab                  "ui_rtk/menus/armory/more/armory_more_panel.rpak"
            visible					0
            pin_to_sibling			PanelFrame
            pin_corner_to_sibling	TOP
            pin_to_sibling_corner	TOP
        }
         
                    
         
                                       
                                        
                      
                      
                         
                         
                         
                                     
                                                                                    

                                       
                                     
                                     
         
                       
         
                                       
                                        
                      
                      
                         
                         
                         
                                     
                                                                                 

                                       
                                     
                                     
         
       
}
