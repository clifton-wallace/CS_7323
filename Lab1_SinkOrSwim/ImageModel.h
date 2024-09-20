//Sink or Swim app
//Team members: Arman, Clifton, Jeevan


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject

//define the "sharedInstance" class
+(ImageModel*) sharedInstance;

//method to return image based on the name
-(UIImage*)getImageWithName:(NSString*)name;

//array of images
@property (strong, nonatomic) NSArray* imageNames;

@end

NS_ASSUME_NONNULL_END
