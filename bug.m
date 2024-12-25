In Objective-C, a rare but perplexing issue can arise when dealing with KVO (Key-Value Observing) and memory management.  If an observer is not removed properly before the observed object is deallocated, a crash can occur. This is particularly insidious because it might not manifest immediately, especially if the observed object has a longer lifespan.  The crash typically happens later, making it difficult to trace back to the original KVO registration.  Example:

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
// ... later, if observer is not removed before obj is deallocated ...
[obj release]; // or equivalent ARC management failure
// ... crash!
```