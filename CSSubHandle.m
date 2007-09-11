#import "CSSubHandle.h"

@implementation CSSubHandle

-(id)initWithHandle:(CSHandle *)handle from:(off_t)from length:(off_t)length
{
	if(self=[super initWithName:[handle name]])
	{
		parent=[handle copy];
		start=from;
		end=from+length;

		if(parent) return self;

		[self release];
	}
	return nil;
}

-(void)dealloc
{
	[parent release];
	[super dealloc];
}

-(off_t)fileSize
{
	off_t parentsize=[parent fileSize];
	if(parentsize>end) return end-start;
	else if(parentsize<start) return 0;
	else return parentsize-start;
}

-(off_t)offsetInFile
{
	return [parent offsetInFile]-start;
}

-(BOOL)atEndOfFile
{
	return [parent offsetInFile]==end||[parent atEndOfFile];
}

-(void)seekToFileOffset:(off_t)offs
{
	if(offs<0) [self _raiseNotSupported:_cmd];
	if(offs>end) [self _raiseEOF];
	[parent seekToFileOffset:offs+start];
}

-(void)seekToEndOfFile
{
	@try
	{
		[self seekToFileOffset:end];
	}
	@catch(NSException *e)
	{
		if([[e name] isEqual:@"CSEndOfFileException"]) [parent seekToEndOfFile];
		else @throw e;
	}
}

-(int)readAtMost:(int)num toBuffer:(void *)buffer
{
	off_t curr=[parent offsetInFile];
	if(curr+num>end) num=end-curr;
	return [parent readAtMost:num toBuffer:buffer];
}

@end
