// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "2Ginge/Potion/Liquid_Potion_Texture" {
	Properties {
		[HDR]_Color("Color", Color) = (1, 1, 1, 1)
		[HDR]_SColor("Surface Color", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SurfaceTex ("SurfaceTex (RGB)", 2D) = "white" {}
		_SurfaceTexAnim ("Animation, (x, y, u,v)", Vector) = (1,1,0,0)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		[HDR]_EmissionColor("Emission Color", Color) = (0, 0, 0, 1)
		[HDR]_SEmissionColor("Surface Emission Color", Color) = (0, 0, 0, 1)
		_EmissionScalar("Emission Intensity", Float) = 1
		_Ival("Animation Speed", Float) = 1
		[HDR]_SurfaceTint("Surface Tex Tint", Color) = (1, 1, 1, 0.5)
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

		sampler2D _MainTex,_SurfaceTex;
		float _localHeight;
		uniform sampler2D _GrabTexture;
		uniform float _SurfaceFade;
		float _Distortion;
		struct Input {
			float2 uv_MainTex;
			float dif;
			float3 localPos;
			float3 myC;
			float4 screenPos;
			float4 pos;
			float3 worldNormal;
			float4 cPos;
			INTERNAL_DATA
		};

		float _EmissionScalar;
		half _Glossiness;
		half _Metallic , _SurfaceVal;
		float3 _EmissionColor,_SEmissionColor;
		fixed4 _Color,_SColor,_SurfaceTint;
		float4 _SurfaceTexAnim;
		//in local space;
		float4 _anchor;
		//in local space
		float _Ival;
		float4 _point;
		float _level;
		float4 _TL,_BL,_TR,_BR, _CENTER;
		float2 GetNDir(float2 side, float2 mid, float2 side2, float t)
		{

			if(t > 0.5)
			{
				return lerp(mid, side2, (t - 0.5) * 2);
			}
			return lerp(side, mid, t * 2);
		}

		//line intersection
		float2 LineLineIntersection(inout bool f,float2 p1, float2 d1, float2 p2, float2 d2)
		{
		
			float3 lineVec3 = float3(p1 - p2,0);
			float3 crossVec1and2 = cross(float3(d1,0), float3(d2,0));
			float3 crossVec3and2 = cross(lineVec3, float3(d2,0));
			
			float planarFactor = dot(lineVec3, crossVec1and2);
 
			//is coplanar, and not parrallel
			if(abs(planarFactor) < 0.0001f && length(crossVec1and2) > 0.0001f)
			{
				float s = dot(crossVec3and2, crossVec1and2) / length(crossVec1and2);
				float2 intersection = p1.xy + (d1.xy * s);
				f = true;
				return intersection.xy;
			}
			else
			{
				f = false;
				return float2(0,0);
			}
		}
		void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float3 worldP = mul((float4x4)unity_ObjectToWorld, v.vertex.xyz).xyz - mul((float4x4)unity_ObjectToWorld, float3(0, 0, 0)).xyz;
			o.dif = worldP.y;
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
			float4 ps = UnityObjectToClipPos(float3(0,0,0));
			o.cPos = ComputeScreenPos(ps);
			o.screenPos = ComputeScreenPos(UnityObjectToClipPos(v.vertex.xyz));
			
			
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			//calculate the screenpositions of the points (uv projection), this is for mapping the texture to the space.
			float4 tmp = ComputeScreenPos(UnityObjectToClipPos(_TL.xyz));
			float2 n_TL = tmp.xy / tmp.w;
			tmp = ComputeScreenPos(UnityObjectToClipPos(_TR.xyz));
			float2 n_TR = tmp.xy / tmp.w;
			tmp = ComputeScreenPos(UnityObjectToClipPos(_BL.xyz));
			float2 n_BL = tmp.xy / tmp.w;
			tmp = ComputeScreenPos(UnityObjectToClipPos(_BR.xyz));
			float2 n_BR = tmp.xy / tmp.w;

			// Albedo comes from a texture tinted by color
			if(dot(normalize(IN.localPos - _point),normalize(_point - _anchor)) > -0.001f)
			{
				discard;
			}
			float2 a1 = n_TL.xy;
			float2 b1 = n_TR.xy;
			float2 c1 = n_BR.xy;
			float2 d1 = n_BL.xy;
			bool b;
			float2 screenUV = IN.screenPos.xy / IN.screenPos.w;
			tmp = ComputeScreenPos(UnityObjectToClipPos(_CENTER.xyz));
			float2 cUV = tmp.xy / tmp.w;
			/// clean X
			//start at the top left corner, line from a to b, from the point on the screen, in the line (d to a)
			//find the closest  point to either (d + a)/2 or (b + c)/2
			float2 xdir = normalize(a1 - d1);
			float2 Xpos = LineLineIntersection(b, a1, normalize(b1 - a1), screenUV, xdir);
			
			float2 XMAX = LineLineIntersection(b, a1, normalize(b1 - a1), (b1 + c1)/2, normalize(b1 - c1));
			float2 XMIN = LineLineIntersection(b, b1, normalize(a1 - b1), (a1 + d1)/2, normalize(a1 - d1));
			//now that we have the first x coord, lets re-evaluate it and blend dir;
			float xdist = length(Xpos - a1) / length(a1 - b1);
			//now blend the dir;
			//xdir = normalize(lerp(normalize(a1.p - d1.p),normalize(b1.p - c1.p), xdist));
			//using new function:
			xdir = normalize(GetNDir(normalize(a1 - d1), normalize((a1 + b1)/2 - cUV), normalize(b1 - c1), xdist));
			//now resample the x;
			Xpos = LineLineIntersection(b, a1, normalize(b1 - a1), screenUV, xdir);
			//second Sample
			//float2 Xpos2 = LineLineIntersection(b, b1.p, normalize(a1.p - b1.p), screenUV, xdir);
			//REevaluate // length(Xpos - a1.p) / (length(a1.p - XMAX)), // length(Xpos2 - b1.p) / (length(b1.p - XMIN))
			xdist = length(Xpos - a1) / (length(a1 - XMAX));
			//re, second deriv

			xdir = normalize(GetNDir(normalize(a1 - d1), normalize((a1 + b1)/2 - (d1 + c1)/2), normalize(b1 - c1), xdist));
			Xpos = LineLineIntersection(b, a1, normalize(b1 - a1), screenUV, xdir);
			xdist = length(Xpos - a1) / (length(a1 - XMAX));

			//clean Y
			float2 ydir = normalize(a1 - b1);
			float2 Ypos = LineLineIntersection(b, a1, normalize(d1 - a1), screenUV, ydir);
			
			float2 YMAX = LineLineIntersection(b, a1, normalize(d1 - a1), (d1 + c1)/2, normalize(d1 - c1));
			float2 YMIN = LineLineIntersection(b, a1, normalize(d1 - a1), (a1 + b1)/2, normalize(a1 - b1));
			//now that we have the first x coord, lets re-evaluate it and blend dir;
			float ydist = length(Ypos - b1) / length(c1 - b1);
			//now blend the dir;
			//using new function:
			ydir = normalize(GetNDir(normalize(a1 - b1), normalize((a1 + d1)/2 - cUV), normalize(d1 - c1), ydist));
			//now resample the x;
			Ypos = LineLineIntersection(b, a1, normalize(d1 - a1), screenUV, ydir);
			//second Sample
			//REevaluate // length(Xpos - a1.p) / (length(a1.p - XMAX)), // length(Xpos2 - b1.p) / (length(b1.p - XMIN))
			ydist = length(Ypos - a1) / (length(a1 - YMAX));
			//re, second deriv

			ydir = normalize(GetNDir(normalize(a1 - b1), normalize((a1 + d1)/2 - cUV), normalize(d1 - c1), ydist));
			Ypos = LineLineIntersection(b, a1, normalize(d1 - a1), screenUV, ydir);
			ydist = length(Ypos - a1) / (length(a1 - YMAX));



			int uvSegment = _Time.y * _Ival *100;

			//
			int uvSx = (int)uvSegment %  ((int)_SurfaceTexAnim.x);
			int uvSy = uvSegment / ((int)_SurfaceTexAnim.x);



			float2 frameSize = float2(1.0/(int)_SurfaceTexAnim.x * uvSx + _SurfaceTexAnim.z * _Time.x,1.0/(int)_SurfaceTexAnim.y * uvSy * -1 + _SurfaceTexAnim.w * _Time.x);
			float2 uvs = frameSize + float2(xdist/_SurfaceTexAnim.x,ydist/_SurfaceTexAnim.y);

			//uvs = float2(xdist/_SurfaceTexAnim.x,ydist/_SurfaceTexAnim.y);

			float4 col = tex2D(_SurfaceTex, uvs) * _SurfaceTint;
			fixed4 c = lerp(_SColor,col,col.a * _SurfaceTint.a);
			float4 offsets = normalize(UnityObjectToClipPos(float4(IN.worldNormal,1)));
			IN.screenPos.xy += offsets.xy * 0.01 * _Distortion;
			float4 sceneColor = tex2Dproj(_GrabTexture, IN.screenPos);
			o.Albedo = lerp(c.rgb, sceneColor.rgb,_SurfaceFade);
			//o.Albedo = IN.myC;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Emission = (_SEmissionColor.rgb * _EmissionScalar);
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
			float4 screenPos;
			float3 worldNormal;
			float3 localPos;
			INTERNAL_DATA
		};
		
		float _EmissionScalar;
		half _Glossiness;
		half _Metallic;
		float3 _EmissionColor;
		fixed4 _Color;
		float _level;
		//in local space;
		float4 _anchor;
		//in local space
		float4 _point;

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
			float4 offsets = normalize(UnityObjectToClipPos(float4(IN.worldNormal,1)));
			IN.screenPos.xy += offsets.xy * 0.01 * _Distortion;
			float4 sceneColor = tex2Dproj(_GrabTexture, IN.screenPos);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			//o.Albedo = c.rgb;
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
