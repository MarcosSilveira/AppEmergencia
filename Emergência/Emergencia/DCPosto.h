//
//  DCPosto.h
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 29/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPosto : NSObject

@property (nonatomic) float lat;
@property (nonatomic) float log;
@property (nonatomic) NSString *nome;
@property (nonatomic) NSString *endereco;
@property (nonatomic) NSString *telefone;
@property (nonatomic) NSString *bairro;
@property (nonatomic) NSString *especi;
@property (nonatomic) NSString *site;
@property (nonatomic) NSNumber *cod;
@property (nonatomic) BOOL validar;

-(bool)isOk;

@end
