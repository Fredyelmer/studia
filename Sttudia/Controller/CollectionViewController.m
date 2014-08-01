//
//  CollectionViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
{
    NSString *_group;
    
    PhotoRequest *_photoRequest;
    NSArray *_photos;
    
    // Fila para executar blocos de processamento e aliviar a main thread
    NSOperationQueue *_queue;
    
    // Dicionário para otimização para reutilizar os Renderers de células já renderizadas
    NSMutableDictionary *_photoNamesToRenderers;
    
    // Dicionário para otimização para cancelamento de operações quando necessário
    NSMutableDictionary *_photoNamesToRenderingOperations;

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    _queue = [[NSOperationQueue alloc] init];
    _photoNamesToRenderers = [[NSMutableDictionary alloc] init];
    _photoNamesToRenderingOperations = [[NSMutableDictionary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(!_photos && !_photoRequest)
    {
        // quando a view for aparecer é criada uma request
        _photoRequest = [[PhotoRequest alloc] initWithKey:self.key];
        
        // E a request é disparada levando em conta o grupo recebido na inicialização
        [_photoRequest requestForRecipes:self];
        
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegateMethods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PhotoRepository *repository = [PhotoRepository sharedRepository];
    
    return [[repository lista]count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    PhotoRepository *repository = [PhotoRepository sharedRepository];
    Photo* photo = [[repository lista]objectAtIndex:indexPath.row];
    
    NSString* strURL = [photo previewURL];
    NSURL* url = [NSURL URLWithString:strURL];
    cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData* imageData = [NSData dataWithContentsOfURL:url];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [cell.imageView setImage:[UIImage imageWithData:imageData]];
        }];
    }];
    
    [_queue addOperation:operation];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 40);
    }
    return CGSizeMake(0, 40);
}

#pragma mark - PhotoRequestMethods
-(void) request: (PhotoRequest*) request didFinishWithObject:(id) object
{
    // Cria a operação para colocarmos na fila
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    // esta referência é fraca com o propósito de ela ser usada dentro do próprio bloco
    // o objetivo é checar se a operação foi cancelada logo após ela entrar em execução
    
    __weak NSBlockOperation *weakOperation = operation;
    
    [operation addExecutionBlock:^{
        
        PhotoRepository *repository = [PhotoRepository sharedRepository];
        
        for(NSDictionary *dictionary in object)
        {
            // Este for pode ser longo então aqui verificamos se esta operação foi
            // cancelada enquanto ela está executando
            if([weakOperation isCancelled])
            {
                // caso tenha sido cancelada apenas retorna e termina
                return ;
            }
            if (![dictionary isKindOfClass:[NSDictionary class]])
            {
                continue;
            }
            
            [repository addPhoto:[[Photo alloc] initWithDictionary:dictionary]];
            
            
        }
        
        
        // Atualizações de User Interface (UI) precisam acontecer na Main Queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _photos = [repository.arrayPhotos copy];
            
        }];
        
    }];
    
    // Este bloco irá executar fora da Main Queue
    [_queue addOperation:operation];
    
}

-(void) request: (PhotoRequest*) request didFailWithError:(NSError*) error
{
    NSLog(@"error with stocks request: %@",error);
    
    _photoRequest = nil;
}

@end
