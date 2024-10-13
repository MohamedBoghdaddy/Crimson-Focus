#import "ToDoItem.h"

@implementation ToDoItem

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _taskName = name;
        _isCompleted = NO;
        _pomodoroDuration = 25 * 60; // Default to 25 minutes
    }
    return self;
}

@end
