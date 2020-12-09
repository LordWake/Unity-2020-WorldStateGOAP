// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PostProcessHitReactionPPSRenderer ), PostProcessEvent.AfterStack, "PostProcess/HitReaction", true )]
public sealed class PostProcessHitReactionPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Move Scene" )]
	public FloatParameter _MoveScene = new FloatParameter { value = 0f };
}

public sealed class PostProcessHitReactionPPSRenderer : PostProcessEffectRenderer<PostProcessHitReactionPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Hidden/PostProcess/HitReaction" ) );
		sheet.properties.SetFloat( "_MoveScene", settings._MoveScene );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
