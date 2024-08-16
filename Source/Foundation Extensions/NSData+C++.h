//----------------------------------------------------------------------------------------------------------------------
//	NSData+C++.h			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#pragma once

#include "CData.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSData extension

@interface NSData (Cpp)

// MARK: Class methods

+ (instancetype) dataWithReferenceTo:(const CData&) data;
+ (instancetype) dataWithCopyOf:(const CData&) data;

@end

NS_ASSUME_NONNULL_END
