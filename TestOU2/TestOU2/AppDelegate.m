//
//  AppDelegate.m
//  TestOU2
//
//  Created by AYLiOS on 2018/12/3.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    for (int i = 100; i < 1000; i ++) {
//        NSString *path = [NSString stringWithFormat:@"/Users/aylios/Desktop/cond-icon-heweather/%d.png",i];
//        NSFileManager * file = [NSFileManager defaultManager];
//        NSData *readData =[file contentsAtPath:path];
//
//        if(readData != nil){
//        UIImage *image = [UIImage imageWithData: readData];
//
//             UIImage *finishImage0 = [self grayscale:image type:4];
//
//
//
//
//        NSData *imageData = UIImagePNGRepresentation(finishImage0);
//
//
//        [imageData writeToFile: [NSString stringWithFormat:@"/Users/aylios/Desktop/未命名文件夹/%d.png",i] options:NSDataWritingAtomic error:nil];
//        }
//    }
    
    
    NSString *path = @"/Users/aylios/Desktop/cloud.png";
    NSFileManager * file = [NSFileManager defaultManager];
    NSData *readData =[file contentsAtPath:path];
    
    if(readData != nil){
        UIImage *image = [UIImage imageWithData: readData];
        
        UIImage *finishImage0 = [self grayscale:image type:4];
        
        
        
        
        NSData *imageData = UIImagePNGRepresentation(finishImage0);
        
        
        [imageData writeToFile: [NSString stringWithFormat:@"/Users/aylios/Desktop/未命名文件夹/%@.png",@"cloud"] options:NSDataWritingAtomic error:nil];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(UIImage*) grayscale:(UIImage*)anImage type:(char)type {
        CGImageRef  imageRef;
        imageRef = anImage.CGImage;
    
        size_t width  = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
    
        // ピクセルを構成するRGB各要素が何ビットで構成されている
        size_t                  bitsPerComponent;
        bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
        // ピクセル全体は何ビットで構成されているか
        size_t                  bitsPerPixel;
        bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
        // 画像の横1ライン分のデータが、何バイトで構成されているか
        size_t                  bytesPerRow;
        bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
        // 画像の色空間
        CGColorSpaceRef         colorSpace;
        colorSpace = CGImageGetColorSpace(imageRef);
    
        // 画像のBitmap情報
        CGBitmapInfo            bitmapInfo;
        bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
        // 画像がピクセル間の補完をしているか
        bool                    shouldInterpolate;
        shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
        // 表示装置によって補正をしているか
        CGColorRenderingIntent  intent;
        intent = CGImageGetRenderingIntent(imageRef);
    
        // 画像のデータプロバイダを取得する
        CGDataProviderRef   dataProvider;
        dataProvider = CGImageGetDataProvider(imageRef);
    
        // データプロバイダから画像のbitmap生データ取得
        CFDataRef   data;
        UInt8*      buffer;
        data = CGDataProviderCopyData(dataProvider);
        buffer = (UInt8*)CFDataGetBytePtr(data);
    
        // 1ピクセルずつ画像を処理
        NSUInteger  x, y;
        for (y = 0; y < height; y++) {
                for (x = 0; x < width; x++) {
                        UInt8*  tmp;
                        tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
                        // RGB値を取得
                        UInt8 red,green,blue;
                        red = *(tmp + 0);
                        green = *(tmp + 1);
                        blue = *(tmp + 2);
            
                        UInt8 brightness;
            
                        switch (type) {
                                    case 1://モノクロ
                                        // 輝度計算
                                        brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                                        *(tmp + 0) = brightness;
                                        *(tmp + 1) = brightness;
                                        *(tmp + 2) = brightness;
                                        break;
                    
                                    case 2://セピア
                                        *(tmp + 0) = red;
                                        *(tmp + 1) = green * 0.7;
                                        *(tmp + 2) = blue * 0.4;
                                        break;
                    
                                    case 3://色反転
                                        *(tmp + 0) = 255 - red;
                                        *(tmp + 1) = 255 - green;
                                        *(tmp + 2) = 255 - blue;
                                        break;
                    
                case 4://色反転
                                        *(tmp + 0) = 0;
                                        *(tmp + 1) = 0;
                                        *(tmp + 2) = 0;
                                        break;
                    
                                    default:
                                        *(tmp + 0) = red;
                                        *(tmp + 1) = green;
                                        *(tmp + 2) = blue;
                                        break;
                            }
            
                    }
            }
    
        // 効果を与えたデータ生成
        CFDataRef   effectedData;
        effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
        // 効果を与えたデータプロバイダを生成
        CGDataProviderRef   effectedDataProvider;
        effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
        // 画像を生成
        CGImageRef  effectedCgImage;
        UIImage*    effectedImage;
        effectedCgImage = CGImageCreate(
                                                                            width, height,
                                                                            bitsPerComponent, bitsPerPixel, bytesPerRow,
                                                                            colorSpace, bitmapInfo, effectedDataProvider,
                                                                            NULL, shouldInterpolate, intent);
        effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
        // データの解放
        CGImageRelease(effectedCgImage);
        CFRelease(effectedDataProvider);
        CFRelease(effectedData);
        CFRelease(data);
    
        return effectedImage;
}


@end
