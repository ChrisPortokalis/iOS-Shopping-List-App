//
//  ChoicesEntity.h
//  Shopping_Portokalis_Christopher
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/6/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChoicesEntity : NSManagedObject

@property (nonatomic, retain) NSString * choiceCategory;
@property (nonatomic, retain) NSString * choiceName;
@property (nonatomic, retain) NSManagedObject *choiceToShop;

@end
