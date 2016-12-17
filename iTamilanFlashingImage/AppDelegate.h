//
//  AppDelegate.h
//  iTamilanFlashingImage
//
//  Created by Tamilarasu on 17/12/16.
//  Copyright © 2016 Tamilarasu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

