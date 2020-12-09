// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DefaultShader/WorkStation"
{
	Properties
	{
		[NoScaleOffset]_WorkStation_lambert1_AlbedoTransparency("WorkStation_lambert1_AlbedoTransparency", 2D) = "white" {}
		[NoScaleOffset]_WorkStation_lambert1_Emission("WorkStation_lambert1_Emission", 2D) = "white" {}
		[NoScaleOffset]_WorkStation_lambert1_Normal("WorkStation_lambert1_Normal", 2D) = "bump" {}
		[NoScaleOffset]_WorkStation_lambert1_MetallicSmoothness("WorkStation_lambert1_MetallicSmoothness", 2D) = "white" {}
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

		uniform sampler2D _WorkStation_lambert1_Normal;
		uniform sampler2D _WorkStation_lambert1_AlbedoTransparency;
		uniform sampler2D _WorkStation_lambert1_Emission;
		uniform sampler2D _WorkStation_lambert1_MetallicSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_WorkStation_lambert1_Normal3 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _WorkStation_lambert1_Normal, uv_WorkStation_lambert1_Normal3 ) );
			float2 uv_WorkStation_lambert1_AlbedoTransparency1 = i.uv_texcoord;
			o.Albedo = tex2D( _WorkStation_lambert1_AlbedoTransparency, uv_WorkStation_lambert1_AlbedoTransparency1 ).rgb;
			float2 uv_WorkStation_lambert1_Emission2 = i.uv_texcoord;
			o.Emission = tex2D( _WorkStation_lambert1_Emission, uv_WorkStation_lambert1_Emission2 ).rgb;
			float2 uv_WorkStation_lambert1_MetallicSmoothness4 = i.uv_texcoord;
			o.Metallic = tex2D( _WorkStation_lambert1_MetallicSmoothness, uv_WorkStation_lambert1_MetallicSmoothness4 ).r;
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
1168;714.2858;1025;441;509.7174;-74.31387;1.465269;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-418.6396,-26.19205;Float;True;Property;_WorkStation_lambert1_AlbedoTransparency;WorkStation_lambert1_AlbedoTransparency;0;1;[NoScaleOffset];Create;True;0;0;False;0;882e6b1fa8624c34db571f0efac80acd;882e6b1fa8624c34db571f0efac80acd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-394.6396,171.808;Float;True;Property;_WorkStation_lambert1_Normal;WorkStation_lambert1_Normal;2;1;[NoScaleOffset];Create;True;0;0;False;0;1188ae87816b7ff40853d6f41646dcfc;1188ae87816b7ff40853d6f41646dcfc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-404.6396,372.808;Float;True;Property;_WorkStation_lambert1_Emission;WorkStation_lambert1_Emission;1;1;[NoScaleOffset];Create;True;0;0;False;0;b175bb26a81540a4aaf27005d84096bf;b175bb26a81540a4aaf27005d84096bf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-369.476,601.0325;Float;True;Property;_WorkStation_lambert1_MetallicSmoothness;WorkStation_lambert1_MetallicSmoothness;3;1;[NoScaleOffset];Create;True;0;0;False;0;daac505562ad76f48bbf8be39330fa73;daac505562ad76f48bbf8be39330fa73;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;93.97305,553.4568;Float;False;Constant;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;355.1318,122.8066;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;DefaultShader/WorkStation;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;1;ReplacementZones=SpecialZones;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;2;2;0
WireConnection;0;3;4;1
WireConnection;0;4;5;0
ASEEND*/
//CHKSM=7926FFB8562C23A50C82F25DB5FA240DBE28C6DE