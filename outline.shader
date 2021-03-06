Shader "Outline Shader"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" { }
	_OutlineColor("Outline Color", Color) = (1, 0.27, 0.016, 1)
		_OutlineWidth("Outline width", Range(0.0, 1.0)) = .005
	}

		SubShader
	{
		Pass
	{
		Cull front

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f
	{
		float4 pos : POSITION;
	};

	uniform float _OutlineWidth;
	uniform float4 _OutlineColor;

	v2f vert(appdata v)
	{
		v2f o;

		float3 norm = normalize(v.normal);
		v.vertex.xyz += v.normal * _OutlineWidth;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

		return o;
	}

	half4 frag(v2f i) : COLOR
	{
		return _OutlineColor;
	}
		ENDCG
	}

		Pass
	{
		SetTexture[_MainTex]
	{
		Combine Primary * Texture
	}
	}
	}
}
