#ifndef VORONOI_CUSTOM_INCLUDED
#define VORONOI_CUSTOM_INCLUDED

float2 random2(float2 p)
{
    return frac(sin(float2(
        dot(p, float2(127.1, 311.7)),
        dot(p, float2(269.5, 183.3))
    )) * 43758.5453);
}

void VoronoiCustom_float(float2 UV, float CellDensity, out float DistanceOut)
{
    float2 g = floor(UV * CellDensity);
    float2 f = frac(UV * CellDensity);

    float minDist = 10.0;

    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 lattice = float2(x, y);
            float2 cellPoint = random2(g + lattice);
            float2 diff = lattice + cellPoint - f;
            float dist = length(diff);

            minDist = min(minDist, dist);
        }
    }

    DistanceOut = minDist;
}

#endif