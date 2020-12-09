// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DefaultShader/Factory"
{
	Properties
	{
		[NoScaleOffset]_ScifiCrate_material_0_AlbedoTransparency("Sci-fi Crate_material_0_AlbedoTransparency", 2D) = "white" {}
		[NoScaleOffset]_ScifiCrate_material_0_Emission("Sci-fi Crate_material_0_Emission", 2D) = "white" {}
		[NoScaleOffset]_ScifiCrate_material_0_MetallicSmoothness("Sci-fi Crate_material_0_MetallicSmoothness", 2D) = "white" {}
		[NoScaleOffset]_ScifiCrate_material_0_Normal("Sci-fi Crate_material_0_Normal", 2D) = "bump" {}
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

		uniform sampler2D _ScifiCrate_material_0_Normal;
		uniform sampler2D _ScifiCrate_material_0_AlbedoTransparency;
		uniform sampler2D _ScifiCrate_material_0_Emission;
		uniform sampler2D _ScifiCrate_material_0_MetallicSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_ScifiCrate_material_0_Normal4 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _ScifiCrate_material_0_Normal, uv_ScifiCrate_material_0_Normal4 ) );
			float2 uv_ScifiCrate_material_0_AlbedoTransparency1 = i.uv_texcoord;
			o.Albedo = tex2D( _ScifiCrate_material_0_AlbedoTransparency, uv_ScifiCrate_material_0_AlbedoTransparency1 ).rgb;
			float2 uv_ScifiCrate_material_0_Emission2 = i.uv_texcoord;
			o.Emission = tex2D( _ScifiCrate_material_0_Emission, uv_ScifiCrate_material_0_Emission2 ).rgb;
			float2 uv_ScifiCrate_material_0_MetallicSmoothness3 = i.uv_texcoord;
			o.Metallic = tex2D( _ScifiCrate_material_0_MetallicSmoothness, uv_ScifiCrate_material_0_MetallicSmoothness3 ).r;
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
338.8571;714.2858;827;441;732.4464;41.5211;1.452295;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-415.7982,-235.281;Float;True;Property;_ScifiCrate_material_0_AlbedoTransparency;Sci-fi Crate_material_0_AlbedoTransparency;0;1;[NoScaleOffset];Create;True;0;0;False;0;2ac81cc7e73d6c440993c28eb8751968;2ac81cc7e73d6c440993c28eb8751968;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-414.9887,-35.20113;Float;True;Property;_ScifiCrate_material_0_Normal;Sci-fi Crate_material_0_Normal;3;1;[NoScaleOffset];Create;True;0;0;False;0;831f69f857218cf4e985019883fceadc;831f69f857218cf4e985019883fceadc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-412.3159,166.0211;Float;True;Property;_ScifiCrate_material_0_Emission;Sci-fi Crate_material_0_Emission;1;1;[NoScaleOffset];Create;True;0;0;False;0;80f294fb859201e49b83d0b2a68abd67;80f294fb859201e49b83d0b2a68abd67;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-380.5475,378.0593;Float;True;Property;_ScifiCrate_material_0_MetallicSmoothness;Sci-fi Crate_material_0_MetallicSmoothness;2;1;[NoScaleOffset];Create;True;0;0;False;0;91ecf11ad67a4db4abe51a51d5bb09a8;91ecf11ad67a4db4abe51a51d5bb09a8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-33.89234,382.5491;Float;False;Constant;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;170.3991,-102.2394;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;DefaultShader/Factory;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;1;ReplacementZones=SpecialZones;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;4;0
WireConnection;0;2;2;0
WireConnection;0;3;3;1
WireConnection;0;4;5;0
ASEEND*/
//CHKSM=A817B9E9CC6D2546AAF1A74F3E67DC72ADB49EB1