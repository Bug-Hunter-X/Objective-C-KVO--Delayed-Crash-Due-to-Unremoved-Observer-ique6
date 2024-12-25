```objectivec
@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation MyObservedObject
- (void)dealloc {
    NSLog(@"MyObservedObject deallocated");
}
@end

@interface MyObserver : NSObject
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // ... observation logic ...
}
@end

// ... in some method ...
MyObservedObject *obj = [[MyObservedObject alloc] init];
MyObserver *observer = [[MyObserver alloc] init];
[obj addObserver:observer forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];
// ... later, REMOVE the observer before obj is deallocated ...
[obj removeObserver:observer forKeyPath:@"observedProperty"];
[obj release]; // or equivalent ARC management 
```
In ARC, the `release` is handled automatically, but the `removeObserver` call is still crucial.