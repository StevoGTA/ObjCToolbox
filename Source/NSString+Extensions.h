//----------------------------------------------------------------------------------------------------------------------
//	NSString+Extensions.h			©2021 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#pragma once

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//----------------------------------------------------------------------------------------------------------------------
// MARK: Macros

#define NSLocalizedStringFromStringsTable(stringsTable, key) \
				[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:stringsTable]

//----------------------------------------------------------------------------------------------------------------------
// MARK: - NSString extension

@interface NSString (Extensions)

@end

NS_ASSUME_NONNULL_END
