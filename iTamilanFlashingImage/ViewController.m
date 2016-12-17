//
//  ViewController.m
//  iTamilanFlashingImage
//
//  Created by Tamilarasu on 17/12/16.
//  Copyright © 2016 Tamilarasu. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableDictionary *dictFormValues;
    __weak IBOutlet UIImageView *imgViewFlash;
    __weak IBOutlet UISlider *slider;
    __weak IBOutlet UILabel *lblFlashCount;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initializing the dictinory
    [self.view setBackgroundColor:[UIColor grayColor]];
    [imgViewFlash setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refereshAnimation];
}
#pragma mark - Animation
-(void)refereshAnimation
{
    [imgViewFlash setBackgroundColor:[UIColor blackColor]];
    double frame = ((int)slider.value);
    [self.view.layer removeAllAnimations];
    imgViewFlash.alpha = 1.0;
    double flashDuration = 1.0/(frame*1.0);
    double halfFlashDuration = flashDuration/2.0;
    NSLog(@"Flash count %f Flashduration %f HalfFlashDuration %f",frame,flashDuration,halfFlashDuration);
    [UIView animateKeyframesWithDuration:flashDuration delay:0.0 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:halfFlashDuration animations:^{
            imgViewFlash.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:halfFlashDuration relativeDuration:halfFlashDuration animations:^{
            imgViewFlash.alpha = 1.0;
        }];
    } completion:nil];
}
#pragma mark - Action
-(IBAction)actionSliderValueChange:(id)sender{
    [lblFlashCount setText:@((int)slider.value).stringValue];
    [self refereshAnimation];
}
-(IBAction)actionChangeImage{
    [self.view.layer removeAllAnimations];
    [self openGalleryWithMessageImageSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)openGalleryWithMessageImageSourceType:(UIImagePickerControllerSourceType)imgSourceType{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:imgSourceType];
    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.navigationBar.translucent = NO;
    imagePickerController.navigationBar.tintColor = [UIColor blueColor];
    imagePickerController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
    imagePickerController.delegate = self;
}
#pragma mark -Image Picker Delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [imgViewFlash setImage:pickedImage];
    [self refereshAnimation];
}

@end
