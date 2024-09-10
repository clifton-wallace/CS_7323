//
//  ImageModel.m
//  UserInterfaceExample
//
//  Created by Eric Larson on 9/2/20.
//  Copyright © 2020 Eric Larson. All rights reserved.
//

#import "ImageModel.h"

@interface ImageModel ()

//1.1 - Moved From ImageModel.h To Make Private
@property (strong, nonatomic) NSArray* imageNames;

//1.2 - Add Mutable Dictionary Of Images
@property (nonatomic, strong) NSMutableDictionary *images;

@end

@implementation ImageModel

+(ImageModel*)sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
        // 1.2 Pre-Load Images
        [_sharedInstance preloadImages];
    } );
    return _sharedInstance;
}

-(NSArray*) imageNames{
    if(!_imageNames)
        _imageNames = @[@"Bill",@"Eric",@"Jeff",@"Alan",@"Grace",@"Steve"];
    
    return _imageNames; 
}

-(UIImage*)getImageWithName:(NSString*)name{
    UIImage* image = nil;
    
    image = [UIImage imageNamed:name];
    
    return image;
}

// 1.2 - Load Images Into Dictionary
-(void)preloadImages {
    self.images = [NSMutableDictionary dictionary];

    NSArray* imageNames = [self imageNames];

    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images setObject:image forKey:imageName];
        } else {
            //Not Sure The Best Way To Do This. Throwing Exception Because It Is Easy
            @throw [NSException exceptionWithName:@"InvalidValueException"
                    reason:[NSString stringWithFormat:@"Image with name %@ could not be loaded.", imageName]
                    userInfo:nil];
        }
    }
}

//1.3 - Add New Public Methods
-(UIImage*)getImageWithIndex:(NSInteger)index{
    if (index < 0 || index >= [self.imageNames count]) {
        //Not Sure The Best Way To Do This. Throwing Exception Because It Is Easy
        @throw [NSException exceptionWithName:@"InvalidValueException"
                reason:[NSString stringWithFormat:@"Image Index %ld Is Invalid/Out Of Bounds.", (long)index]
                userInfo:nil];
    }
    return self.images[self.imageNames[index]];
}

//1.3 - Add New Public Methods
-(NSInteger)numberOfImages{
    return [self.images count];
}

//1.3 - Add New Public Methods
-(NSString*)getImageNameForIndex:(NSInteger)index {
    if (index < 0 || index >= [self.imageNames count]) {
        //Not Sure The Best Way To Do This. Throwing Exception Because It Is Easy
        @throw [NSException exceptionWithName:@"InvalidValueException"
                reason:[NSString stringWithFormat:@"Image Index %ld Is Invalid/Out Of Bounds.", (long)index]
                userInfo:nil];
    }
    return self.imageNames[index];
}

@end
