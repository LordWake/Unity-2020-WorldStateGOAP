// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit/Sword"
{
	Properties
	{
		
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
				float4 ase_texcoord1 : TEXCOORD1;
			};

						
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float2 uv026 = v.ase_texcoord * float2( 1,1 ) + float2( 0,0 );
				float mulTime30 = _Time.y * 30.0;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_texcoord1 = v.vertex;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue = ( saturate( ( 1.0 - ( uv026.x * 1.0 ) ) ) * sin( ( ( v.vertex.xyz.z * 1.0 ) + mulTime30 ) ) * float3(0,1,0) * 0.2 );
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
				float2 uv05 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float mulTime14 = _Time.y * 50.0;
				
				
				finalColor = float4( ( ( saturate( ( 1.0 - ( uv05.x * 1.0 ) ) ) * sin( ( ( i.ase_texcoord1.xyz.x * i.ase_texcoord1.xyz.y * i.ase_texcoord1.xyz.z * 30.0 ) + mulTime14 ) ) * float3(1,1,1) * 200.0 ) * float3( 1,0,0.5 ) ) , 0.0 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16900
338.8571;552.5715;1854;603;1726.49;-537.5962;1.54229;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1339.209,-25.41465;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;10;-1305.12,257.8467;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1269.05,393.6129;Float;False;Constant;_Freq;Freq;0;0;Create;True;0;0;False;0;30;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1228.65,488.2249;Float;False;Constant;_TimeScale;TimeScale;0;0;Create;True;0;0;False;0;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1048.579,281.8023;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-1028.321,421.0471;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-980.7748,3.548084;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-936.8523,1134.994;Float;False;Constant;_OffsetTimeScale;OffsetTimeScale;0;0;Create;True;0;0;False;0;30;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;27;-1013.322,904.6157;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1047.411,621.3546;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-977.2523,1040.382;Float;False;Constant;_OffsetFreq;OffsetFreq;0;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;30;-736.5231,1067.816;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;7;-739.0651,9.361626;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-688.9769,650.3173;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-875.6121,286.2955;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-756.7811,928.5714;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;-744.6699,287.2603;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-491.6883,434.7947;Float;False;Constant;_Intensity;Intensity;0;0;Create;True;0;0;False;0;200;200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;33;-447.2674,656.1307;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;8;-541.0651,48.46154;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-583.8143,933.0646;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;18;-499.8641,271.6396;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SinOpNode;36;-452.8722,934.0294;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;38;-208.0665,916.8663;Float;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-244.322,33.84636;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;35;-249.2674,695.2307;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-199.8907,1081.564;Float;False;Constant;_OffsetIntensity;OffsetIntensity;0;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;47.47576,680.6155;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;0.6893997,27.73149;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1,0,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;25;353.8898,34.05809;Float;False;True;2;Float;ASEMaterialInspector;0;1;Unlit/Sword;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;11;0;10;1
WireConnection;11;1;10;2
WireConnection;11;2;10;3
WireConnection;11;3;12;0
WireConnection;14;0;15;0
WireConnection;6;0;5;1
WireConnection;30;0;29;0
WireConnection;7;0;6;0
WireConnection;31;0;26;1
WireConnection;13;0;11;0
WireConnection;13;1;14;0
WireConnection;32;0;27;3
WireConnection;32;1;28;0
WireConnection;17;0;13;0
WireConnection;33;0;31;0
WireConnection;8;0;7;0
WireConnection;34;0;32;0
WireConnection;34;1;30;0
WireConnection;36;0;34;0
WireConnection;9;0;8;0
WireConnection;9;1;17;0
WireConnection;9;2;18;0
WireConnection;9;3;19;0
WireConnection;35;0;33;0
WireConnection;37;0;35;0
WireConnection;37;1;36;0
WireConnection;37;2;38;0
WireConnection;37;3;39;0
WireConnection;24;0;9;0
WireConnection;25;0;24;0
WireConnection;25;1;37;0
ASEEND*/
//CHKSM=F188A94FB52A9DAFCE3B8C773562B009F81F976A