//
//  DCCustomAnnotationView.m
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 22/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCCustomAnnotationView.h"

@implementation DCCustomAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        /*UIImage *blipImage = [UIImage imageNamed:@"blip.png"];
        CGRect frame = [self frame];
        frame.size = [blipImage size];
        [self setFrame:frame];
        [self setCenterOffset:CGPointMake(0.0, -7.0)];
        [self setImage:blipImage];
         
         */
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
