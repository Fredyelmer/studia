//
//  Answer.h
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic) NSInteger time; // Tempo de envio da resposta
@property (nonatomic, strong) NSString *author;
@property (nonatomic) int upVotes;
@property (nonatomic) int downVotes;
@property (nonatomic) NSInteger spamCounter; // Conta quantos avisos de spam a resposta levou, inicialmente não será utilizados, apenas uma preparação de terreno
@property (strong, nonatomic) UIImage* drawImage;
@property (nonatomic) int upDownDifference;

- (id)initWithAuthor:(NSString *)author text: (NSString*)text image: (UIImage *)image;
- (void) setVotesDifference;
@end
