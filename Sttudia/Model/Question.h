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

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic) float time; // Tempo de envio da pergunta
@property (nonatomic) int upVotes;
@property (nonatomic) int downVotes;
@property (nonatomic) int upDownDifference;
@property (nonatomic) NSInteger spamCounter; // Conta quantos avisos de spam a resposta levou, inicialmente não será utilizados, apenas uma preparação de terreno
@property (strong, nonatomic) UIImage* drawImage;

// Cria a pergunta com o texto especificado
- (id)initWithAuthor:(NSString *)author title: (NSString*)title text: (NSString*)text image: (UIImage*)image;
- (void) setVotesDifference;

@end
