// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/PostProcess/HitReaction"
{
	Properties
	{
		_MoveScene("Move Scene", Range( 0 , 25)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			
		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _MoveScene;

			
			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoord;
				float4 ase_ppsScreenPosNorm = float4(o.texcoord,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosNorm = float4(i.texcoord,0,1);

				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 break5 = ( _MainTex_TexelSize * _MoveScene );
				float temp_output_100_0_g1 = break5.x;
				float PosX63_g1 = temp_output_100_0_g1;
				float2 uv0_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 Center93_g1 = uv0_MainTex;
				float NegX68_g1 = -temp_output_100_0_g1;
				float temp_output_95_0_g1 = break5.y;
				float PosY69_g1 = temp_output_95_0_g1;
				float2 appendResult10_g19 = (float2(NegX68_g1 , PosY69_g1));
				float4 tex2DNode1_g19 = tex2D( _MainTex, ( Center93_g1 + appendResult10_g19 ) );
				float TopLeft64_g1 = sqrt( ( ( tex2DNode1_g19.r * tex2DNode1_g19.r ) + ( tex2DNode1_g19.g * tex2DNode1_g19.g ) + ( tex2DNode1_g19.b * tex2DNode1_g19.b ) ) );
				float2 appendResult10_g22 = (float2(NegX68_g1 , NegX68_g1));
				float4 tex2DNode1_g22 = tex2D( _MainTex, ( Center93_g1 + appendResult10_g22 ) );
				float BottomLeft75_g1 = sqrt( ( ( tex2DNode1_g22.r * tex2DNode1_g22.r ) + ( tex2DNode1_g22.g * tex2DNode1_g22.g ) + ( tex2DNode1_g22.b * tex2DNode1_g22.b ) ) );
				float NegY71_g1 = -temp_output_95_0_g1;
				float2 appendResult10_g20 = (float2(PosX63_g1 , NegY71_g1));
				float4 tex2DNode1_g20 = tex2D( _MainTex, ( Center93_g1 + appendResult10_g20 ) );
				float BottomRight99_g1 = sqrt( ( ( tex2DNode1_g20.r * tex2DNode1_g20.r ) + ( tex2DNode1_g20.g * tex2DNode1_g20.g ) + ( tex2DNode1_g20.b * tex2DNode1_g20.b ) ) );
				float temp_output_49_0_g1 = ( ( -PosX63_g1 + ( TopLeft64_g1 * -2.0 ) + -BottomLeft75_g1 + BottomRight99_g1 + ( NegX68_g1 * 2.0 ) + PosY69_g1 ) / 6.0 );
				float2 appendResult10_g26 = (float2(0.0 , PosY69_g1));
				float4 tex2DNode1_g26 = tex2D( _MainTex, ( Center93_g1 + appendResult10_g26 ) );
				float Top29_g1 = sqrt( ( ( tex2DNode1_g26.r * tex2DNode1_g26.r ) + ( tex2DNode1_g26.g * tex2DNode1_g26.g ) + ( tex2DNode1_g26.b * tex2DNode1_g26.b ) ) );
				float2 appendResult10_g25 = (float2(0.0 , NegY71_g1));
				float4 tex2DNode1_g25 = tex2D( _MainTex, ( Center93_g1 + appendResult10_g25 ) );
				float Bottom76_g1 = sqrt( ( ( tex2DNode1_g25.r * tex2DNode1_g25.r ) + ( tex2DNode1_g25.g * tex2DNode1_g25.g ) + ( tex2DNode1_g25.b * tex2DNode1_g25.b ) ) );
				float temp_output_52_0_g1 = ( ( PosX63_g1 + ( Top29_g1 * 2.0 ) + -BottomLeft75_g1 + -BottomRight99_g1 + ( Bottom76_g1 * -2.0 ) + PosY69_g1 ) / 6.0 );
				float temp_output_6_105 = sqrt( ( ( temp_output_49_0_g1 * temp_output_49_0_g1 ) + ( temp_output_52_0_g1 * temp_output_52_0_g1 ) ) );
				float4 temp_cast_0 = (temp_output_6_105).xxxx;
				float4 lerpResult10 = lerp( tex2D( _MainTex, uv_MainTex ) , temp_cast_0 , temp_output_6_105);
				

				float4 color = lerpResult10;
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16900
338.8571;714.2858;1854;441;1579.357;325.1495;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1196.092,-198.4697;Float;False;0;0;_MainTex_TexelSize;Pass;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1185.092,-19.46966;Float;False;Property;_MoveScene;Move Scene;0;0;Create;True;0;0;False;0;0;0;0;25;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;7;-907.8944,-252.1688;Float;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-888.092,-158.4697;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-681.9438,-367.793;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-710.7669,-634.9322;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;5;-711.0422,-168.9755;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;6;-385.8152,-279.1608;Float;False;Sobel Convolution Kernels;-1;;1;4fe5afdda5c7ab64596840db9e964e14;0;4;96;FLOAT2;0,0;False;30;SAMPLER2D;0,0;False;100;FLOAT;0;False;95;FLOAT;0;False;2;FLOAT;104;FLOAT;105
Node;AmplifyShaderEditor.WireNode;11;-323.2779,-372.787;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;10;-8.738619,-346.9917;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;251.875,-332.3357;Float;False;True;2;Float;ASEMaterialInspector;0;2;Hidden/PostProcess/HitReaction;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;8;2;7;0
WireConnection;9;0;7;0
WireConnection;5;0;2;0
WireConnection;6;96;8;0
WireConnection;6;30;7;0
WireConnection;6;100;5;0
WireConnection;6;95;5;1
WireConnection;11;0;9;0
WireConnection;10;0;11;0
WireConnection;10;1;6;105
WireConnection;10;2;6;105
WireConnection;0;0;10;0
ASEEND*/
//CHKSM=4D191921430E75A92FC9F7A941ECE976B3FAAA67