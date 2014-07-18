//
//  AppDelegate.m
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "Languages.h"
#import "Archiver.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *readFileArray = [Archiver readFile:@"person_list"];
    if (!readFileArray) {
        [Archiver createFile:[self getPersonArray] aFileName:@"person_list"];
        // Read the file from persistance.
        readFileArray = [Archiver readFile:@"person_list"];
    }
    
    for (Person *person in readFileArray) {
        NSMutableString *mtString = [NSMutableString new];
        [mtString appendFormat:@"%@ %@ of age %@ knows ", person.firstName, person.lastName, person.age];
        for (Languages *lang in person.languages) {
            [mtString appendFormat:@"%@, ", lang.languageName];
        }
        
        NSLog(@"%@", mtString);
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods

- (NSArray*)getPersonArray {
    NSMutableArray *personArray = [NSMutableArray new];
    {
        Person *person = [Person new];
        [person setFirstName:@"X"];
        [person setLastName:@"Y"];
        [person setAge:@"24"];
        
        Languages *lang_1 = [Languages new];
        [lang_1 setLanguageName:@"Objective C"];
        
        Languages *lang_2 = [Languages new];
        [lang_2 setLanguageName:@"C"];
        
        [person setLanguages:@[lang_1, lang_2]];
        
        [personArray addObject:person];
    }
    
    {
        Person *person = [Person new];
        [person setFirstName:@"A"];
        [person setLastName:@"B"];
        [person setAge:@"29"];
        
        Languages *lang_1 = [Languages new];
        [lang_1 setLanguageName:@"Java"];
        
        [person setLanguages:@[lang_1]];
        
        [personArray addObject:person];
    }
    return personArray;
}

@end
