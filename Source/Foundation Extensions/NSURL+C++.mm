//----------------------------------------------------------------------------------------------------------------------
//	NSURL+C++.mm			©2021 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSURL+C++.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSURL extension

@implementation NSURL (Cpp)

// MARK: Properties

//----------------------------------------------------------------------------------------------------------------------
- (CFile) file
{
	return CFile(CFilesystemPath(CString((__bridge OSStringType) self.path)));
}

//----------------------------------------------------------------------------------------------------------------------
- (CFolder) folder
{
	return CFolder(CFilesystemPath(CString((__bridge OSStringType) self.path)));
}

// MARK: Lifecycle methods

//----------------------------------------------------------------------------------------------------------------------
- (instancetype) initWithFolder:(const CFolder&) folder
{
	return [self initFileURLWithPath:(__bridge NSString*) folder.getFilesystemPath().getString().getOSString()];
}

// MARK: Class methods

//----------------------------------------------------------------------------------------------------------------------
+ (SFoldersFiles) foldersFilesFor:(NSArray<NSURL*>*) urls
{
	// Setup
	TNArray<CFolder>	folders;
	TNArray<CFile>		files;

	// Iterate NSURLs
	for (NSURL* url in urls) {
		// Check if directory
		if (url.hasDirectoryPath)
			// Folder
			folders += url.folder;
		else
			// File
			files += url.file;
	}

	return SFoldersFiles(folders, files);
}

//----------------------------------------------------------------------------------------------------------------------
+ (TArray<CFolder>) foldersFor:(NSArray<NSURL*>*) urls
{
	// Setup
	TNArray<CFolder>	folders;

	// Iterate NSURLs
	for (NSURL* url in urls) {
		// Check if directory
		if (url.hasDirectoryPath)
			// Folder
			folders += url.folder;
	}

	return folders;
}

//----------------------------------------------------------------------------------------------------------------------
+ (TArray<CFile>) filesFor:(NSArray<NSURL*>*) urls
{
	// Setup
	TNArray<CFile>	files;

	// Iterate NSURLs
	for (NSURL* url in urls) {
		// Check if directory
		if (!url.hasDirectoryPath)
			// File
			files += url.file;
	}

	return files;
}

@end
