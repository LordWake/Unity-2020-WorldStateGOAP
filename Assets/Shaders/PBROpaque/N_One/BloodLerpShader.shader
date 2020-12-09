// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PBROpaque/BloodLerpShader"
{
	Properties
	{
		_BloodAmount("BloodAmount", Range( 0 , 1)) = 0.5739224
		[HideInInspector]_T_Biomech_Mutant_Skin_1_Bottom_n("T_Biomech_Mutant_Skin_1_Bottom_n", 2D) = "bump" {}
		_BloodAlbedoTxt("BloodAlbedoTxt", 2D) = "white" {}
		_NormalAlbedoTxt("NormalAlbedoTxt", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _T_Biomech_Mutant_Skin_1_Bottom_n;
		uniform float4 _T_Biomech_Mutant_Skin_1_Bottom_n_ST;
		uniform sampler2D _BloodAlbedoTxt;
		uniform float4 _BloodAlbedoTxt_ST;
		uniform sampler2D _NormalAlbedoTxt;
		uniform float4 _NormalAlbedoTxt_ST;
		uniform float _BloodAmount;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_T_Biomech_Mutant_Skin_1_Bottom_n = i.uv_texcoord * _T_Biomech_Mutant_Skin_1_Bottom_n_ST.xy + _T_Biomech_Mutant_Skin_1_Bottom_n_ST.zw;
			o.Normal = UnpackNormal( tex2D( _T_Biomech_Mutant_Skin_1_Bottom_n, uv_T_Biomech_Mutant_Skin_1_Bottom_n ) );
			float2 uv_BloodAlbedoTxt = i.uv_texcoord * _BloodAlbedoTxt_ST.xy + _BloodAlbedoTxt_ST.zw;
			float2 uv_NormalAlbedoTxt = i.uv_texcoord * _NormalAlbedoTxt_ST.xy + _NormalAlbedoTxt_ST.zw;
			float4 lerpResult2 = lerp( tex2D( _BloodAlbedoTxt, uv_BloodAlbedoTxt ) , tex2D( _NormalAlbedoTxt, uv_NormalAlbedoTxt ) , _BloodAmount);
			o.Albedo = lerpResult2.rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Emission = tex2D( _TextureSample1, uv_TextureSample1 ).rgb;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode10 = tex2D( _TextureSample0, uv_TextureSample0 );
			o.Metallic = tex2DNode10.r;
			o.Smoothness = tex2DNode10.g;
			o.Occlusion = tex2DNode10.b;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
1356;466.2857;837;689;847.8488;136.2098;1.509633;False;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-633.9316,59.42751;Float;False;Property;_BloodAmount;BloodAmount;0;0;Create;True;0;0;False;0;0.5739224;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-731.9405,-308.6758;Float;True;Property;_BloodAlbedoTxt;BloodAlbedoTxt;2;0;Create;True;0;0;False;0;None;a801a2078c00a6f419f03328f7ce96e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-737.0714,-125.6799;Float;True;Property;_NormalAlbedoTxt;NormalAlbedoTxt;3;0;Create;True;0;0;False;0;None;3da93bd5d8460764f9e6f1ca6cc3b36c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2;-260.1948,-71.89957;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;-815.4926,189.4977;Float;True;Property;_T_Biomech_Mutant_Skin_1_Bottom_n;T_Biomech_Mutant_Skin_1_Bottom_n;1;1;[HideInInspector];Create;True;0;0;False;0;c68f4db1e3d5696449456ad935d3330c;c68f4db1e3d5696449456ad935d3330c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-733.2704,401.2706;Float;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;False;0;None;9758aa802b536d4448e4e2714aee4d86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-751.3657,622.0455;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;None;f99c3ca91879e2d4dabc5002eb4cb2cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;PBROpaque/BloodLerpShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;5;0
WireConnection;2;1;6;0
WireConnection;2;2;1;0
WireConnection;0;0;2;0
WireConnection;0;1;7;0
WireConnection;0;2;12;0
WireConnection;0;3;10;1
WireConnection;0;4;10;2
WireConnection;0;5;10;3
ASEEND*/
//CHKSM=92DE52728559D932F0809CD716A04746F85B9D7D