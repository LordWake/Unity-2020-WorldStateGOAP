// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/PostProcess/PlayerDamaged"
{
	Properties
	{
		_LerpRed("LerpRed", Range( 0 , 1)) = 0.2783677
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
			
			uniform float _LerpRed;

			
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

				float4 color4 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float grayscale3 = Luminance(tex2D( _MainTex, uv_MainTex ).rgb);
				float4 temp_cast_1 = (grayscale3).xxxx;
				float4 lerpResult6 = lerp( ( color4 * grayscale3 ) , temp_cast_1 , _LerpRed);
				

				float4 color = lerpResult6;
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16900
338.8571;714.2858;1854;441;1037.312;182.4768;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-863.9907,-48.91938;Float;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-678.9907,-39.91938;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;3;-351.9906,-15.91939;Float;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-393.0019,-221.7224;Float;False;Constant;_Tint;Tint;0;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-131.9815,-199.3538;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-213.9735,125.576;Float;False;Property;_LerpRed;LerpRed;0;0;Create;True;0;0;False;0;0.2783677;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;6;168.2265,-53.82395;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;378.9788,-88.14278;Float;False;True;2;Float;ASEMaterialInspector;0;2;Hidden/PostProcess/PlayerDamaged;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;3;0;2;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;6;0;5;0
WireConnection;6;1;3;0
WireConnection;6;2;7;0
WireConnection;0;0;6;0
ASEEND*/
//CHKSM=38173C797E8302D46C33B0A984D05AA0515C5392