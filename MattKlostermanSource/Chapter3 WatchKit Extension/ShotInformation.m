//
//  ShotInformation.m
//  Chapter3

#import "ShotInformation.h"

@implementation ShotInformation

- (instancetype)initWithDictionary:(NSDictionary *)shotData
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.shotDescription = shotData[@"shotDescription"];
    self.completed = [shotData[@"completed"] boolValue];
    
    return self;
}

@end
