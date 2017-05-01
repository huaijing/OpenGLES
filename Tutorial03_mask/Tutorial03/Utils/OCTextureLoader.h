//
//  OCTextureLoader.hpp
//  Pods
//
//  Created by zhaopengwei on 16/3/27.
//
//

#ifndef OCTextureLoader_h
#define OCTextureLoader_h

@interface OCTextureLoader :  NSObject

+(GLuint)loadTexture:(NSString *)textureName extend:(NSString *)extendName;

@end

#endif /* OCTextureLoader_hpp */
