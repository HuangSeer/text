//
//  SelectAlert.m
//  SelectAlertDemo
//
//  Created by apple on 2016/11/24.
//  Copyright  All rights reserved.
//

#import "Selestview.h"
#import "dakaModel.h"
#import "PchHeader.h"
#import "SHrModel.h"
#import "SjLxModel.h"
#import "SjDjModel.h"
#import "SjLyModel.h"

@interface SelectAleCell : UITableViewCell
@property (nonatomic, strong) dakaModel *dakaM;//string数组
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SelectAleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end


@interface SelectAlert ()
@property (nonatomic, strong) NSMutableArray *muarray;
@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表

@end

@implementation SelectAlert
{
    
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

+ (SelectAlert *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
               showCloseButton:(BOOL)showCloseButton {
    SelectAlert *alert = [[SelectAlert alloc] initWithTitle:title titles:titles selectIndex:selectIndex selectValue:selectValue showCloseButton:showCloseButton];
    return alert;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue showCloseButton:(BOOL)showCloseButton {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 250;
        buttonHeight = 40;
        
        self.titleLabel.text = title;
        NSLog(@"title=2==2=22=2==2=2====%@",title);
        _titles = titles;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _showCloseButton = showCloseButton;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        [self initUI];
        
        [self show];
    }
    return self;
}

- (void)show {
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    
    self.alertView.frame = CGRectMake(20, ([UIScreen mainScreen].bounds.size.height-alertHeight)/14.0, [UIScreen mainScreen].bounds.size.width-40, 320);
    self.titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, buttonHeight);
    float reduceHeight = buttonHeight;
    if (_showCloseButton) {
        self.closeButton.frame = CGRectMake(0, _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width, buttonHeight);
        reduceHeight = buttonHeight*2;
    }
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight);
}

#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float real = (alertHeight - buttonHeight)/(float)_titles.count;
    if (_showCloseButton) {
        real = (alertHeight - buttonHeight*2)/(float)_titles.count;
    }
    return real<=40?40:real;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SelectAleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (!cell) {
        cell = [[SelectAleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    if ([self.titleLabel.text containsString:@"审核人"]) {
        _muarray=[SHrModel mj_objectArrayWithKeyValuesArray:_titles];
        SHrModel * SHrM=_muarray[indexPath.row];
        cell.textLabel.text= SHrM.gridStaffName;
    }else  if ([self.titleLabel.text containsString:@"审核类型"]){
        _muarray=[dakaModel mj_objectArrayWithKeyValuesArray:_titles];
        dakaModel *dakaM=_muarray[indexPath.row];
        cell.textLabel.text=dakaM.leaves_type_name;
    
    }else  if ([self.titleLabel.text containsString:@"事件类型"]){
        _muarray=[SjLxModel mj_objectArrayWithKeyValuesArray:_titles];
        SjLxModel *SjLxM=_muarray[indexPath.row];
        cell.textLabel.text=SjLxM.eventTypeName;
        
    }
    else  if ([self.titleLabel.text containsString:@"事件等级"]){
        _muarray=[SjDjModel mj_objectArrayWithKeyValuesArray:_titles];
        SjDjModel *SjDjM=_muarray[indexPath.row];
        cell.textLabel.text=SjDjM.eventLevelName;
        
    }
    else  if ([self.titleLabel.text containsString:@"事件来源"]){
        _muarray=[SjLyModel mj_objectArrayWithKeyValuesArray:_titles];
        SjLyModel *SjLyM=_muarray[indexPath.row];
        cell.textLabel.text=SjLyM.sourceTypeName;
        
    }
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleLabel.text containsString:@"审核人"]) {
        SHrModel * SHrM=_muarray[indexPath.row];
        if (self.selectIndex) {
            self.selectIndex([ SHrM.gridStaffId intValue]);
            
        }
        if (self.selectValue) {
            
            
            self.selectValue( SHrM.gridStaffName);
        }
    }else if ([self.titleLabel.text containsString:@"审核类型"]){
        dakaModel *dakaM=_muarray[indexPath.row];
        if (self.selectIndex) {
            self.selectIndex([dakaM.leaves_type_id intValue]);
            
        }
        if (self.selectValue) {
            
            
            self.selectValue(dakaM.leaves_type_name);
        }
        
    
    }else if ([self.titleLabel.text containsString:@"事件类型"]){
        SjLxModel *SjLxM=_muarray[indexPath.row];
        if (self.selectIndex) {
            self.selectIndex([SjLxM.eventTypeId intValue]);
            
        }
        if (self.selectValue) {
            
            
            self.selectValue(SjLxM.eventTypeName);
        }
        
        
    }else if ([self.titleLabel.text containsString:@"事件等级"]){
        SjDjModel *SjDjM=_muarray[indexPath.row];
        if (self.selectIndex) {
            self.selectIndex([SjDjM.eventLevelId intValue]);
            
        }
        if (self.selectValue) {
            
            
            self.selectValue(SjDjM.eventLevelName);
        }
        
        
    }
    else if ([self.titleLabel.text containsString:@"事件来源"]){
        SjLyModel *SjLyM=_muarray[indexPath.row];
        if (self.selectIndex) {
            self.selectIndex([SjLyM.sourceTypeId intValue]);
            
        }
        if (self.selectValue) {
            
            
            self.selectValue(SjLyM.sourceTypeName);
        }
        
        
    }

    [self closeAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt) && !_showCloseButton) {
        [self closeAction];
    }
}

- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    //    NSLog(@"SelectAlert被销毁了");
}

@end
