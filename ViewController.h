#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSTimer *pomodoroTimer;
@property (nonatomic, assign) NSInteger remainingTime;
@property (nonatomic, strong) UILabel *timerLabel;

- (void)startPomodoro:(NSInteger)index;

@end
