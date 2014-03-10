//
//  DCPosto.m
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 29/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCPosto.h"

@implementation DCPosto

-(bool)isOk{
    if([self.nome isEqualToString:@""]||self.nome==nil){
        return false;
    }
    if(self.lat==0||self.log==0){
        return false;
    }
    if([self.telefone isEqualToString:@""]||self.telefone==nil){
        return false;
    }
    return true;
}


@end
