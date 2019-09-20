import lib-sampler.glsl

//: param auto channel_basecolor
uniform SamplerSparse basecolor_tex;

//: param auto channel_normal
uniform SamplerSparse normal_tex;

//: param custom {
//:  "default": 1.0,
//:   "min": 0.0,
//:   "max": 10.0,
//:   "label": "flow power"
//: }
uniform float FlowPower;

//: param custom {
//:  "default": 0.5,
//:   "min": 0.0,
//:   "max": 1.0,
//:   "label": "blend ratio"
//: }
uniform float BlendRatio;

//: param custom {
//:   "default": 0.25,
//:   "min": 0.0,
//:   "max": 10.0,
//:   "label": "time speed"
//: }
uniform float TimeSpeed;


//: param custom {
//:   "default": 0.0,
//:   "min": 0.0,
//:   "max": 1.0,
//:   "label": "time",
//:   "visible" : true 
//: }
uniform float Time;

void shade(V2F inputs)
{
    vec3 flowVal = getBaseColor(normal_tex, inputs.sparse_coord);
    flowVal = (flowVal * 2 - 1) * FlowPower;
    float dif1 = fract(Time * TimeSpeed + BlendRatio);
    float dif2 = fract(Time * TimeSpeed);
    float lerpVal = abs( (0.5 - dif1) / 0.5);
    SparseCoord coord1 = getSparseCoord(vec2(inputs.tex_coord.x - flowVal.x * dif1, inputs.tex_coord.y - flowVal.y * dif1));
    vec3 col1 = getBaseColor(basecolor_tex, coord1);
    SparseCoord coord2 = getSparseCoord(vec2(inputs.tex_coord.x - flowVal.x * dif2, inputs.tex_coord.y - flowVal.y * dif2));
    vec3 col2 = getBaseColor(basecolor_tex, coord2);
    vec3 color = mix(col1, col2, lerpVal);
    diffuseShadingOutput(color);
}
