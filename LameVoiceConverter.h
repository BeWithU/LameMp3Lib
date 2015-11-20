//
//  LameVoiceConverter.h
//  Lighting
//
//  Created by BanZhiqiang on 11/19/15.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LameVoiceConverter : NSObject

//将WAV文件转成同名MP3文件，存储在相同目录下
+(NSString *)wavToMp3:(NSString *)wavFileURL;

@end
