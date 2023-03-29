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
                navDown					SwitchInfiniteAmmo
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                childGroupAlways        ChoiceButtonAlways
            }

            SwitchInfiniteAmmo
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDynamicStats
                navDown					SwitchHitIndicators
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
            SwitchHitIndicators
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchInfiniteAmmo
                navDown					SwitchFriendlyFire
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

            SwitchFriendlyFire
	        {
	            ControlName				RuiButton
	            InheritProperties		SwitchButton
	            className               "SettingScrollSizer"
	            style					DialogListButton
	            navUp					SwitchHitIndicators
	            navDown					SwitchTargetSpeed
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
	        SwitchTargetSpeed
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchFriendlyFire
                navDown					SwitchBehaviorStayInPlace
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
            DummieBehaviorMovementHeader
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
            DummieBehaviorMovementHeaderText
            {
                ControlName				Label
                InheritProperties		SubheaderText
                pin_to_sibling			DummieBehaviorMovementHeader
                pin_corner_to_sibling	LEFT
                pin_to_sibling_corner	LEFT
                labelText				"#FRSETTING_LABEL_DUMMIES_MOVEMENT"
            }
            SwitchBehaviorStayInPlace
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchTargetSpeed
                navDown					SwitchBehaviorStrafe
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			DummieBehaviorMovementHeader
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchBehaviorStrafe
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchBehaviorStayInPlace
                navDown					SwitchBehaviorStrafeSpeed
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			SwitchBehaviorStayInPlace
	            pin_corner_to_sibling	TOP_LEFT
	            pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchBehaviorStrafeSpeed
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchBehaviorStrafe
                navDown					SwitchDummyShield
                list
                {
                    "#FRSETTING_DUMMIESTRAFESPEED_NAME_1"   1
                    "#FRSETTING_DUMMIESTRAFESPEED_NAME_2"   2
                    "#FRSETTING_DUMMIESTRAFESPEED_NAME_3"   3
                }
                pin_to_sibling			SwitchBehaviorStrafe
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        MultiChoiceButtonAlways
            }
            DummieBehaviorModsHeader
            {
                ControlName				ImagePanel
                InheritProperties		SubheaderBackgroundWide
                className               "SettingScrollSizer"
                xpos					0
                ypos					6
                pin_to_sibling			SwitchBehaviorStrafeSpeed
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
            }
            DummieBehaviorModsHeaderText
            {
                ControlName				Label
                InheritProperties		SubheaderText
                pin_to_sibling			DummieBehaviorModsHeader
                pin_corner_to_sibling	LEFT
                pin_to_sibling_corner	LEFT
                labelText				"#FRSETTING_LABEL_DUMMIES_MODS"
            }
            SwitchDummyShield
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchBehaviorStrafe
                navDown					SwitchBehaviorCanStand
                list
                {
                    "#LOOT_TIER1"   1
                    "#LOOT_TIER2"	2
                    "#LOOT_TIER3"	3
                    "#LOOT_TIER5"	4
                }
                pin_to_sibling			DummieBehaviorModsHeader
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        MultiChoiceButtonAlways
            }
            SwitchBehaviorCanStand
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchDummyShield
                navDown					SwitchBehaviorCanCrouch
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			SwitchDummyShield
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchBehaviorCanCrouch
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchBehaviorCanStand
                navDown					SwitchBehaviorRandIntervals
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			SwitchBehaviorCanStand
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }
            SwitchBehaviorRandIntervals
            {
                ControlName				RuiButton
                InheritProperties		SwitchButton
                className               "SettingScrollSizer"
                style					DialogListButton
                navUp					SwitchBehaviorCanCrouch
                                   
                                                             
                      
                list
                {
                    "#SETTING_OFF"	0
                    "#SETTING_ON"	1
                }

                pin_to_sibling			SwitchBehaviorCanCrouch
                pin_corner_to_sibling	TOP_LEFT
                pin_to_sibling_corner	BOTTOM_LEFT
                childGroupAlways        ChoiceButtonAlways
            }

                               
                            
             
                                         
                                                          
                                                            
                          
                          

                                                            
                                              
                                                 
             
                            
             
                                    
                                                

                                                  
                                          
                                          
                                                               
             
                                          
             
                                        
                                               
                                                            
                                          
                    
                 
                                    
                                   
     
                                                     
                                                        

                                                  
                                              
                                                 
                                                          
             
                                        
             
                                        
                                               
                                                            
                                          
                    
                 
                                    
                                   
                 
                                                        
                                                        

                                                               
                                              
                                                 
                                                          
             
                                        
             
                                        
                                               
                                                            
                                          
                    
                 
                                    
                                   
                 
                                                      
                                                         

                                                             
                                              
                                                 
                                                          
             
                                         
             
                                        
                                               
                                                            
                                          
                    
                 
                                    
                                   
                 
                                                      
                                                

                                                             
                                              
                                                 
                                                          
             
                                
             
                                        
                                               
                                                            
                                          
                    
                 
                                    
                                   
                 
                                                       
                                                      

                                                              
                                              
                                                 
                                                          
             
                                    
             
                                         
                                                          
                                                            
                          
                          

                                                     
                                              
                                                 
             
                                        
             
                                    
                                                
                                                         
                                          
                                          
                                                              
             
                                      
             
                                        
                                                     
                                                            
                                              
                                                               

                                                         
                                              
                                                 
             
                                               
             
                                        
                                                     
                                                            

                                                           
                                              
                                                 
             
                                      
             
                                        
                                               
                                                            
                                          
                                                             
                    
                 
                                    
                                   
                 

                                         

                                                                    
                                              
                                                 
                                                          
             
                  
        }
    }
}