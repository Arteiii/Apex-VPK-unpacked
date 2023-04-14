global function RTKPagination_InitMetaData
global function RTKPagination_OnInitialize
global function RTKPagination_OnDrawEnd
global function RTKPagination_OnDestroy

global struct RTKPagination_Properties
{
	rtk_panel 		container
	rtk_panel 		content

	rtk_behavior nextButton
	rtk_behavior prevButton
	rtk_panel paginationButtons

	int pages
	int pageSize
	int startPageIndex = 0

	array< string > pageNames = []

	bool vertical
	bool autoPagesByContainerContent

	rtk_behavior animator
}

struct PrivateData
{
	int currentPageIndex = 0
	int nextPageIndex = 0

	bool firstDrawComplete = false
}

global struct RTKPaginationPip
{
	bool isActive = false
	string name = ""
}

void function RTKPagination_InitMetaData( string behaviorType, string structType )
{
	RTKMetaData_SetAllowedBehaviorTypes( structType, "nextButton", [ "Button" ] )
	RTKMetaData_SetAllowedBehaviorTypes( structType, "prevButton", [ "Button" ] )
	RTKMetaData_SetAllowedBehaviorTypes( structType, "animator", [ "Animator" ] )
}

void function RTKPagination_OnInitialize( rtk_behavior self )
{
	rtk_behavior ornull nextButton = self.PropGetBehavior( "nextButton" )
	rtk_behavior ornull prevButton = self.PropGetBehavior( "prevButton" )
	rtk_behavior ornull animator = self.PropGetBehavior( "animator" )
	rtk_panel ornull paginationButtons = self.PropGetPanel( "paginationButtons" )

	if ( nextButton != null )
	{
		expect rtk_behavior( nextButton )
		self.AutoSubscribe( nextButton, "onPressed", function( rtk_behavior button, int keycode ) : ( self ) {
			RTKPagination_NextPage( self )
		} )
	}

	if ( prevButton != null )
	{
		expect rtk_behavior( prevButton )
		self.AutoSubscribe( prevButton, "onPressed", function( rtk_behavior button, int keycode ) : ( self ) {
			RTKPagination_PrevPage( self )
		} )
	}

	if ( animator != null )
	{
		expect rtk_behavior( animator )
		self.AutoSubscribe( animator, "onAnimationFinished", function ( rtk_behavior animator, string animName ) : ( self ) {
			RTKPagination_OnAnimFinished( self, animName )
		} )
	}

	if ( paginationButtons != null )
	{
		expect rtk_panel( paginationButtons )
		self.AutoSubscribe( paginationButtons, "onChildAdded", function ( rtk_panel newChild, int newChildIndex ) : ( self ) {
			array< rtk_behavior > buttonBehaviors = newChild.FindBehaviorsByTypeName( "Button" )
			foreach( button in buttonBehaviors )
			{
				self.AutoSubscribe( button, "onPressed", function( rtk_behavior button, int keycode ) : ( self, newChildIndex ) {
					PrivateData p
					self.Private( p )

					p.nextPageIndex = newChildIndex
					RTKPagination_RefreshActivePage( self )
				} )
			}
		} )
	}
}

void function RTKPagination_OnDestroy( rtk_behavior self )
{
	RTKPagination_ClearDataModel(self )
}

void function RTKPagination_OnDrawEnd( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	if( !p.firstDrawComplete )
	{
		p.nextPageIndex = self.PropGetInt( "startPageIndex" )
		RTKPagination_SetPositionToPageNoAnim( self  )
		RTKPagination_RefreshPaginationButtons( self )
		p.firstDrawComplete = true
	}
}

void function RTKPagination_NextPage( rtk_behavior self )
{
	rtk_behavior ornull animator = self.PropGetBehavior( "animator" )
	if ( animator != null && RTKAnimator_IsPlaying( expect rtk_behavior( animator ) ) )
		return

	PrivateData p
	self.Private( p )

	int pageCount = RTKPagination_GetTotalPages( self  )
	if( pageCount <= p.currentPageIndex )
		return
	else if ( pageCount <= 0 )
	{
		p.currentPageIndex = 0
		return
	}

	p.nextPageIndex = p.currentPageIndex + 1
	RTKPagination_RefreshActivePage( self )
}

void function RTKPagination_PrevPage( rtk_behavior self )
{
	rtk_behavior ornull animator = self.PropGetBehavior( "animator" )
	if ( animator != null && RTKAnimator_IsPlaying( expect rtk_behavior( animator ) ) )
		return

	PrivateData p
	self.Private( p )

	int pageCount = RTKPagination_GetTotalPages( self  )
	if( 0 >= p.currentPageIndex )
		return
	else if ( pageCount <= 0 )
	{
		p.currentPageIndex = 0
		return
	}

	p.nextPageIndex = p.currentPageIndex - 1
	RTKPagination_RefreshActivePage( self )
}


void function RTKPagination_RefreshActivePage( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	if ( p.currentPageIndex < 0 )
		return

	rtk_behavior ornull animator = self.PropGetBehavior( "animator" )
	if ( animator != null && RTKAnimator_IsPlaying( expect rtk_behavior( animator ) ) )
		return

	expect rtk_behavior( animator )

	var animations  = animator.PropGetArray( "tweenAnimations" )
	int tweensCount = RTKArray_GetCount( animations )
	var nextPageAnim = null

	for( int i = 0; i < tweensCount; i++ )
	{
		var animation = RTKArray_GetStruct( animations, i )
		string name = RTKStruct_GetString( animation, "name" )

		if( name == "NextPage" )
		{
			nextPageAnim = animation
			break
		}
	}
	if( nextPageAnim != null )
	{
		var tweens = RTKStruct_GetArray( nextPageAnim, "tweens" )
		var tween = RTKArray_GetStruct( tweens, 0 )

		RTKStruct_SetInt( tween, "startValue", RTKPagination_GetPagePosition( self, p.currentPageIndex ) )
		RTKStruct_SetInt( tween, "endValue", RTKPagination_GetPagePosition( self, p.nextPageIndex ) )

		RTKAnimator_PlayAnimation( animator, "NextPage" )
	}
	else                            
		RTKPagination_SetPositionToPageNoAnim( self  )

	RTKPagination_RefreshPaginationButtons( self )
}

void function RTKPagination_RefreshPaginationButtons( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	RTKPagination_ClearDataModel(self )
	rtk_panel ornull paginationButtons = self.PropGetPanel( "paginationButtons" )

	if ( paginationButtons != null )
	{
		expect rtk_panel( paginationButtons )

		int pages = RTKPagination_GetTotalPages( self )
		var screenPagination = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "pagination" )
		array< RTKPaginationPip > pips

		for( int i = 0; i <= pages; i++ )
		{
			RTKPaginationPip pip
			pip.isActive = i == p.currentPageIndex
			var pageNames = self.PropGetArray( "pageNames" )
			if( RTKArray_GetCount( pageNames ) > i )
				pip.name = RTKArray_GetString( pageNames, i )

			pips.push( pip )
		}

		var paginationArray = RTKStruct_AddArrayOfStructsProperty( screenPagination, string( self.GetInternalId() ), "RTKPaginationPip" )
		RTKArray_SetValue( paginationArray, pips )

		rtk_behavior ornull listBinder = paginationButtons.FindBehaviorByTypeName( "ListBinder" )

		if( listBinder == null )
			return

		expect rtk_behavior( listBinder )

		if( listBinder.PropGetString( "bindingPath" ) == "" )
		{
			listBinder.PropSetString( "bindingPath", RTKDataModelType_GetDataPath( RTK_MODELTYPE_MENUS, string( self.GetInternalId() ), true, [ "pagination" ] ) )
		}

	}
}

void function RTKPagination_ClearDataModel( rtk_behavior self  )
{
	var screenPagination = RTKDataModelType_CreateStruct( RTK_MODELTYPE_MENUS, "pagination" )
	var paginationArray = RTKStruct_AddArrayOfStructsProperty( screenPagination, string( self.GetInternalId() ), "RTKPaginationPip" )
	RTKArray_SetValue( paginationArray, [] )
}

void function RTKPagination_SetPositionToPageNoAnim( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	rtk_panel ornull content = self.PropGetPanel( "content" )

	if( content != null )
	{
		expect rtk_panel( content )
		if( self.PropGetBool( "vertical" ) )
			content.SetPositionY( RTKPagination_GetPagePosition( self, p.nextPageIndex ) )
		else
			content.SetPositionX( RTKPagination_GetPagePosition( self, p.nextPageIndex ) )

		RTKPagination_UpdateCurrentPage( self )
	}
}

void function RTKPagination_OnAnimFinished( rtk_behavior self, string animName )
{
	RTKPagination_UpdateCurrentPage( self )
	RTKPagination_RefreshPaginationButtons( self )
}

void function RTKPagination_UpdateCurrentPage( rtk_behavior self )
{
	PrivateData p
	self.Private( p )

	p.currentPageIndex = p.nextPageIndex
	p.nextPageIndex = -1
}

float function RTKPagination_GetContainerSize( rtk_behavior self )
 {
	 rtk_panel ornull container = self.PropGetPanel( "container" )
	 if( container != null )
	 {
		 expect rtk_panel( container )

		 if( self.PropGetBool( "vertical" ) )
			 return container.GetHeight()
		 else
			 return container.GetWidth()
	 }

	 return 0
 }

float function RTKPagination_GetContentSize( rtk_behavior self )
{
	rtk_panel ornull content = self.PropGetPanel( "content" )
	if( content != null )
	{
		expect rtk_panel( content )

		if( self.PropGetBool( "vertical" ) )
			return content.GetHeight()
		else
			return content.GetWidth()
	}

	return 0
}

int function RTKPagination_GetTotalPages(  rtk_behavior self  )
{
	if( !self.PropGetBool( "autoPagesByContainerContent" ) )
		return self.PropGetInt( "pages" )

	array< float >  contentSizes = RTKPagination_GetContentSizes( self )
	float containerSize = RTKPagination_GetContainerSize( self )
	float contentSpacing = RTKPagination_GetContentSpacing( self )

	float offset             			= 0
	int calculatedPages       			= 0
	float previousPagesOffset 			= 0
	float childContentToLargeUsedSpace  = 0
	int childContentToLargeIndex 		= -1

	for ( int i = 0; i < contentSizes.len(); i++ )
	{
		float childContentSize = contentSizes[i]

		if( i != childContentToLargeIndex )
			childContentToLargeUsedSpace = 0

		if( childContentSize > containerSize )                                                                    
		{
			childContentSize = contentSizes[i] - childContentToLargeUsedSpace
			offset += min( containerSize, childContentSize )
			childContentToLargeUsedSpace += containerSize
			childContentToLargeIndex = i
			calculatedPages++

			if( childContentSize > childContentToLargeUsedSpace )
				i--
		}
		else if( offset + childContentSize > containerSize + previousPagesOffset)
		{
			previousPagesOffset = offset
			calculatedPages++
			i--
		}
		else
		{
			offset += childContentSize + contentSpacing
			if( i == contentSizes.len() - 1 )
				calculatedPages++
		}

	}

	return int( max( calculatedPages - 1, 0 ) )
}

int function RTKPagination_GetPagePosition( rtk_behavior self, int page )
{
	float contentSpacing = RTKPagination_GetContentSpacing( self )
	array< float >  contentSizes = RTKPagination_GetContentSizes( self )

	float contentSize = RTKPagination_GetContentSize( self )
	float containerSize = RTKPagination_GetContainerSize( self )

	rtk_panel ornull content = self.PropGetPanel( "content" )

	if( content != null )
	{
		expect rtk_panel( content )

		float offset              = 0
		int calculatedPage        = 0
		float previousPagesOffset = 0                                                                           
		float childContentToLargeUsedSpace = 0
		int childContentToLargeIndex = -1

		for ( int i = 0; i < contentSizes.len(); i++ )
		{
			if( calculatedPage == page)
				break

			if( i != childContentToLargeIndex )
				childContentToLargeUsedSpace = 0

			float childContentSize = contentSizes[i]

			if( childContentSize > containerSize )                                                                    
			{
				childContentSize = contentSizes[i] - childContentToLargeUsedSpace
				offset += min( containerSize, childContentSize )
				childContentToLargeUsedSpace += containerSize
				childContentToLargeIndex = i
				calculatedPage++
				if( childContentSize > childContentToLargeUsedSpace )
					i--
				else
					offset += contentSpacing
			}
			else if( offset + childContentSize > containerSize + previousPagesOffset)
			{
				previousPagesOffset = offset
				calculatedPage++
				i--
			}
			else
				offset += childContentSize + contentSpacing
		}

		if( self.PropGetBool( "vertical" ) )
			return int(content.GetPivot().y * contentSize - offset)           
		else
			return int(content.GetPivot().x * contentSize - offset)             
	}

	return 0
}

array< float > function RTKPagination_GetContentSizes( rtk_behavior self )
{
	rtk_panel ornull content = self.PropGetPanel( "content" )
	array< float > sizes = []

	if( content != null )
	{
		expect rtk_panel( content )

		array< rtk_panel > children = content.GetChildren()
		foreach( panel in children )
		{
			if( self.PropGetBool( "vertical" ) )
				sizes.push( panel.GetHeight() )
			else
				sizes.push( panel.GetWidth() )
		}
	}

	return sizes
}

float function RTKPagination_GetContentSpacing( rtk_behavior self )
{
	rtk_panel ornull content = self.PropGetPanel( "content" )
	float spacing = 0
	if( content != null )
	{
		expect rtk_panel( content )

		if( content.HasLayoutBehavior() )
		{
			rtk_behavior behavior = content.GetLayoutBehavior()
			spacing = behavior.PropGetFloat( "spacing" )
		}
	}

	return spacing
}
