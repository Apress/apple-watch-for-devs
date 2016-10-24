//
//  PhotoshootManager.m
//  Chapter3
//

#import "PhotoshootManager.h"
#import "Photoshoot.h"

@implementation PhotoshootManager

+ (NSArray *)photoshoots
{
    // In a real application we would utilize Core Data or another data storage approach.
    // In that case we may write out the shared data to an app group container directory
    // so that both the WatchKit extension and our main app can access the data directly.
    NSString *sampleDataPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SampleData.plist"];
    NSDictionary *sampleData = [NSDictionary dictionaryWithContentsOfFile:sampleDataPath];
    
    NSArray *shootDictionaries = sampleData[@"photoshoots"];
    
    NSMutableArray *photoShoots = [NSMutableArray array];
    
    [shootDictionaries enumerateObjectsUsingBlock:^(NSDictionary *shootDictionary, NSUInteger idx, BOOL *stop) {
        Photoshoot *shoot = [[Photoshoot alloc] initWithDictionary:shootDictionary];
        
        [photoShoots addObject:shoot];
    }];
    
    return photoShoots;
}

@end
