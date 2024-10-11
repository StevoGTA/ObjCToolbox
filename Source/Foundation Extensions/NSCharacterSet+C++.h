//----------------------------------------------------------------------------------------------------------------------
//	NSCharacterSet+C++.h			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#pragma once

#include "CString.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSCharacterSet extension

@interface NSCharacterSet (Cpp)

// MARK: Class methods

+ (instancetype) characterSetFor:(CString::CharacterSet) stringCharacterSet;

@end

NS_ASSUME_NONNULL_END
