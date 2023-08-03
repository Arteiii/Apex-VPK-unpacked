global function RTKTimer_OnUpdate

global struct RTKTimer_Properties
{
	float endTime
	float remainingTime
}

void function RTKTimer_OnUpdate( rtk_behavior self, float deltaTime )
{
	float endTime = self.PropGetFloat( "endTime" )
	float remainingTime = max( 0, endTime - UITime() )

	self.PropSetFloat( "remainingTime", remainingTime )
}