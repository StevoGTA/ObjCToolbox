//----------------------------------------------------------------------------------------------------------------------
//	NSArray+Extensions.h			©2023 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#pragma once

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: - NSArray extension

@interface NSArray (Extensions)

// MARK: Instance methods

- (nullable NSObject*) firstObjectPassingTest:(BOOL (^)(NSObject* object, BOOL* stop)) block;

@end

NS_ASSUME_NONNULL_END
