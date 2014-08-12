//
//  Trojan.h
//  TroyStory4
//
//  Created by Iván Mervich on 8/12/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trojan : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * prowess;

@end
