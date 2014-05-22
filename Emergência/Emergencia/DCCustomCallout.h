//
//  DCCustomCallout.h
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 21/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "DCPosto.h"

@interface DCCustomCallout : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property (strong, nonatomic) DCPosto  *posto;

-(id)init;

-(id)initwithAnnotation:(id<MKAnnotation> )anot
                 andStr:(NSString *)idetifier;


@end
