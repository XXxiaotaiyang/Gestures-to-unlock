//
//  LockView.m
//  手势解锁
//
//  Created by 闲人 on 15/12/14.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "LockView.h"
@interface LockView ()
@property(nonatomic, strong) NSMutableArray *selectedBtns;
@end

@implementation LockView

- (NSMutableArray *)selectedBtns {
    if (!_selectedBtns) {
        _selectedBtns  = [NSMutableArray array];
    }
    return _selectedBtns;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn];
    }
    return self;
}

- (void)setupBtn {
    for (NSInteger i= 0; i < 9; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"]
             forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"]
             forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    CGFloat padding = (self.frame.size.width - 3 * btnW) / 4;
    NSUInteger count = self.subviews.count;
    for (NSUInteger i; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        NSUInteger col = i % 3;
        NSUInteger row = i / 3;
        CGFloat btnX = padding + (btnW + padding) * col;
        CGFloat btnY = padding + (btnH + padding) * row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchP = [touch locationInView:touch.view];
    
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, touchP)) {
            if (btn.selected == NO) {
                [self.selectedBtns addObject:btn];
            }
            btn.selected = YES;
        }
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"选中按钮的个数 %ld",self.selectedBtns.count);
    NSMutableString *password = [NSMutableString string];
    for (UIButton *seletedBtn in self.selectedBtns) {
        [password appendFormat:@"%ld",seletedBtn.tag];
    }
    NSLog(@"password:%@",password);
//    这个没设置成功。
//    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    [self.selectedBtns enumerateObjectsWithOptions:0 usingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];

    [self.selectedBtns removeAllObjects];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    
    NSInteger selectedCount = self.selectedBtns.count;
    if (selectedCount == 0) return;

    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < selectedCount;i++ ) {
        CGPoint btnCenter = [self.selectedBtns[i] center];
        if (i == 0) {
            [path moveToPoint:btnCenter];
        }else{
            [path addLineToPoint:btnCenter];
        }
    }
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [[UIColor greenColor] set];
    [path stroke];
    
}


@end
