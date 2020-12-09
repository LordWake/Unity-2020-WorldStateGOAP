// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PBROpaque/HeroBloodLerpShader"
{
	Properties
	{
		_BloodAmount("BloodAmount", Range( 0 , 1)) = 0
		_HeroAlbedo("Hero Albedo ", 2D) = "white" {}
		_HeroNormal("Hero Normal", 2D) = "bump" {}
		_HeroEmissive("Hero Emissive", 2D) = "white" {}
		_HeroMetallic("Hero Metallic", 2D) = "white" {}
		_HeroBloodyAlbedo("Hero Bloody Albedo", 2D) = "white" {}
		_HeroBloodyNormal("Hero Bloody Normal", 2D) = "white" {}
		_HeroBloodyEmissive("Hero Bloody Emissive", 2D) = "white" {}
		_HeroBloodyMetallic("Hero Bloody Metallic", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  "ReplacementPlayer"="PlayerLifeView" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _HeroBloodyNormal;
		uniform float4 _HeroBloodyNormal_ST;
		uniform sampler2D _HeroNormal;
		uniform float4 _HeroNormal_ST;
		uniform float _BloodAmount;
		uniform sampler2D _HeroBloodyAlbedo;
		uniform float4 _HeroBloodyAlbedo_ST;
		uniform sampler2D _HeroAlbedo;
		uniform float4 _HeroAlbedo_ST;
		uniform sampler2D _HeroBloodyEmissive;
		uniform float4 _HeroBloodyEmissive_ST;
		uniform sampler2D _HeroEmissive;
		uniform float4 _HeroEmissive_ST;
		uniform sampler2D _HeroBloodyMetallic;
		uniform float4 _HeroBloodyMetallic_ST;
		uniform sampler2D _HeroMetallic;
		uniform float4 _HeroMetallic_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_HeroBloodyNormal = i.uv_texcoord * _HeroBloodyNormal_ST.xy + _HeroBloodyNormal_ST.zw;
			float2 uv_HeroNormal = i.uv_texcoord * _HeroNormal_ST.xy + _HeroNormal_ST.zw;
			float4 lerpResult12 = lerp( tex2D( _HeroBloodyNormal, uv_HeroBloodyNormal ) , float4( UnpackNormal( tex2D( _HeroNormal, uv_HeroNormal ) ) , 0.0 ) , _BloodAmount);
			o.Normal = lerpResult12.rgb;
			float2 uv_HeroBloodyAlbedo = i.uv_texcoord * _HeroBloodyAlbedo_ST.xy + _HeroBloodyAlbedo_ST.zw;
			float2 uv_HeroAlbedo = i.uv_texcoord * _HeroAlbedo_ST.xy + _HeroAlbedo_ST.zw;
			float4 lerpResult13 = lerp( tex2D( _HeroBloodyAlbedo, uv_HeroBloodyAlbedo ) , tex2D( _HeroAlbedo, uv_HeroAlbedo ) , _BloodAmount);
			o.Albedo = lerpResult13.rgb;
			float2 uv_HeroBloodyEmissive = i.uv_texcoord * _HeroBloodyEmissive_ST.xy + _HeroBloodyEmissive_ST.zw;
			float2 uv_HeroEmissive = i.uv_texcoord * _HeroEmissive_ST.xy + _HeroEmissive_ST.zw;
			float4 lerpResult11 = lerp( tex2D( _HeroBloodyEmissive, uv_HeroBloodyEmissive ) , tex2D( _HeroEmissive, uv_HeroEmissive ) , _BloodAmount);
			o.Emission = lerpResult11.rgb;
			float2 uv_HeroBloodyMetallic = i.uv_texcoord * _HeroBloodyMetallic_ST.xy + _HeroBloodyMetallic_ST.zw;
			float2 uv_HeroMetallic = i.uv_texcoord * _HeroMetallic_ST.xy + _HeroMetallic_ST.zw;
			float4 lerpResult10 = lerp( tex2D( _HeroBloodyMetallic, uv_HeroBloodyMetallic ) , tex2D( _HeroMetallic, uv_HeroMetallic ) , _BloodAmount);
			o.Metallic = lerpResult10.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
338.8571;714.2858;1854;441;2812.009;786.4695;3.24633;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-915.9683,226.3301;Float;False;Property;_BloodAmount;BloodAmount;0;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-970.6124,-573.293;Float;True;Property;_HeroAlbedo;Hero Albedo ;1;0;Create;True;0;0;False;0;80f6031b8383e1841ae06186931c38df;80f6031b8383e1841ae06186931c38df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-963.2212,-382.8584;Float;True;Property;_HeroBloodyAlbedo;Hero Bloody Albedo;5;0;Create;True;0;0;False;0;9c1d47708e779884c942fc6970a7da8e;9c1d47708e779884c942fc6970a7da8e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-976.4542,-189.9519;Float;True;Property;_HeroNormal;Hero Normal;2;0;Create;True;0;0;False;0;7714133e9bbfdaf4a84ff741019850fe;7714133e9bbfdaf4a84ff741019850fe;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-964.7005,15.57077;Float;True;Property;_HeroBloodyNormal;Hero Bloody Normal;6;0;Create;True;0;0;False;0;009a601cb8fa15a4daccaf5f07aaa95b;009a601cb8fa15a4daccaf5f07aaa95b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-969.869,308.7195;Float;True;Property;_HeroEmissive;Hero Emissive;3;0;Create;True;0;0;False;0;8eaec95156094e64e8fade070fe74322;8eaec95156094e64e8fade070fe74322;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-955.0963,503.1315;Float;True;Property;_HeroBloodyEmissive;Hero Bloody Emissive;7;0;Create;True;0;0;False;0;a05851e78322cf8408dd1ac46a4205f5;a05851e78322cf8408dd1ac46a4205f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-949.8458,695.0836;Float;True;Property;_HeroMetallic;Hero Metallic;4;0;Create;True;0;0;False;0;d760b1cf5ea53f8479e8e005c69a6117;d760b1cf5ea53f8479e8e005c69a6117;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-934.0628,890.9553;Float;True;Property;_HeroBloodyMetallic;Hero Bloody Metallic;8;0;Create;True;0;0;False;0;6811d0364d0de8b4e808c95242e19af2;6811d0364d0de8b4e808c95242e19af2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;10;-289.5583,334.7053;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;11;-295.9969,218.4328;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;12;-296.4379,93.61179;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;13;-301.9913,-54.35306;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;PBROpaque/HeroBloodLerpShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;1;ReplacementPlayer=PlayerLifeView;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;10;1;8;0
WireConnection;10;2;1;0
WireConnection;11;0;7;0
WireConnection;11;1;6;0
WireConnection;11;2;1;0
WireConnection;12;0;5;0
WireConnection;12;1;4;0
WireConnection;12;2;1;0
WireConnection;13;0;3;0
WireConnection;13;1;2;0
WireConnection;13;2;1;0
WireConnection;0;0;13;0
WireConnection;0;1;12;0
WireConnection;0;2;11;0
WireConnection;0;3;10;0
ASEEND*/
//CHKSM=9B935E269016BCAC31FA4261C84D59603029EC88