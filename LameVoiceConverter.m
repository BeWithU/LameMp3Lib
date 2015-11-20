 //
//  LameVoiceConverter.m
//  Lighting
//
//  Created by BanZhiqiang on 11/19/15.
//

#import "LameVoiceConverter.h"
#import "lame.h"

@implementation LameVoiceConverter

+(NSString *)wavToMp3:(NSString *)wavFilePath {
    NSString *mp3FilePath = [wavFilePath stringByDeletingPathExtension];
    mp3FilePath = [mp3FilePath stringByAppendingPathExtension:@"mp3"];
    
    @try {
        unsigned long read, write;
        
        FILE *pcm = fopen([wavFilePath cStringUsingEncoding:1], "rb");//被转换的文件
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");//转换后文件的存放位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 44100);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, (int)read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:mp3FilePath]) {
            return nil;
        }
        return mp3FilePath;
    }
}

@end
