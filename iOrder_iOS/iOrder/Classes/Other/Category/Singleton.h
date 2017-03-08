/*
专门用来保存单例代码
 最后一行不要加 \ 
*/

// @interface
#define Singleton_interface(name) + (instancetype)shared##name;

// @implementation
#define Singleton_implementation(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
\
+ (instancetype)shared##name { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
} \
\
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance; \
}
