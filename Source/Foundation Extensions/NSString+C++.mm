//----------------------------------------------------------------------------------------------------------------------
//	NSString+C++.mm			©2021 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSString+C++.h"

#include "CDictionary.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: CString

// MARK: Lifecycle methods

//----------------------------------------------------------------------------------------------------------------------
CString::CString(const CString& localizationGroup, const CString& localizationKey, const CDictionary& localizationInfo)
//----------------------------------------------------------------------------------------------------------------------
{
	// Setup
	mStringRef =
			(CFStringRef) ::CFBridgingRetain([[NSBundle mainBundle]
					localizedStringForKey:(__bridge NSString*) localizationKey.getOSString()
					value:(__bridge NSString*) localizationKey.getOSString()
					table:(__bridge NSString*) localizationGroup.getOSString()]);

	// Check situation
	if (mStringRef != nil) {
		// Replace values
		CFMutableStringRef	stringRef = ::CFStringCreateMutableCopy(kCFAllocatorDefault, 0, mStringRef);
		::CFRelease(mStringRef);
		mStringRef = stringRef;

		for (TIteratorS<CDictionary::Item> iterator = localizationInfo.getIterator(); iterator.hasValue();
				iterator.advance()) {
			// Compose value
			CString	replacement;
			switch (iterator->mValue.getType()) {
				case SValue::kTypeBool:
					// Bool
					replacement = iterator->mValue.getBool() ? CString(OSSTR("true")) : CString(OSSTR("false"));
					break;

				case SValue::kTypeString:	replacement = iterator->mValue.getString();				break;
				case SValue::kTypeFloat32:	replacement = CString(iterator->mValue.getFloat32());	break;
				case SValue::kTypeFloat64:	replacement = CString(iterator->mValue.getFloat64());	break;
				case SValue::kTypeSInt8:	replacement = CString(iterator->mValue.getSInt8());		break;
				case SValue::kTypeSInt16:	replacement = CString(iterator->mValue.getSInt16());	break;
				case SValue::kTypeSInt32:	replacement = CString(iterator->mValue.getSInt32());	break;
				case SValue::kTypeSInt64:	replacement = CString(iterator->mValue.getSInt64());	break;
				case SValue::kTypeUInt8:	replacement = CString(iterator->mValue.getUInt8());		break;
				case SValue::kTypeUInt16:	replacement = CString(iterator->mValue.getUInt16());	break;
				case SValue::kTypeUInt32:	replacement = CString(iterator->mValue.getUInt32());	break;
				case SValue::kTypeUInt64:	replacement = CString(iterator->mValue.getUInt64());	break;

				case SValue::kTypeEmpty:
				case SValue::kTypeArrayOfDictionaries:
				case SValue::kTypeArrayOfStrings:
				case SValue::kTypeOpaque:
				case SValue::kTypeData:
				case SValue::kTypeDictionary:
					// Unhandled
					replacement = CString(OSSTR("->UNHANDLED<-"));
					break;
			}

			// Replace
			::CFStringFindAndReplace(stringRef, iterator->mKey.mStringRef, replacement.mStringRef,
					::CFRangeMake(0, ::CFStringGetLength(mStringRef)), 0);
		}
	} else
		// Not found
		mStringRef = (localizationGroup + mColon + localizationKey).getOSString();
}

//----------------------------------------------------------------------------------------------------------------------
CString::CString(const CString& localizationGroup, const CString& localizationKey)
//----------------------------------------------------------------------------------------------------------------------
{
	// Setup
	mStringRef =
			(CFStringRef) ::CFBridgingRetain([[NSBundle mainBundle]
					localizedStringForKey:(__bridge NSString*) localizationKey.getOSString()
					value:(__bridge NSString*) localizationKey.getOSString()
					table:(__bridge NSString*) localizationGroup.getOSString()]);
	if (mStringRef == nil)
		// Not found
		mStringRef = (localizationGroup + mColon + localizationKey).getOSString();
}

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
// MARK: - NSString extension

@implementation NSString (Cpp)

// MARK: Instance methods

//----------------------------------------------------------------------------------------------------------------------
- (NSString*) stringByReplacingOccurrencesOfCString:(const CString&) target withCString:(const CString&) replacement
{
	return [self stringByReplacingOccurrencesOfString:(__bridge NSString*) target.getOSString()
			withString:(__bridge NSString*) replacement.getOSString()];
}

@end
