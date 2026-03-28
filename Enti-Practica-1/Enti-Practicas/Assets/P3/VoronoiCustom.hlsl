#ifndef VORONOI_CUSTOM_INCLUDED
#define VORONOI_CUSTOM_INCLUDED

float2 hash22(float2 p)
{
    p = float2(dot(p, float2(127.1, 311.7)),
               dot(p, float2(269.5, 183.3)));
    return frac(sin(p) * 43758.5453123);
}

void VoronoiCustom_float(float2 UV, float CellDensity, out float EdgeDistance)
{
    float2 p = UV * CellDensity;
    float2 n = floor(p);
    float2 f = frac(p);

    float2 mr = 0.0;
    float2 mg = 0.0;
    float md = 8.0;

    for (int j = -1; j <= 1; j++)
    {
        for (int i = -1; i <= 1; i++)
        {
            float2 g = float2(i, j);
            float2 o = hash22(n + g);
            float2 r = g + o - f;
            float d = dot(r, r);

            if (d < md)
            {
                md = d;
                mr = r;
                mg = g;
            }
        }
    }

    float edge = 8.0;

    for (int j = -2; j <= 2; j++)
    {
        for (int i = -2; i <= 2; i++)
        {
            float2 g = mg + float2(i, j);
            float2 o = hash22(n + g);
            float2 r = g + o - f;

            float2 diff = r - mr;
            float len2 = dot(diff, diff);

            if (len2 > 0.00001)
            {
                float dist = dot(0.5 * (mr + r), normalize(diff));
                edge = min(edge, dist);
            }
        }
    }

    EdgeDistance = edge;
}

#endif