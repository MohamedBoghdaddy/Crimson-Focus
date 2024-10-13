#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, assign) NSInteger pomodoroDuration; // Add pomodoro duration

- (instancetype)initWithName:(NSString *)name;

@end
