// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PBROpaque/GymBag"
{
	Properties
	{
		[NoScaleOffset]_AlbedoTxt("AlbedoTxt", 2D) = "white" {}
		[NoScaleOffset]_MetallicTxt("MetallicTxt", 2D) = "white" {}
		[NoScaleOffset]_NormalTxt("NormalTxt", 2D) = "bump" {}
		[NoScaleOffset]_Normal("Normal", 2D) = "bump" {}
		[NoScaleOffset]_EmissiveTxt("EmissiveTxt", 2D) = "white" {}
		_PunchIntensity("Punch Intensity", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "ReplacementZones"="SpecialZones" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _EmissiveTxt;
		uniform sampler2D _Normal;
		uniform float _PunchIntensity;
		uniform sampler2D _NormalTxt;
		uniform sampler2D _AlbedoTxt;
		uniform sampler2D _MetallicTxt;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_EmissiveTxt4 = v.texcoord;
			float4 tex2DNode4 = tex2Dlod( _EmissiveTxt, float4( uv_EmissiveTxt4, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv_Normal5 = v.texcoord;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 ase_worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
			float3x3 tangentToWorld = CreateTangentToWorldPerVertex( ase_worldNormal, ase_worldTangent, v.tangent.w );
			float3 tangentNormal7 = UnpackNormal( tex2Dlod( _Normal, float4( uv_Normal5, 0, 0.0) ) );
			float3 modWorldNormal7 = (tangentToWorld[0] * tangentNormal7.x + tangentToWorld[1] * tangentNormal7.y + tangentToWorld[2] * tangentNormal7.z);
			float4 lerpResult17 = lerp( tex2DNode4 , float4( ( ase_vertexNormal * saturate( ( ( modWorldNormal7.z + 2.5 ) * _PunchIntensity ) ) * -0.19 ) , 0.0 ) , tex2DNode4.r);
			v.vertex.xyz += lerpResult17.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalTxt3 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _NormalTxt, uv_NormalTxt3 ) );
			float2 uv_AlbedoTxt1 = i.uv_texcoord;
			o.Albedo = tex2D( _AlbedoTxt, uv_AlbedoTxt1 ).rgb;
			float2 uv_EmissiveTxt4 = i.uv_texcoord;
			float4 tex2DNode4 = tex2D( _EmissiveTxt, uv_EmissiveTxt4 );
			o.Emission = tex2DNode4.rgb;
			float2 uv_MetallicTxt2 = i.uv_texcoord;
			o.Metallic = tex2D( _MetallicTxt, uv_MetallicTxt2 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
338.8571;714.2858;827;441;1242.382;466.7343;2.512759;True;False
Node;AmplifyShaderEditor.SamplerNode;5;-1715.275,619.8428;Float;True;Property;_Normal;Normal;3;1;[NoScaleOffset];Create;True;0;0;False;0;0b855ef06cd4ebb4b9be196e20bf82b1;0b855ef06cd4ebb4b9be196e20bf82b1;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;7;-1359.679,630.8104;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;9;-1415.861,774.4423;Float;False;Constant;_PunchRange;Punch Range;6;0;Create;True;0;0;False;0;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1092.203,672.9465;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1157.304,802.2908;Float;False;Property;_PunchIntensity;Punch Intensity;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-915.8403,684.0607;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;13;-457.7181,575.0007;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;12;-758.0405,677.2241;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-399.6301,757.1453;Float;False;Constant;_PunchHeight;Punch Height;5;0;Create;True;0;0;False;0;-0.19;-0.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-188.6301,640.1453;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;4;-776.5602,126.9396;Float;True;Property;_EmissiveTxt;EmissiveTxt;4;1;[NoScaleOffset];Create;True;0;0;False;0;bc25714f3b589d142bdd9f788e98ac3d;bc25714f3b589d142bdd9f788e98ac3d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;-58.14356,301.6683;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-766.2903,339.3658;Float;True;Property;_MetallicTxt;MetallicTxt;1;1;[NoScaleOffset];Create;True;0;0;False;0;7e968223d241a514d9789715681044b2;7e968223d241a514d9789715681044b2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-755.6393,-74.10946;Float;True;Property;_NormalTxt;NormalTxt;2;1;[NoScaleOffset];Create;True;0;0;False;0;0b855ef06cd4ebb4b9be196e20bf82b1;0b855ef06cd4ebb4b9be196e20bf82b1;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-753.1642,-286.2048;Float;True;Property;_AlbedoTxt;AlbedoTxt;0;1;[NoScaleOffset];Create;True;0;0;False;0;9cb87a79d88be494a8b7e9b467aa501d;9cb87a79d88be494a8b7e9b467aa501d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;225.3841,-33.39025;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;PBROpaque/GymBag;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;1;ReplacementZones=SpecialZones;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;0
WireConnection;8;0;7;3
WireConnection;8;1;9;0
WireConnection;10;0;8;0
WireConnection;10;1;11;0
WireConnection;12;0;10;0
WireConnection;14;0;13;0
WireConnection;14;1;12;0
WireConnection;14;2;15;0
WireConnection;17;0;4;0
WireConnection;17;1;14;0
WireConnection;17;2;4;1
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;2;4;0
WireConnection;0;3;2;0
WireConnection;0;11;17;0
ASEEND*/
//CHKSM=FC61D2446F0CDC2DBE953329CCB669FEAAEA0D48