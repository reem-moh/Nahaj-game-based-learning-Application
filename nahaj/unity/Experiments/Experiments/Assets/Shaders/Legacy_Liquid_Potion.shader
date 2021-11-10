Shader "2Ginge/Potion/Legacy_Liquid_Potion"
{
	Properties
	{
		//_MainTex("Albedo (RGB)", 2D) = "white" {}
			[HDR]_SEmissionColor("Surface Emission Color", Color) = (1, 1, 1, 1)
			[HDR]_EmissionColor("Volume Emission Color", Color) = (1,1, 1, 1)
			_EmissionScalar("Emission Intensity", Float) = 1
			// for later implementation
			// _StencilMask ("Mask Layer", Range(0, 255)) = 1 
	}
	SubShader
		{
			Pass
			{
				Tags{ "RenderType" = "Opaque" "Queue" = "AlphaTest+100" }
				LOD 200
				Cull Front
				// Stencil {
				// 	Ref 255
				// 	WriteMask [_StencilMask]
				// 	Comp always
				// 	Pass replace
				// }
				CGPROGRAM

#pragma vertex vert
#pragma fragment frag
				// make fog work
#pragma multi_compile_fog

#include "UnityCG.cginc"
#pragma target 2.0
				float _localHeight;
				float _EmissionScalar;
				float4 _SEmissionColor;
				//in local space;
				float4 _anchor;
				//in local space
				float4 _point;
				float _level;
				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
					float3 normal : NORMAL;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					UNITY_FOG_COORDS(1)
						float4 vertex : SV_POSITION;
					//float dif; // now stored in localPos.w;
					float4 localPos : TEXCOORD5;
					float4 screenPos : TEXCOORD2;
					float3 myC : TEXCOORD3;
					float3 nrm : TEXCOORD4;
				};

				//sampler2D _MainTex;
				float4 _MainTex_ST;

				v2f vert(appdata v)
				{
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					float3 worldP = mul((float4x4)unity_ObjectToWorld, v.vertex) - mul((float4x4)unity_ObjectToWorld, float4(0, 0, 0,0));
						o.localPos.w = worldP.y;
					o.localPos.xyz = v.vertex.xyz;

					float3 worldNormal = mul((float4x4)unity_ObjectToWorld, float4(v.normal,0));
						if (dot(normalize(UNITY_MATRIX_IT_MV[2].xyz), worldNormal.xyz) < 0.0)
						{
							o.myC = float3(1, 0, 0);
						}
						else
						{
							o.myC = float3(0, 1, 0);
						}
					v.normal = normalize(_point - _anchor);
					o.screenPos = ComputeScreenPos(UnityObjectToClipPos(v.vertex.xyz));

					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					UNITY_TRANSFER_FOG(o, o.vertex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					if (dot(normalize(i.localPos.xyz - _point), normalize(_point - _anchor)) > 0)
					{
						discard;
					}
					// sample the texture
					fixed4 col =  _SEmissionColor * _EmissionScalar;
					// apply fog
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
					ENDCG
			}
				
			Pass
			{
				Tags{ "RenderType" = "Opaque" "Queue" = "AlphaTest+100" }
				LOD 200
				Cull Back
				// Stencil {
				// 	Ref 0
				// 	Comp always
				// 	Pass replace
				// }
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
								// make fog work
				#pragma multi_compile_fog

				#include "UnityCG.cginc"
				#pragma target 2.0


				float _localHeight;
				float _EmissionScalar;
				float4 _EmissionColor;
				//in local space;
				float4 _anchor;
				//in local space
				float4 _point;
				float _level;
				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
					float3 normal : NORMAL;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					UNITY_FOG_COORDS(1)
						float4 vertex : SV_POSITION;
					//float dif; // now stored in localPos.w;
					float4 localPos : TEXCOORD5;
					float4 screenPos : TEXCOORD2;
					float3 myC : TEXCOORD3;
					float3 nrm : TEXCOORD4;
				};

				//sampler2D _MainTex;
				float4 _MainTex_ST;

				v2f vert(appdata v)
				{
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					float3 worldP = mul((float4x4)unity_ObjectToWorld, v.vertex) - mul((float4x4)unity_ObjectToWorld, float4(0, 0, 0,0));
						o.localPos.w = worldP.y;
					o.localPos.xyz = v.vertex.xyz;

					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					UNITY_TRANSFER_FOG(o, o.vertex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					if (dot(normalize(i.localPos.xyz - _point), normalize(_point - _anchor)) > 0)
					{
						discard;
					}
					// sample the texture
					fixed4 col = _EmissionColor * _EmissionScalar;
					// apply fog
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
					ENDCG
			}
		}
}

