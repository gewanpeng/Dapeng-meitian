//
//  PathHeader.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef Dapeng_meitian_PathHeader_h
#define Dapeng_meitian_PathHeader_h


#import "MBProgressHUD.h"
//内容
#define NEIRONG @"http://www.meitianapp.com/app/article/35ff0b0f-cdaf-3b88-b768-1711d91049b9";


#pragma mark --------- 每天

#define Day_PaiHangBang @"http://api.meitianapp.com/api/v1/articles?filter=isRankingList&start="

#define Day_Image @"http://api.meitianapp.com/api/v1/articles?filter=isHomepage&limit=%d&start="

#define Day_Wangqi @"http://api.meitianapp.com/api/v1/articles?filter=isHomepage&limit=%d&start="


#pragma mark --------- 发现
#pragma mark ----推荐

//头部
#define TJ_BIAOTOU @"http://api.meitianapp.com/api/v1/articles?filter=isFocus&limit=%d&start="

//标题
#define TJ_BIAOTI @"http://api.meitianapp.com/api/v1/categoryGroups?filter=isDiscovery&limit=%d&start="

//名字
#define TJ_NAME @"http://api.meitianapp.com/api/v1/articles?filter=byCategoryGroup&limit=10&param=%d&start="

//内容
#define NEIRONG @"http://www.meitianapp.com/app/article/%@"

//赞
#define ZAN @"http://api.meitianapp.com/api/v1/articleStats/08560461-c7fd-3b16-8da8-00ff06f14e6e"

#define TJ_FENLEI_Name @"http://api.meitianapp.com/api/v1/articles?filter=byCategoryGroup&limit=10&param=%d&start="





#pragma mark ----话题

#define HT_TOU @"http://api.meitianapp.com/api/v1/activities?filter=isOpen&start="

#define HT_NAME @"http://api.meitianapp.com/api/v1/posts?filter=byOpenActivities&limit=10&start="
#define HT_WEIZHI @"http://api.meitianapp.com/api/v1/activities?filter=isClosed&limit=3&start="

#define HT_CANYU @"http://api.meitianapp.com/api/v1/posts?filter=byActivity&limit=10&param=a737197f-aa5e-4ff0-8605-5395cbd4b8e4&start="

#define HT_TOU_Connter @"http://api.meitianapp.com/api/v1/posts?filter=byActivity&limit=10&param=%@&start="





#pragma mark --------- 专栏

#define ZL_TUPIAN @"http://api.meitianapp.com/api/v1/authors?filter=isFocus&limit=%d&start="

#define ZL_NEW @"http://api.meitianapp.com/api/v1/authors?filter=isDiscovery&limit=%d&start="

#define ZL_HOUDONG @"http://api.meitianapp.com/api/v1/author/contributor?start=%d"

#define ZL_HOUDONG_NEI @"http://api.meitianapp.com/api/v1/%@"


#define ZL_NEW_NEI @"http://api.meitianapp.com/api/v1/articles?filter=byAuthor&limit=10&order=asc&orderBy=priority&param=%@&start="

#endif
