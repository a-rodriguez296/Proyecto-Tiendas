//
//  AppDelegate.m
//  Tiendas
//
//  Created by Alejandro Rodriguez on 6/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "AppDelegate.h"
#import "ARFMainViewController.h"
#import "ARFConstants.h"

#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import <UAirship.h>
#import <UAConfig.h>
#import <UAPush.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Urban Airship
    [UAConfig defaultConfig];
    
    //Se da cuenta en runtime si esta en development o en producción
    [[UAConfig defaultConfig] setDetectProvisioningMode:YES];
    
    //Definir que tanto me sale en la consola
    [[UAConfig defaultConfig] setDevelopmentLogLevel:UALogLevelError];
    

    
    
    
    [UAirship takeOff];
    NSString *channelId = [UAirship push].channelID;
    NSLog(@"My Application Channel ID: %@", channelId);
    [UAirship push].userNotificationTypes = (UIUserNotificationTypeAlert |
                                             UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound);

    //Definir los tags. Con esto se puede hacer la segmentación
    [UAirship push].tags = @[@"Hola"];
    //Siempre después de agregar un tag hay que hacer este update.
    [[UAirship push] updateRegistration];
    
    
    //Alias
    //Si se hace el set acá no hay que hacer updateRegistration. En otra parte si.
    [[UAirship push] setAlias:@"Alejandro"];
    
    //Quiet tiem
    [[UAirship push] setQuietTimeStartHour:23 startMinute:00 endHour:6 endMinute:30];
    [[UAirship push] setQuietTimeEnabled:YES];
    [[UAirship push] updateRegistration];
    
    
    
    //Parse Registration
    [Parse setApplicationId:kParseApplicationId
                  clientKey:kParseClientKey];
    
    //Parse Notifications
//    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound);
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
//                                                                             categories:nil];
//    [application registerUserNotificationSettings:settings];
//    [application registerForRemoteNotifications];
    
    //Parte Google Maps
    [GMSServices provideAPIKey:kGoogleApiKey];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ARFMainViewController alloc] initWithNibName:nil bundle:nil];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    // Store the deviceToken in the current installation and save it to Parse.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    [currentInstallation saveInBackground];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [PFPush handlePush:userInfo];
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    if (currentInstallation.badge != 0) {
//        currentInstallation.badge--;
//        [currentInstallation saveEventually];
//    }
//}


@end
