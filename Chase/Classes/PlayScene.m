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
    
    CCSprite *bgSprite=[CCSprite spriteWithImageNamed:@"bg.png"];
    bgSprite.contentSize = [[CCDirector sharedDirector] viewSize];
    [self addChild:bgSprite];
    
    CCPhysicsNode *physics=[CCPhysicsNode node];
    physics.gravity=ccp(0, -980);
    [self addChild:physics];
    
    CGRect outRect=CGRectZero;
    outRect.size=[CCDirector sharedDirector].viewSize;
    CCNode *outline=[CCNode node];
    outline.physicsBody=[CCPhysicsBody bodyWithPolylineFromRect:outRect cornerRadius:0.5f];
    outline.physicsBody.friction=1.0f;
    outline.physicsBody.elasticity=1.0f;
    outline.physicsBody.collisionType=@"outline";
    outline.physicsBody.collisionMask=@[@"ball"];
    [physics addChild:outline];
    
    CCSprite *ball=[CCSprite spriteWithImageNamed:@"ball.png"];
    float radius=ball.texture.contentSize.width/2;
    ball.position=ccp(200, 100);
    ball.physicsBody=[CCPhysicsBody bodyWithCircleOfRadius:radius andCenter:ccp(radius, radius)];
    ball.physicsBody.friction=1.0f;
    ball.physicsBody.elasticity=1.0f;
    ball.physicsBody.collisionType=@"ball";
    ball.physicsBody.collisionMask=@[@"outline"];
    [physics addChild:ball];
    
    float scale=1.5f;
    CCParticleSystem *flameParticle=[CCParticleSystem particleWithFile:@"flame.plist"];
    flameParticle.positionType=CCPositionTypeNormalized;
    flameParticle.position=ccp(0.5, 0.5);
    flameParticle.startSize*=scale;
    flameParticle.startSizeVar*=scale;
    flameParticle.endSize*=scale;
    flameParticle.endSizeVar*=scale;
    flameParticle.gravity=ccpMult(flameParticle.gravity, scale);
    flameParticle.posVar=ccpMult(flameParticle.posVar, scale);
    [ball addChild:flameParticle z:-1];
    
	return self;
}

@end
