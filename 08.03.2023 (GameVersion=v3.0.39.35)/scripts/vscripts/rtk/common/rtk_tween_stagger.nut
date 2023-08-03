global function RTKTweenStagger_OnUpdate
global function RTKTweenStagger_OnEnable

global struct RTKTweenStagger_Properties
{
	float delay = 0.1
	float startDelay = 0.0
	string animationName = "FadeIn"

	bool isRecursive = false
	bool useMaxTweenTime = true
	bool onlyOnForwardNav = true
	bool initTweensOnEnable = false
}

struct PrivateData
{
	float totalTime = 0.0
	bool hasRun = false

	int childrenChanged = 0
}

void function RTKTweenStagger_OnUpdate( rtk_behavior self, float dt )
{
	PrivateData p
	self.Private( p )

	if ( GetLastMenuNavDirection() != MENU_NAV_FORWARD && self.PropGetBool( "onlyOnForwardNav" ) )
		return

	if( !p.hasRun )
	{
		p.totalTime =  self.PropGetFloat( "startDelay" )

		rtk_panel panel = self.GetPanel()
		AnimatePanel( self, panel )
		p.hasRun = true
	}
}

void function RTKTweenStagger_OnEnable( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	p.hasRun = false
	p.childrenChanged = 0
	p.totalTime = 0

	if ( self.PropGetBool( "initTweensOnEnable" ) )
	{
		rtk_panel panel = self.GetPanel()
		SetInitialTweenStateForChildPanels( self, panel )
	}
}

void function AnimatePanel( rtk_behavior self, rtk_panel panel )
{
	PrivateData p
	self.Private( p )

	bool selfUseMaxtweenTime = self.PropGetBool( "useMaxTweenTime" )
	float selfDelay          = self.PropGetFloat( "delay" )
	string selfAnimationName = self.PropGetString( "animationName" )

	for ( int childIndex = 0; childIndex < panel.GetChildCount(); ++childIndex )
	{
		rtk_panel child = panel.GetChildByIndex( childIndex )

		rtk_behavior animator = child.FindBehaviorByTypeName( "Animator" )

		if( animator != null )
		{
			rtk_array animations =  animator.PropGetArray( "tweenAnimations" )
			int animationsCount  = RTKArray_GetCount( animations )

			SetInitialTweenState( self, animator )

			for( int i = 0; i < animationsCount; i++ )
			{
				rtk_struct animation = RTKArray_GetStruct( animations, i )
				string animationName = RTKStruct_GetString( animation, "name" )

				if( animationName == selfAnimationName )
				{
					rtk_array tweens = RTKStruct_GetArray( animation, "tweens" )
					int tweensCount = RTKArray_GetCount( tweens )

					float timeToDelayNextBy = 0.0

					for( int j = 0; j < tweensCount; j++ )
					{
						rtk_struct tween = RTKArray_GetStruct( tweens, j )

						if( p.childrenChanged > 0 )                                   
							RTKStruct_SetFloat( tween, "delay", p.totalTime + selfDelay )
						else
							RTKStruct_SetFloat( tween, "delay", p.totalTime )

						float timeChange = RTKStruct_GetFloat( tween, "duration" )
						if ( p.childrenChanged > 0 )
							timeChange += selfDelay

						if ( selfUseMaxtweenTime )
							timeToDelayNextBy = max( timeToDelayNextBy, timeChange )
						else
						{
							                                                                                   
							                                                                                   
							                                       
							if( timeToDelayNextBy == 0 )
								timeToDelayNextBy = timeChange
							else
								timeToDelayNextBy = min( timeToDelayNextBy, timeChange )
						}


					}
					p.childrenChanged++
					p.totalTime += timeToDelayNextBy                      
				}
			}

			RTKAnimator_PlayAnimation( animator, selfAnimationName )
		}

		if( self.PropGetBool( "isRecursive" ) )
			AnimatePanel( self, child )
	}
}

void function SetInitialTweenStateForChildPanels( rtk_behavior self, rtk_panel panel )
{
	for ( int childIndex = 0; childIndex < panel.GetChildCount(); ++childIndex )
	{
		rtk_panel child = panel.GetChildByIndex( childIndex )
		rtk_behavior animator = child.FindBehaviorByTypeName( "Animator" )

		if ( animator != null )
			SetInitialTweenState( self, animator )

		if ( self.PropGetBool( "isRecursive" ) )
			SetInitialTweenStateForChildPanels( self, child )
	}
}

void function SetInitialTweenState( rtk_behavior self, rtk_behavior animator )
{
	if ( animator != null )
	{
		rtk_array animations = animator.PropGetArray( "tweenAnimations" )
		int animationsCount  = RTKArray_GetCount( animations )

		for ( int i = 0; i < animationsCount; i++ )
		{
			rtk_struct animation = RTKArray_GetStruct( animations, i )
			string animationName = RTKStruct_GetString( animation, "name" )

			if ( animationName == self.PropGetString( "animationName" ) )
			{
				rtk_array tweens = RTKStruct_GetArray( animation, "tweens" )
				int tweensCount = RTKArray_GetCount( tweens )

				for ( int j = 0; j < tweensCount; j++ )
				{
					rtk_struct tween = RTKArray_GetStruct( tweens, j )
					RTKStruct_SetFloat( tween, "delay", 0 )
				}
			}
		}

		RTKAnimator_PlayAnimation( animator, self.PropGetString( "animationName" ) )
		RTKAnimator_Pause( animator )
	}
}
