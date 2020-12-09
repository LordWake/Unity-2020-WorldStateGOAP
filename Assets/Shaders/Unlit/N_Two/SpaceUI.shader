// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit/SpaceUI"
{
	Properties
	{
		[NoScaleOffset][Normal]_DistortionNormal("Distortion Normal", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[NoScaleOffset]_SpaceBG("Space BG", 2D) = "white" {}
		[NoScaleOffset]_BgMask("Bg Mask", 2D) = "white" {}
		[NoScaleOffset]_Flow("Flow", 2D) = "white" {}
		[NoScaleOffset]_FlowMask("FlowMask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM



#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
		//only defining to not throw compilation error over Unity 5.5
		#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityStandardUtils.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
			};

			uniform sampler2D _Flow;
			uniform sampler2D _FlowMask;
			uniform float4 _FlowMask_ST;
			uniform sampler2D _SpaceBG;
			uniform sampler2D _DistortionNormal;
			uniform float4 _SpaceBG_ST;
			uniform sampler2D _BgMask;
			uniform sampler2D _TextureSample0;
			uniform float4 _TextureSample0_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float2 uv0_FlowMask = i.ase_texcoord.xy * _FlowMask_ST.xy + _FlowMask_ST.zw;
				float4 tex2DNode14_g2 = tex2D( _FlowMask, uv0_FlowMask );
				float2 appendResult20_g2 = (float2(tex2DNode14_g2.r , tex2DNode14_g2.g));
				float TimeVar197_g2 = -0.55;
				float2 temp_cast_0 = (TimeVar197_g2).xx;
				float2 temp_output_18_0_g2 = ( appendResult20_g2 - temp_cast_0 );
				float4 tex2DNode72_g2 = tex2D( _Flow, temp_output_18_0_g2 );
				float4 color12 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
				float2 uv0_SpaceBG = i.ase_texcoord.xy * _SpaceBG_ST.xy + _SpaceBG_ST.zw;
				float2 MainUvs222_g1 = uv0_SpaceBG;
				float4 tex2DNode65_g1 = tex2D( _DistortionNormal, MainUvs222_g1 );
				float4 appendResult82_g1 = (float4(0.0 , tex2DNode65_g1.g , 0.0 , tex2DNode65_g1.r));
				float2 temp_output_84_0_g1 = (UnpackScaleNormal( appendResult82_g1, 1.0 )).xy;
				float2 panner179_g1 = ( 1.0 * _Time.y * float2( 0,-0.25 ) + MainUvs222_g1);
				float2 temp_output_71_0_g1 = ( temp_output_84_0_g1 + panner179_g1 );
				float4 tex2DNode96_g1 = tex2D( _SpaceBG, temp_output_71_0_g1 );
				float2 uv_BgMask232_g1 = i.ase_texcoord.xy;
				float2 uv_TextureSample0 = i.ase_texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float4 temp_output_192_0_g1 = ( tex2D( _TextureSample0, uv_TextureSample0 ) * i.ase_color );
				float4 temp_output_192_0_g2 = ( ( tex2DNode96_g1 * tex2DNode96_g1.a * tex2D( _BgMask, uv_BgMask232_g1 ).g ) + temp_output_192_0_g1 );
				
				
				finalColor = ( ( ( tex2DNode72_g2 * tex2DNode14_g2.a ) * color12 ) + temp_output_192_0_g2 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16900
338.8571;710.2858;1854;445;876.6694;379.4877;1.797612;True;False
Node;AmplifyShaderEditor.SamplerNode;2;-947.6927,-99.08829;Float;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;4;-841.5721,88.55826;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-559.8722,-113.4417;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;8;-516.97,334.0862;Float;False;Constant;_BGMove;BG Move;2;0;Create;True;0;0;False;0;0,-0.25;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;7;-563.4698,135.7862;Float;True;Property;_SpaceBG;Space BG;8;1;[NoScaleOffset];Create;True;0;0;False;0;None;359f30230637e5e43ba218de12d54516;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;9;-524.6702,485.7862;Float;True;Property;_BgMask;Bg Mask;9;1;[NoScaleOffset];Create;True;0;0;False;0;None;5f87ef94a8a601349a4efbeff79f3caf;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;5;104.7278,-109.8417;Float;False;UI-Sprite Effect Layer;0;;1;789bf62641c5cfe4ab7126850acc22b8;18,204,0,74,0,191,0,225,0,242,0,237,0,249,0,186,0,177,1,182,0,229,1,92,0,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.RangedFloatNode;16;632.2189,199.4057;Float;False;Constant;_TimeScale;TimeScale;8;0;Create;True;0;0;False;0;-0.55;-0.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;153.1627,74.65761;Float;False;Constant;_FlowTint;FlowTint;7;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;13;93.66455,425.5188;Float;True;Property;_Flow;Flow;10;1;[NoScaleOffset];Create;True;0;0;False;0;None;5f87ef94a8a601349a4efbeff79f3caf;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;101.0204,235.69;Float;True;Property;_FlowMask;FlowMask;11;1;[NoScaleOffset];Create;True;0;0;False;0;None;559d6d2dec9d4604d91b1284895da6a7;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1215.293,-83.48824;Float;False;0;0;_MainTex;Shader;0;5;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;11;638.9466,-105.756;Float;False;UI-Sprite Effect Layer;0;;2;789bf62641c5cfe4ab7126850acc22b8;18,204,1,74,1,191,1,225,0,242,0,237,0,249,0,186,0,177,1,182,0,229,1,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;17;1078.675,-127.2796;Float;False;True;2;Float;ASEMaterialInspector;0;1;Unlit/SpaceUI;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;5;192;3;0
WireConnection;5;37;7;0
WireConnection;5;181;8;0
WireConnection;5;233;9;0
WireConnection;11;192;5;0
WireConnection;11;39;12;0
WireConnection;11;37;13;0
WireConnection;11;33;14;0
WireConnection;11;40;16;0
WireConnection;17;0;11;0
ASEEND*/
//CHKSM=8A55D026CBAE03EA86E8F1DF17A5D9ACA6E213B9