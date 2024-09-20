#import "ImageModel.h"

@implementation ImageModel

//singleton class "sharedInstance": use block of code only once
+(ImageModel*) sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    
    
    return _sharedInstance;
}

//overwrite the getter for the image names array
@synthesize imageNames = _imageNames;
-(NSArray*) imageNames{
    if(!_imageNames){
        _imageNames = @[@"AfricanDaisy", @"AfricanLilly", @"AfricanMarigold", @"AfricanViolet", @"Alpenrose", @"Amaryllls", @"AmericanLotus", @"AmericanWisteria", @"AngelsFishingRod"];
    }
    return _imageNames;
}

//implement "getImageWithName" method
-(UIImage*)getImageWithName:(NSString*)name{
    UIImage* image = nil;
    image = [UIImage imageNamed:name];
    return image;
}


@end
