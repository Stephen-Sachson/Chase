//
//  IntroScene.m
//  Chase
//
//  Created by deepfocus-004 on 8/1/14.
//  Copyright deepfocus-004 2014. All rights reserved.


#import "PlayScene.h"

@implementation PlayScene

#pragma mark - Create & Destroy

+ (PlayScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
    
	return self;
}

@end
