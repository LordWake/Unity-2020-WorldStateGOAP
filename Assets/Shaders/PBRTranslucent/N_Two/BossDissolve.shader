// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Translucent/BossDissolve"
{
	Properties
	{
		[NoScaleOffset]_T_Biomech_Mutant_Skin_1_Bottom_n("T_Biomech_Mutant_Skin_1_Bottom_n", 2D) = "bump" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[NoScaleOffset]_NormalAlbedoTxt("NormalAlbedoTxt", 2D) = "white" {}
		[NoScaleOffset]_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[NoScaleOffset]_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[NoScaleOffset]_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[NoScaleOffset]_BurnRamp("Burn Ramp", 2D) = "white" {}
		_DissolveAmount("Dissolve Amount", Range( -1 , 1)) = -1
		_SpeedX("SpeedX", Float) = 0
		_SpeedY("SpeedY", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _T_Biomech_Mutant_Skin_1_Bottom_n;
		uniform sampler2D _NormalAlbedoTxt;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _BurnRamp;
		uniform sampler2D _TextureSample2;
		uniform float _SpeedX;
		uniform float _SpeedY;
		uniform float _DissolveAmount;
		uniform sampler2D _TextureSample0;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_T_Biomech_Mutant_Skin_1_Bottom_n2 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _T_Biomech_Mutant_Skin_1_Bottom_n, uv_T_Biomech_Mutant_Skin_1_Bottom_n2 ) );
			float2 uv_NormalAlbedoTxt1 = i.uv_texcoord;
			o.Albedo = tex2D( _NormalAlbedoTxt, uv_NormalAlbedoTxt1 ).rgb;
			float2 uv_TextureSample13 = i.uv_texcoord;
			float2 appendResult17 = (float2(_SpeedX , _SpeedY));
			float2 panner14 = ( _Time.y * appendResult17 + i.uv_texcoord);
			float temp_output_6_0 = ( tex2D( _TextureSample2, panner14 ).r + -_DissolveAmount );
			float temp_output_10_0 = saturate( (0.27 + (( 1.0 - temp_output_6_0 ) - 0.0) * (1.15 - 0.27) / (1.0 - 0.0)) );
			float2 temp_cast_1 = (temp_output_10_0).xx;
			float4 lerpResult12 = lerp( tex2D( _TextureSample1, uv_TextureSample13 ) , tex2D( _BurnRamp, temp_cast_1 ) , temp_output_10_0);
			o.Emission = lerpResult12.rgb;
			float2 uv_TextureSample04 = i.uv_texcoord;
			float4 tex2DNode4 = tex2D( _TextureSample0, uv_TextureSample04 );
			o.Metallic = tex2DNode4.r;
			o.Smoothness = tex2DNode4.g;
			o.Occlusion = tex2DNode4.b;
			o.Alpha = 1;
			clip( temp_output_6_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
1064;714.2858;1129;441;3044.503;55.5034;1.11445;True;False
Node;AmplifyShaderEditor.RangedFloatNode;19;-2687.677,158.6984;Float;False;Property;_SpeedY;SpeedY;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-2705.319,35.64057;Float;False;Property;_SpeedX;SpeedX;8;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-2412.253,104.0341;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;-2406.997,233.3363;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-2500.557,-43.1389;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;14;-2141.032,64.08718;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2031.911,282.9508;Float;False;Property;_DissolveAmount;Dissolve Amount;7;0;Create;True;0;0;False;0;-1;1.013664;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1860.473,69.41468;Float;True;Property;_TextureSample2;Texture Sample 2;5;1;[NoScaleOffset];Create;True;0;0;False;0;None;23fa5988708adc74c881a4740c892348;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;8;-1667.602,272.6184;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1447.098,206.7555;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-1287.785,94.52951;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-1075.879,82.18587;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.27;False;4;FLOAT;1.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;-844.6866,123.7667;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-628.1029,-61.01375;Float;True;Property;_BurnRamp;Burn Ramp;6;1;[NoScaleOffset];Create;True;0;0;False;0;None;c494316ba20d6cd45845f5b7d061664f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-627.7248,287.1442;Float;True;Property;_TextureSample1;Texture Sample 1;4;1;[NoScaleOffset];Create;True;0;0;False;0;None;5246018d188625049813d0cb7579d961;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-790.7205,-569.0511;Float;True;Property;_NormalAlbedoTxt;NormalAlbedoTxt;2;1;[NoScaleOffset];Create;True;0;0;False;0;None;62671874904a6f44dabc27c78048f93b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-695.0673,-272.1554;Float;True;Property;_T_Biomech_Mutant_Skin_1_Bottom_n;T_Biomech_Mutant_Skin_1_Bottom_n;0;1;[NoScaleOffset];Create;True;0;0;False;0;c68f4db1e3d5696449456ad935d3330c;c20592f66c11ece4b87ecfbbe42b1fb3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-518.4101,497.0066;Float;True;Property;_TextureSample0;Texture Sample 0;3;1;[NoScaleOffset];Create;True;0;0;False;0;None;5aa032e285f92f647a9fb28e592dd6a1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;12;-253.3748,105.0989;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;212.0741,-38.88024;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Translucent/BossDissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;18;0
WireConnection;17;1;19;0
WireConnection;14;0;15;0
WireConnection;14;2;17;0
WireConnection;14;1;16;0
WireConnection;5;1;14;0
WireConnection;8;0;7;0
WireConnection;6;0;5;1
WireConnection;6;1;8;0
WireConnection;9;0;6;0
WireConnection;13;0;9;0
WireConnection;10;0;13;0
WireConnection;11;1;10;0
WireConnection;12;0;3;0
WireConnection;12;1;11;0
WireConnection;12;2;10;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
WireConnection;0;2;12;0
WireConnection;0;3;4;1
WireConnection;0;4;4;2
WireConnection;0;5;4;3
WireConnection;0;10;6;0
ASEEND*/
//CHKSM=E12A9DC32B94E99C00C4FEB5AD4E3E30B5BD7987