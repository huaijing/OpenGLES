//
//  AppDelegate.h
//  Tutorial01
//
//  Created by jing huai on 2017/5/1.
//  Copyright © 2017年 jing huai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    OpenGLView* _glView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, retain) IBOutlet OpenGLView *glView;

@end

