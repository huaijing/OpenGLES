//
//  OpenGLView.h
//  Tutorial01
//
//  Created by kesalin on 12-11-24.
//  Copyright (c) 2012年 Created by kesalin@gmail.com on. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include "ksMatrix.h"
#include "OCTextureLoader.h"

@interface OpenGLView : UIView {
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    GLuint _frameBuffer;
    
    GLuint _programHandle;
    GLuint _positionSlot;
    GLint _modelViewSlot;
    GLint _projectionSlot;
    
    ksMatrix4 _modelViewMatrix;
    ksMatrix4 _projectionMatrix;
    
    float _posX;
    float _posY;
    float _posZ;
    
    float _rotateX;
    float _scaleZ;
    
    // For texture
    //
    OCTextureLoader *m_textureLoader;
    unsigned int m_texture;
    GLint _textureCoordSlot;
    GLint _samplerSlot;
    unsigned int m_uMatrix;
    GLint _attrpos;
    GLint _attrtex;
}

@property (nonatomic, assign) float posX;
@property (nonatomic, assign) float posY;
@property (nonatomic, assign) float posZ;

@property (nonatomic, assign) float scaleZ;
@property (nonatomic, assign) float rotateX;

- (void)resetTransform;
- (void)render;
- (void)cleanup;
- (void)toggleDisplayLink;

@end
