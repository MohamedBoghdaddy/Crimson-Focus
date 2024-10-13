#import "ViewController.h"
#import "ToDoItem.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tasks = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    // Set the background color for the view and tableView
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:1.0];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor colorWithRed:1.0 green:0.6 blue:0.6 alpha:1.0]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewCell class]]] setTextColor:[UIColor whiteColor]];

    // Add a UILabel to display the timer
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 40)];
    self.timerLabel.textColor = [UIColor redColor];
    self.timerLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.timerLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    ToDoItem *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.taskName;
    
    // Add a button to start the Pomodoro timer
    UIButton *pomodoroButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pomodoroButton.frame = CGRectMake(cell.contentView.frame.size.width - 100, 10, 80, 30);
    [pomodoroButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0]];
    [pomodoroButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pomodoroButton setTitle:@"Start Pomodoro" forState:UIControlStateNormal];
    [pomodoroButton addTarget:self action:@selector(startPomodoro:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:pomodoroButton];
    
    return cell;
}

- (void)startPomodoro:(NSInteger)index {
    ToDoItem *task = self.tasks[index];
    self.remainingTime = task.pomodoroDuration; // Set remaining time for the task
    
    if (!self.pomodoroTimer) {
        self.pomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(updateTimer)
                                                            userInfo:nil
                                                             repeats:YES];
    }
}

- (void)updateTimer {
    if (self.remainingTime > 0) {
        self.remainingTime--;
        
        NSInteger minutes = self.remainingTime / 60;
        NSInteger seconds = self.remainingTime % 60;
        
        self.timerLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    } else {
        [self.pomodoroTimer invalidate];
        self.pomodoroTimer = nil;
        self.timerLabel.text = @"Time's up!";
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Pomodoro Complete"
                                                                       message:@"Take a 5-minute break!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoItem *task = self.tasks[indexPath.row];
    task.isCompleted = !task.isCompleted;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = task.isCompleted ? [UIColor grayColor] : [UIColor blackColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
