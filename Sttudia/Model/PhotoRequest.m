//
//  PhotoRequest.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 30/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "PhotoRequest.h"

@interface PhotoRequest()
{
    NSMutableData *_responseData;
    
}

@property (nonatomic,weak) id<PhotoRequestDelegate> delegate;

@property (nonatomic,retain) NSURLRequest *urlRequest;

@property (nonatomic,retain) NSURLConnection *connection;

@end


@implementation PhotoRequest

- (id)initWithKey : (NSString*) key
{
    self = [super init];
    
    if (self){
        self.key = key;
    }
    return self;
}

- (NSURL*) urlForKey: (NSString*)key
{
    NSString *keyWithPlus = [key stringByReplacingOccurrencesOfString: @" " withString:@"+"];
    NSString *strUrl = [NSString stringWithFormat:@"http://pixabay.com/api/?username=ranagaishi&key=4ad343b8010dd6deca29&search_term=%@",keyWithPlus];
    NSURL* url = [NSURL URLWithString:strUrl];
    
    return url;
}

-(void) requestForPhotos:(id<PhotoRequestDelegate>) delegate
{
    
    [self setDelegate: delegate];
    
    self.urlRequest = [NSURLRequest requestWithURL:[self urlForKey:self.key]];
    
    // Create url connection and fire request
    self.connection = [NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
}


#pragma mark NSURLConnection Data Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError *error = nil;
    
    // aqui se temos algo em _responseData é uma String JSON, então neste caso usamos NSJSONSerialization para transformar em um dicionário
    NSDictionary *parsedData = _responseData ? [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error] : nil;
    
    if (error)
    {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        
        if ([self.delegate respondsToSelector:@selector(request:didFailWithError:)])
        {
            [self.delegate request:self didFailWithError:error];
        }
        
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(request:didFinishWithObject:)])
    {
        [self.delegate request:self didFinishWithObject:[self groupData:parsedData]];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    
    if ([self.delegate respondsToSelector:@selector(request:didFailWithError:)])
    {
        [self.delegate request:self didFailWithError:error];
    }
}


-(NSArray *) groupData: (NSDictionary *)parsedData
{
    
    NSArray *allValues = [parsedData objectForKey:@"hits"];
    
    return allValues;
    
}

@end
