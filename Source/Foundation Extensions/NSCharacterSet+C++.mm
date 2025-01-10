//----------------------------------------------------------------------------------------------------------------------
//	NSCharacterSet+C++.mm			©2024 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSCharacterSet+C++.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSCharacterSet extension

@implementation NSCharacterSet (Cpp)

// MARK: Class methods

//----------------------------------------------------------------------------------------------------------------------
+ (instancetype) characterSetFor:(CString::CharacterSet) stringCharacterSet
{
	// Check character set
	switch (stringCharacterSet) {
		case CString::kCharacterSetControl:
			// Control
			return [NSCharacterSet controlCharacterSet];

		case CString::kCharacterSetWhitespace:
			// Whitespace
			return [NSCharacterSet whitespaceCharacterSet];

		case CString::kCharacterSetWhitespaceAndNewline:
			// Whitespace and newline
			return [NSCharacterSet whitespaceAndNewlineCharacterSet];

		case CString::kCharacterSetDecimalDigit:
			// Decimal digit
			return [NSCharacterSet decimalDigitCharacterSet];

		case CString::kCharacterSetFloatingPoint:
			// Floating point
			return [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];

		case CString::kCharacterSetLetter:
			// Letter
			return [NSCharacterSet letterCharacterSet];

		case CString::kCharacterSetLowercaseLetter:
			// Lowercase letter
			return [NSCharacterSet lowercaseLetterCharacterSet];

		case CString::kCharacterSetUppercaseLetter:
			// Uppercase letter
			return [NSCharacterSet uppercaseLetterCharacterSet];

		case CString::kCharacterSetAlphaNumeric:
			// Alphanumeric
			return [NSCharacterSet alphanumericCharacterSet];

		case CString::kCharacterSetPunctuation:
			// Punctuation
			return [NSCharacterSet punctuationCharacterSet];
	}
}

@end
