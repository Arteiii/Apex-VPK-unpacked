"resource/ui/menus/panels/category_weapon.res"
{
	PanelFrame
	{
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		bgcolor_override		"70 70 70 255"
		visible					0
		paintbackground			1
		proportionalToParent    1
	}

	TabsBackground
	{
	   ControlName           RuiPanel
	   InheritProperties     TabsBackgroundShort

	   zpos                  999

	   pin_to_sibling           PanelFrame
	   pin_corner_to_sibling    TOP
	   pin_to_sibling_corner    TOP
	}
	TabsCommon
	{
	   ControlName           CNestedPanel
	   classname             "TabsCommonClass"
	   zpos                  1000
	   ypos                  0
	   wide                  %100
	   tall                  48
	   visible               1
	   controlSettingsFile   "resource/ui/menus/panels/common_tabs_short.res"

	   pin_to_sibling            PanelFrame
	   pin_corner_to_sibling    TOP
	   pin_to_sibling_corner    TOP
	}

	WeaponSkinsPanel
    {
        ControlName				CNestedPanel
        classname				"TabPanelClass"
        wide					1824
        tall					995
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/weapon_skins.res"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }

	WeaponCharmsPanel
    {
        ControlName				CNestedPanel
        classname				"TabPanelClass"
        wide					1824
        tall					995
        visible					0
        tabPosition             1
        controlSettingsFile		"resource/ui/menus/panels/weapon_charms.res"

        pin_to_sibling			PanelFrame
        pin_corner_to_sibling	TOP
        pin_to_sibling_corner	TOP
    }
}