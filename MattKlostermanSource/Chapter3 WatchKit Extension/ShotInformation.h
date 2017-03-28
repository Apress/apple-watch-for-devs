//
//  ShotInformation.h
//  Chapter3

#import <Foundation/Foundation.h>

@interface ShotInformation : NSObject

@property (nonatomic,strong) NSString *shotDescription;
@property (nonatomic,assign,getter=hasBeenCompleted) BOOL completed;

- (instancetype)initWithDictionary:(NSDictionary *)shotData NS_DESIGNATED_INITIALIZER;

@end
