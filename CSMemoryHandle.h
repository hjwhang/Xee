#import "CSHandle.h"

@interface CSMemoryHandle:CSHandle
{
	NSData *data;
	off_t pos;
}

+(CSMemoryHandle *)memoryHandleForReadingData:(NSData *)data;
+(CSMemoryHandle *)memoryHandleForReadingBuffer:(void *)buf length:(unsigned)len;
+(CSMemoryHandle *)memoryHandleForReadingMappedFile:(NSString *)filename;
+(CSMemoryHandle *)memoryHandleForWriting;

-(id)initWithData:(NSData *)dataobj;
-(void)dealloc;

-(off_t)fileSize;
-(off_t)offsetInFile;
-(BOOL)atEndOfFile;

-(void)seekToFileOffset:(off_t)offs;
-(void)seekToEndOfFile;
//-(void)pushBackByte:(int)byte;
-(int)readAtMost:(int)num toBuffer:(void *)buffer;
-(void)writeBytes:(int)num fromBuffer:(const void *)buffer;
-(id)copyWithZone:(NSZone *)zone;

-(NSData *)readDataOfLength:(int)length;
-(NSData *)readDataOfLengthAtMost:(int)length;
-(NSData *)copyDataOfLength:(int)length;
-(NSData *)copyDataOfLengthAtMost:(int)length;

-(NSData *)data;
-(NSMutableData *)mutableData;

@end
