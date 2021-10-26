// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "2Ginge/Potion/Liquid_Potion" {
	Properties {
		[HDR]_Color ("Color", Color) = (1,1,1,1)
		[HDR]_SColor("Surface Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		[HDR]_EmissionColor ("Emission Color", Color) = (0,0,0,1)
		[HDR]_SEmissionColor("Surface Emission Color", Color) = (0,0,0,1)
		_EmissionScalar("Emission Intensity", Float) = 1

		_SurfaceFade ("Surface Fade", Range(0, 1)) = 0
		_VolumeFade ("Volume Fade", Range(0, 1)) = 0
		_Distortion("Distortion", float) = 0
		// for later implementation
		// _StencilMask ("Mask Layer", Range(0, 255)) = 1 
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "AlphaTest+100"}
		GrabPass{ }
		LOD 200
		Cull Front
		// Stencil {
		// 			Ref 255
		// 			WriteMask [_StencilMask]
		// 			Comp always
		// 			Pass replace
		// 		}
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting addshadow
		#pragma target 4.0

		sampler2D _MainTex;
		float _localHeight;
		uniform sampler2D _GrabTexture;
		uniform float _SurfaceFade;
		float _Distortion;
		struct Input {
			float2 uv_MainTex;
			float dif;
			float3 localPos;
			float3 worldNormal;
			float4 screenPos;
			float3 myC;
			INTERNAL_DATA
		};
		float _EmissionScalar;
		half _Glossiness;
		half _Metallic;
		float3 _EmissionColor, _SEmissionColor;
		fixed4 _Color, _SColor;
		float _level;
		//in local space;
		float4 _anchor;
		//in local space
		float4 _point;

		void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float3 worldP = mul((float4x4)unity_ObjectToWorld, v.vertex.xyz).xyz - mul((float4x4)unity_ObjectToWorld, float3(0, 0, 0)).xyz;
			o.dif = worldP.y;
			//v.normal = mul((float4x4)unity_WorldToObject, normalize(_point - _anchor));
			float3 worldNormal = mul((float4x4)unity_ObjectToWorld, v.normal.xyz).xyz;
			if (dot(normalize(UNITY_MATRIX_IT_MV[2].xyz), worldNormal.xyz) < 0.0)
			{
				o.myC = float3(1, 0, 0);
			}
			else
			{
				o.myC = float3(0, 1, 0);
			}
			v.normal = normalize(_point - _anchor);
			o.localPos = v.vertex.xyz;
			o.screenPos = ComputeScreenPos(UnityObjectToClipPos(v.vertex.xyz));
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			if(dot(normalize(IN.localPos - _point),normalize(_point - _anchor)) > 0)
			{
				discard;
			}
			fixed4 c = /*tex2D (_MainTex, IN.uv_MainTex) * */ _SColor;
			float4 offsets = normalize(UnityObjectToClipPos(float4(IN.worldNormal,1)));
			IN.screenPos.xy += offsets.xy * 0.01 * _Distortion;
			float4 sceneColor = tex2Dproj(_GrabTexture, IN.screenPos.xyzw);
			o.Albedo = lerp(c.rgb, sceneColor.rgb,_SurfaceFade);
			//o.Albedo = IN.myC;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Emission = _SEmissionColor.rgb * _EmissionScalar;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG

			Cull Back
			// Stencil {
			// 		Ref 0
			// 		Comp always
			// 		Pass replace
			// 	}
			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows vertex:vert

						// Use shader model 3.0 target, to get nicer looking lighting addshadow
			#pragma target 4.0

			sampler2D _MainTex;
		float _localHeight;
		uniform sampler2D _GrabTexture;
		uniform float _VolumeFade;
		float _Distortion;
		struct Input {
			float2 uv_MainTex;
			float dif;
			float3 localPos;
			float4 screenPos;
			float3 worldNormal;
			INTERNAL_DATA
		};
		float _EmissionScalar;
		half _Glossiness;
		half _Metallic;
		float3 _EmissionColor;
		fixed4 _Color;

		//in local space;
		float4 _anchor;
		//in local space
		float4 _point;
		float _level;
		void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float3 worldP = mul((float4x4)unity_ObjectToWorld, v.vertex.xyz).xyz - mul((float4x4)unity_ObjectToWorld, float3(0, 0, 0)).xyz;
			o.dif = worldP.y;
			o.localPos = v.vertex.xyz;
			float4 oPos = UnityObjectToClipPos(v.vertex);
			o.screenPos = ComputeGrabScreenPos(oPos);
		}

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			if (dot(normalize(IN.localPos - _point), normalize(_point - _anchor)) > 0)
			{
				discard;
			}
			if(_level <= 0.001)
			{
				//discard;//should probably just turn off the renderer.
			}
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			float4 offsets = normalize(UnityObjectToClipPos(float4(IN.worldNormal,1)));
			IN.screenPos.xy += offsets.xy * 0.01 * _Distortion;
			float4 sceneColor = tex2Dproj(_GrabTexture, IN.screenPos);
			o.Albedo = lerp(c.rgb, sceneColor.rgb,_VolumeFade);
			//o.Albedo = IN.myC;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Emission = _EmissionColor.rgb * _EmissionScalar;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
