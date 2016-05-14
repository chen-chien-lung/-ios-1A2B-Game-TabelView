//
//  GamePlatform.m
//  Game
//
//  Created by Joe Chen on 2016/5/10.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import "GamePlatform.h"
#import "KeepTableView.h"

@interface GamePlatform ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *gameTableView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic) NSString* enterNumber;
@property (nonatomic) NSMutableArray* keepQuestion;
@property (nonatomic) NSMutableArray* KeepTableView;

@end

@implementation GamePlatform

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    KeepTableView * view = [[KeepTableView alloc]init];
//    view.question = @"123";
//    view.abAnswer = @"123";
    
    
    self.KeepTableView = [[NSMutableArray alloc]init];
    
    NSMutableArray * random = [self keepQuestion];
    random = [NSMutableArray arrayWithCapacity:4];
    
    for(int i=0;i<4;i++){
        
        int number = arc4random()%10;
        int check = 0;
        
        NSLog(@"random:%d",number);
        
        for(int j = 0 ; j<random.count ; j++){
            if(random[j] == [NSString stringWithFormat:@"%d",number]){
                check +=1;
                i -=1;
            }
        }
        
        if(check == 0){
            [random addObject:[NSString stringWithFormat:@"%d",number]];
        }
        NSLog(@"random number:%lu",(unsigned long)random.count);
        //        NSLog(@"%@",pick.arrayPick[i]);
    }
    
    self.keepQuestion = random;
    
//    self.KeepTableVIew = [NSMutableArray arrayWithArray:@[view]];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return  1;//印幾個section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    
    return self.KeepTableView.count; //每個section裡面印幾個row
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  { //indexPath裡面藏著兩個屬性 section and row
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    KeepTableView * view = self.KeepTableView[indexPath.row];
    
    
    //左邊的label
    cell.textLabel.text = view.question;
    
    
    //右邊的label
    cell.detailTextLabel.text = view.abAnswer;
    
    
    return cell;
}

//- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;{
//    
//}




- (IBAction)numberClick:(UIButton *)sender {
    

    
    if(_answerLabel.text.length < 4){
            _answerLabel.text = [_answerLabel.text stringByAppendingString:sender.currentTitle];
        }
//        _enterNumber = _answerLabel.text;
    
}

- (IBAction)clickToGuess:(UIButton *)sender {
    
    NSMutableArray * random = self.keepQuestion;
    NSString * guess = [_answerLabel text];
    KeepTableView * view = [[KeepTableView alloc]init];
    
    NSLog(@"%@",guess);
    int A = 0;
    int B = 0;
    
    
    _answerLabel.text = @"";
    
    for(int i=0;i<4;i++){
        NSRange  range = NSMakeRange(i,1); //range should be (start ,end-start)
        NSString * guessNumber = [guess substringWithRange:range];
        
        //        NSLog(@"this is %@",guessNumber);
        for(int j=0;j<4;j++){
            
            if(random[j] == guessNumber){
                if(j == i){
                    A += 1;
                }else{
                    B += 1;
                }
            }
        }
    }
    
   
    
    NSLog(@"%@,%@,%@,%@",random[0],random[1],random[2],random[3]);
    NSLog(@"A:%dB:%d,",A,B);
    
    
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    view.question = guess;
    NSString * answer = [NSString stringWithFormat:@"A:%d,B:%d",A,B];
//    NSLog(@"%@",answer);
    
    view.abAnswer = answer;
    [self.KeepTableView insertObject:view atIndex:0];
//    [self.gameTableView reloadData];

    [self.gameTableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
}






@end
