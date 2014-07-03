//
//  Question.h
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Question : NSObject

@property (nonatomic, weak) NSString *text;
@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic) NSInteger time; // Tempo de envio da pergunta
@property (nonatomic) NSInteger upVotes;
@property (nonatomic) NSInteger downVotes;
@property (nonatomic) NSInteger spamCounter; // Conta quantos avisos de spam a resposta levou, inicialmente não será utilizados, apenas uma preparação de terreno

// Cria a pergunta com o texto especificado
- (id)initWithText:(NSString *)text;
- (void)sortAnswersBy:(NSInteger)type;

@end
