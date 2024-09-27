#import "FlowerModel.h"

@implementation FlowerModel

- (instancetype)initWithName:(NSString *)name
                        type:(NSString *)type
                       image:(UIImage *)image {
    self = [super init];
    if (self) {
        _name = name;
        _type = type;
        _image = image;
    }
    return self;
}

@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlowerModel : NSObject

@property (nonatomic, strong) NSString *name;    // stores name of the flower
@property (nonatomic, strong) NSString *type;    // stores the type/category of the flower
@property (nonatomic, strong) UIImage *image;    // stores the image of the flower

- (instancetype)initWithName:(NSString *)name
                        type:(NSString *)type
                       image:(UIImage *)image;

@end


git rm --cached ProjectFolder.xcodeproj/project.xcworkspace/xcuserdata/cwallace5150.xcuserdatad/UserInterfaceState.xcuserstate