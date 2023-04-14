"resource/ui/menus/panels/panel_armory_weapons.res"
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

	WeaponCategoryButton0
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				0
        xpos                    174
        xpos_nx_handheld        -9			[$NX || $NX_UI_PC]
        ypos                    180
        tabPosition             1
        cursorVelocityModifier  0.7

        navDown                 WeaponCategoryButton4
        navRight                WeaponCategoryButton1
    }
    WeaponCategoryButton1
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				1
        xpos                    -84
        cursorVelocityModifier  0.7

        navDown                 WeaponCategoryButton4
        navLeft                 WeaponCategoryButton0
        navRight                WeaponCategoryButton2

        pin_to_sibling			WeaponCategoryButton0
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    WeaponCategoryButton2
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				2
        xpos                    -84
        cursorVelocityModifier  0.7

        navDown                 WeaponCategoryButton5
        navLeft                 WeaponCategoryButton1
        navRight                WeaponCategoryButton3

        pin_to_sibling			WeaponCategoryButton1
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    WeaponCategoryButton3
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				3
        xpos                    -84
        cursorVelocityModifier  0.7

        navDown                 WeaponCategoryButton6
        navLeft                 WeaponCategoryButton2

        pin_to_sibling			WeaponCategoryButton2
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    WeaponCategoryButton4
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				4
        ypos                    40
        xpos                    -190
        cursorVelocityModifier  0.7
        ruiArgs
        {
            isNameAtTop         1
        }

        navUp                   WeaponCategoryButton1
        navRight                WeaponCategoryButton5
        navDown                 MiscCustomizeButton

        pin_to_sibling			WeaponCategoryButton0
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
    WeaponCategoryButton5
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				5
        xpos                    -84
        cursorVelocityModifier  0.7
        ruiArgs
        {
            isNameAtTop         1
        }

        navUp                   WeaponCategoryButton2
        navLeft                 WeaponCategoryButton4
        navRight                WeaponCategoryButton6
        navDown                 MiscCustomizeButton

        pin_to_sibling			WeaponCategoryButton4
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
    WeaponCategoryButton6
    {
        ControlName				RuiButton
        InheritProperties		WeaponCategoryButton
        classname               WeaponCategoryButtonClass
        scriptID				5
        xpos                    -84
        cursorVelocityModifier  0.7
        ruiArgs
        {
            isNameAtTop         1
        }

        navUp                   WeaponCategoryButton3
        navLeft                 WeaponCategoryButton5
        navDown                 MiscCustomizeButton

        pin_to_sibling			WeaponCategoryButton5
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	TOP_RIGHT
    }
}