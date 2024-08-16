//----------------------------------------------------------------------------------------------------------------------
//	NSObject+C++.h			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#pragma once

#include "CString.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSObject extension

@interface NSObject (Cpp)

// MARK: Instance methods

- (void) storeString:(const CString&) string forKey:(NSString*) key;
- (OV<CString>) storedStringForKey:(NSString*) key;

@end

NS_ASSUME_NONNULL_END
