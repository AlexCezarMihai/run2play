//
//  FirstViewController.h
//  run2play
//
//  Created by Alexandru Cezar MIhai on 2015-11-07.
//  Copyright (c) 2015 Alexandru Cezar MIhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

@interface FirstViewController : UIViewController{

}

@property (nonatomic) HKHealthStore *healthStore;

@property(nonatomic) IBOutlet UIButton * refresh;
@property(nonatomic) IBOutlet UILabel * counter;
@property(nonatomic) IBOutlet UILabel * total;
@property(nonatomic) IBOutlet UIButton * start;
@property(nonatomic) IBOutlet UIButton * collect;
@end

