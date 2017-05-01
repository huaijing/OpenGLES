uniform mat4 projection;
uniform mat4 modelView;
attribute vec4 vPosition; 

attribute vec2 vTextureCoord;

varying vec2 vTextureCoordOut;

void main(void)
{
//    gl_Position = projection * modelView * vPosition;
    
    gl_Position = vPosition;
    vTextureCoordOut = vTextureCoord;
}
