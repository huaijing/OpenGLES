precision mediump float;

varying vec2 vTextureCoordOut;

uniform sampler2D Sampler;

void main()
{
//    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_FragColor = texture2D(Sampler, vTextureCoordOut);
}
