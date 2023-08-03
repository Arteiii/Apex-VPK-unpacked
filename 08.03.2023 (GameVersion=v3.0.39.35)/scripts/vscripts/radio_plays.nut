#if UI
global function RadioPlays_GetAnimations
#endif

#if UI
global struct RadioPlayLayerModel
{
	array< asset > ruis = []
	array< float > durations = []
	array< string > sounds = []
}

#endif

#if UI
array< RadioPlayLayerModel > function RadioPlays_GetAnimations( ItemFlavor radioPlay )
{
	Assert( ItemFlavor_GetType( radioPlay ) == eItemType.radio_play )

	array< RadioPlayLayerModel > animations

	foreach ( var layersBlock in IterateSettingsAssetArray( ItemFlavor_GetAsset( radioPlay ), "layers" ) )
	{
		RadioPlayLayerModel layerModel

		foreach ( var animationsBlock in IterateSettingsArray( GetSettingsBlockArray( layersBlock, "ruiAnimations" ) ) )
		{
			layerModel.ruis.append( GetKeyValueAsAsset( { kn = GetSettingsBlockString( animationsBlock, "ruiAsset" ) }, "kn" ) )
			layerModel.durations.append( GetSettingsBlockFloat( animationsBlock, "length" ) )
			layerModel.sounds.append( GetSettingsBlockString( animationsBlock, "sound" ) )
		}

		animations.push( layerModel )
	}

	return animations
}
#endif