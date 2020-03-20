//
//  DQBaseMarco.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#ifndef DQBaseMarco_h
#define DQBaseMarco_h

#define DQCurrentScreenHeight [UIScreen mainScreen].bounds.size.height
#define DQCurrentScreenWidth  [UIScreen mainScreen].bounds.size.width
#define DQRVColorFromRGBAlpha(_rgbValue, _alpha)              [UIColor colorWithRed:((float)((_rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((_rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(_rgbValue & 0xFF))/255.0 alpha:_alpha]

#define DQWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* DQBaseMarco_h */
