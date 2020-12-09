// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DefaultShader/RestMachine"
{
	Properties
	{
		[NoScaleOffset]_Teleport_Teleport_AlbedoTransparency("Teleport_Teleport_AlbedoTransparency", 2D) = "white" {}
		[NoScaleOffset]_Teleport_Teleport_Emission("Teleport_Teleport_Emission", 2D) = "white" {}
		[NoScaleOffset]_Teleport_Teleport_MetallicSmoothness("Teleport_Teleport_MetallicSmoothness", 2D) = "white" {}
		[NoScaleOffset]_Teleport_Teleport_Normal("Teleport_Teleport_Normal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "ReplacementZones"="SpecialZones" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Teleport_Teleport_Normal;
		uniform sampler2D _Teleport_Teleport_AlbedoTransparency;
		uniform sampler2D _Teleport_Teleport_Emission;
		uniform sampler2D _Teleport_Teleport_MetallicSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Teleport_Teleport_Normal4 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _Teleport_Teleport_Normal, uv_Teleport_Teleport_Normal4 ) );
			float2 uv_Teleport_Teleport_AlbedoTransparency1 = i.uv_texcoord;
			o.Albedo = tex2D( _Teleport_Teleport_AlbedoTransparency, uv_Teleport_Teleport_AlbedoTransparency1 ).rgb;
			float2 uv_Teleport_Teleport_Emission2 = i.uv_texcoord;
			o.Emission = tex2D( _Teleport_Teleport_Emission, uv_Teleport_Teleport_Emission2 ).rgb;
			float2 uv_Teleport_Teleport_MetallicSmoothness3 = i.uv_texcoord;
			o.Metallic = tex2D( _Teleport_Teleport_MetallicSmoothness, uv_Teleport_Teleport_MetallicSmoothness3 ).r;
			o.Smoothness = 1.0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
338.8571;714.2858;1854;441;1186.32;30.58547;2.161115;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-460.6776,-22.41784;Float;True;Property;_Teleport_Teleport_AlbedoTransparency;Teleport_Teleport_AlbedoTransparency;0;1;[NoScaleOffset];Create;True;0;0;False;0;494d0329aa252bc448969c7fc70598f8;494d0329aa252bc448969c7fc70598f8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-448.2309,182.3917;Float;True;Property;_Teleport_Teleport_Normal;Teleport_Teleport_Normal;3;1;[NoScaleOffset];Create;True;0;0;False;0;e6ff78efd40165149b8e18d5a9850aa0;e6ff78efd40165149b8e18d5a9850aa0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-424.73,387.6441;Float;True;Property;_Teleport_Teleport_Emission;Teleport_Teleport_Emission;1;1;[NoScaleOffset];Create;True;0;0;False;0;ac25cd40c0d6a344485e2a02893d3345;ac25cd40c0d6a344485e2a02893d3345;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-433.1427,660.8092;Float;True;Property;_Teleport_Teleport_MetallicSmoothness;Teleport_Teleport_MetallicSmoothness;2;1;[NoScaleOffset];Create;True;0;0;False;0;a6e2796ff8582e542a2e6b64d2ce54bc;a6e2796ff8582e542a2e6b64d2ce54bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-2.029297,639.3602;Float;False;Constant;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;272.6476,111.7337;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;DefaultShader/RestMachine;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;1;ReplacementZones=SpecialZones;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;4;0
WireConnection;0;2;2;0
WireConnection;0;3;3;0
WireConnection;0;4;5;0
ASEEND*/
//CHKSM=3D7C8527509A05C7A630EBC4CB0DF28E4E392E87