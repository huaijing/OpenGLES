//
//  OCTextureLoader.cpp
//  Pods
//
//  Created by zhaopengwei on 16/3/27.
//
//

#include "OCTextureLoader.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES3/gl.h>
#include <GLKit/GLKit.h>

static inline GLuint loadBMP_custom(const char *imagepath)
{
    // Data read from the header of the BMP file
    unsigned char header[54]; // Each BMP file begins by a 54-bytes header
    unsigned int dataPos;     // Position in the file where the actual data begins
    unsigned int width, height;
    unsigned int imageSize;   // = width*height*3
    // Actual RGB data
    unsigned char * data;
    
    //Open the file
    FILE *file = fopen(imagepath, "rb");
    if (!file) {
        printf("Image could not be opened");
        return 0;
    }
    
    if ( fread(header, 1, 54, file)!=54 ){ // If not 54 bytes read : problem
        printf("Not a correct BMP file");
        return false;
    }
    
    if ( header[0]!='B' || header[1]!='M' ){
        printf("Not a correct BMP file");
        return 0;
    }
    
    // Read ints from the byte array
    dataPos    = *(int*)&(header[0x0A]);
    imageSize  = *(int*)&(header[0x22]);
    width      = *(int*)&(header[0x12]);
    height     = *(int*)&(header[0x16]);
    
    // Some BMP files are misformatted, guess missing information
    if (imageSize == 0)    imageSize = width*height*3; // 3 : one byte for each Red, Green and Blue component
    if (dataPos == 0)      dataPos = 54; // The BMP header is done that way
    
    // Create a buffer
    data = new unsigned char [imageSize];
    
    // Read the actual data from the file into the buffer
    fread(data,1,imageSize,file);
    
    // Create one OpenGL texture
    GLuint textureID;
    glGenTextures(1, &textureID);
    
    // "Bind" the newly created texture : all future texture functions will modify this texture
    glBindTexture(GL_TEXTURE_2D, textureID);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    // Give the image to OpenGL
    //        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_BGR, GL_UNSIGNED_BYTE, data);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    
    //Everything is in memory now, the file can be closed
    fclose(file);
    delete []data;
    
    return textureID;
}

static inline GLuint loadRGBA_custom(int width, int height, GLubyte *imageData)
{
    // Create one OpenGL texture
    GLuint textureID;
    glGenTextures(1, &textureID);
    
    // "Bind" the newly created texture : all future texture functions will modify this texture
    glBindTexture(GL_TEXTURE_2D, textureID);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    return textureID;
}


@implementation OCTextureLoader

+(GLuint)loadTexture:(NSString *)textureName extend:(NSString *)extendName
{
    NSString *resourceBundleName = @"textures.bundle";
    NSString *resourceName = [NSString stringWithFormat:@"%@/%@", resourceBundleName, textureName];
    
    uint64_t textureId;
    if( [extendName isEqualToString:@"bmp"] ) {
        NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:extendName];
        textureId = loadBMP_custom([path UTF8String]);
    }
    else {
        NSBundle *resBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"textures" ofType:@"bundle"]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[resBundle pathForResource:textureName ofType:extendName]];
        CGFloat widthOfImage = CGImageGetWidth(image.CGImage);
        CGFloat heightOfImage = CGImageGetHeight(image.CGImage);
        
        CFDataRef dataFromImageDataProvider = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
        GLubyte *imageData = (GLubyte *)CFDataGetBytePtr(dataFromImageDataProvider);
        
        textureId = loadRGBA_custom(widthOfImage, heightOfImage, imageData);
        //        CFRelease(image);
        CFRelease(dataFromImageDataProvider);
    }
    
    return textureId;
}

@end

