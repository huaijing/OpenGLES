//uniform mat4 projection;
//uniform mat4 modelView;
//attribute vec4 vPosition; 
//
//attribute vec2 vTextureCoord;
//varying vec2 vTextureCoordOut;
//
//void main(void)
//{
//    gl_Position = projection * modelView * vPosition;
//    
//    vTextureCoordOut = vTextureCoord;
//}

attribute vec2 aPos;
attribute vec2 aCoord;
varying vec2   textureCoordinate;
//uniform mat4   uMat;

void main(void) {
//    gl_Position = uMat * vec4(aPos,0.,1.);
    gl_Position = vec4(aPos, 0., 1.);

    textureCoordinate = aCoord;
}
