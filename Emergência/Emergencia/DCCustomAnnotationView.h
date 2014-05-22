//
//  DCCustomAnnotationView.h
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 22/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DCCustomAnnotationView : MKAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
