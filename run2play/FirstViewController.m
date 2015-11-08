//
//  FirstViewController.m
//  run2play
//
//  Created by Alexandru Cezar MIhai on 2015-11-07.
//  Copyright (c) 2015 Alexandru Cezar MIhai. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize start;
@synthesize collect;
@synthesize counter;
@synthesize refresh;
@synthesize total;
int totalSaved = 0;
- (void)getData{
    if (NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable])
    {
        
        // Add your HealthKit code here
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        
        // Share body mass, height and body mass index etc....
        NSSet *shareObjectTypes = [NSSet set];
        
        // Read date of birth, biological sex and step count etc
        NSSet *readObjectTypes  = [NSSet setWithObjects:
                                   //                                   [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
                                   //                                   [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
                                   //                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
                                   [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                                   nil];
        
        HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        // Set your start and end date for your query of interest
        NSDate *startDate, *endDate;
        endDate = [NSDate date];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        startDate = [userDefaults valueForKey:@"lastDate"];
        // Use the sample type for step count
        //        HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        // Create a predicate to set start/end date bounds of the query
        NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
        // Request access
        [healthStore requestAuthorizationToShareTypes:shareObjectTypes
                                            readTypes:readObjectTypes
                                           completion:^(BOOL success, NSError *error) {
                                               
           if(success == YES)
           {
               //[healthStore ];
               //NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
               
               // NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
               NSSortDescriptor *timeSortDescription = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:YES];
               HKSampleQuery    *query = [[HKSampleQuery alloc] initWithSampleType:type
                                                                         predicate:predicate
                                                                             limit:HKObjectQueryNoLimit
                                                                   sortDescriptors:@[timeSortDescription]
                                                                    resultsHandler:^(HKSampleQuery *query, NSArray *result, NSError *error){
                    
                    NSLog(@"RESULT  : =>  %@",result);
                    if(!error && result)
                    { long totalSteps=0;
                        for(HKQuantitySample *quantitySample in result)
                        {
                            // your code here
                            
                            
                            HKQuantity  *quantity=quantitySample.quantity;
                            //HKQuantity *quantity = quantitySample.quantity;
                            NSString *string=[NSString stringWithFormat:@"%@",quantity];
                            NSString *newString1 = [string stringByReplacingOccurrencesOfString:@" count" withString:@""];
                            
                            NSInteger count=[newString1 integerValue];
                            totalSteps=totalSteps+count;
                            
                        }
                        //using total steps
                        [counter setText:[NSString stringWithFormat:@"%ld Pas",totalSteps]];
                        totalSaved = totalSteps;
                    }
                }];
               [healthStore executeQuery:query];
           }
           else
           {
               // Determine if it was an error or if the
               // user just canceld the authorization request
               //Fit_AAPLprofileviewcontroller_m.html
           }
           
       }];
    }
}
-(void)refreshData{
    [self getData];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults valueForKey:@"totalSteps"]){
        [userDefaults setObject:[NSNumber numberWithInt:0] forKey:@"totalSteps"];
    }
    NSInteger totalSteps = [[userDefaults valueForKey:@"totalSteps"] integerValue];
    [total setText:[NSString stringWithFormat:@"Cagnotte: %ld",totalSteps]];
    
    
    
}

-(IBAction) refreshClicked{
    [self refreshData];
    
}

-(IBAction) startClicked{
    collect.hidden = NO;
    refresh.hidden = YES;
    counter.hidden = NO;
    start.hidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"startDate"];
    [userDefaults setObject:[NSDate date] forKey:@"lastDate"];
    [userDefaults setObject:[NSNumber numberWithInt:0] forKey:@"totalSteps"];
    
}

-(IBAction) collectClicked{
    [counter setText:[NSString stringWithFormat:@"0 Pas"]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"lastDate"];
    
    NSInteger totalSteps = [[userDefaults valueForKey:@"totalSteps"] integerValue];
    totalSteps += totalSaved;
    [userDefaults setObject:[NSNumber numberWithInteger:totalSteps] forKey:@"totalSteps"];
    [self refreshData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDate * startDate = [userDefaults valueForKey:@"startDate"];
//    NSDate * lastDate = [userDefaults valueForKey:@"lastDate"];
//    NSLog(@"%@",startDate);
//    NSLog(@"%@",lastDate);
//    if(!startDate){
//        collect.hidden = YES;
//        refresh.hidden = YES;
//        counter.hidden = YES;
//    }
//    else{
//        start.hidden = YES;
//        [self refreshData];
//    }
    

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate * startDate = [userDefaults valueForKey:@"startDate"];
    NSDate * lastDate = [userDefaults valueForKey:@"lastDate"];
    NSLog(@"%@",startDate);
    NSLog(@"%@",lastDate);
    if(!startDate){
        collect.hidden = YES;
        refresh.hidden = YES;
        counter.hidden = YES;
    }
    else{
        start.hidden = YES;
        [self refreshData];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
