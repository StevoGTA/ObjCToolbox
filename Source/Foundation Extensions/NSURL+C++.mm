//----------------------------------------------------------------------------------------------------------------------
//	NSURL+C++.mm			©2021 Stevo Brock	All rights reserved.
//----------------------------------------------------------------------------------------------------------------------

#import "NSURL+C++.h"

//----------------------------------------------------------------------------------------------------------------------
// MARK: NSURL extension

@implementation NSURL (Cpp)

// MARK: Properties

//----------------------------------------------------------------------------------------------------------------------
- (CFilesystemPath) filesystemPath
{
	return CFilesystemPath(CString((__bridge OSStringType) self.path));
}

// MARK: Class methods

//----------------------------------------------------------------------------------------------------------------------
+ (CFolder) folderFor:(NSURL*) url
{
	return CFolder(url.filesystemPath);
}

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
			folders += CFolder(url.filesystemPath);
		else
			// File
			files += CFile(url.filesystemPath);
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
			folders += CFolder(url.filesystemPath);
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
			files += CFile(url.filesystemPath);
	}

	return files;
}

//----------------------------------------------------------------------------------------------------------------------
+ (NSURL*) urlFor:(const CFolder&) folder
{
	return [NSURL fileURLWithPath:(__bridge NSString*) folder.getFilesystemPath().getString().getOSString()];
}

@end
