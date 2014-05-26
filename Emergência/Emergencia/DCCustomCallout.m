//
//  DCCustomCallout.m
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 21/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCCustomCallout.h"
#import <MapKit/MKAnnotation.h>

@implementation DCCustomCallout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.posto.telefone = [_posto.telefone stringByAppendingFormat:@"(%c%c) %c%c%c%c - %c%c%c%c",[_posto.telefone characterAtIndex:0], [_posto.telefone characterAtIndex:1], [_posto.telefone characterAtIndex:2], [_posto.telefone characterAtIndex:3],  [_posto.telefone characterAtIndex:4], [_posto.telefone characterAtIndex:5],  [_posto.telefone characterAtIndex:6],  [_posto.telefone characterAtIndex:7], [_posto.telefone characterAtIndex:8], [_posto.telefone characterAtIndex:9]];
        
    }
    return self;
}



@end
