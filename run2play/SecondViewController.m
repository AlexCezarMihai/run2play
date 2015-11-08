//
//  SecondViewController.m
//  run2play
//
//  Created by Alexandru Cezar MIhai on 2015-11-07.
//  Copyright (c) 2015 Alexandru Cezar MIhai. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize list;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"imageCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImageView * image = [[cell.contentView subviews] objectAtIndex:0];
    [image setImage:[UIImage imageNamed: list[indexPath.row][@"image"]] ];
    UILabel * label = [[cell.contentView subviews] objectAtIndex:1];
    [label setText:list[indexPath.row][@"text"]];
    UILabel * cost = [[cell.contentView subviews] objectAtIndex:2];
    [cost setText:[NSString stringWithFormat:@"Coût: %@ pas",list[indexPath.row][@"price"]]];
    
    if([indexPath row] == 0){
        UIButton * buy = [[cell.contentView subviews] objectAtIndex:3];
        [buy addTarget:self action:@selector(joke) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        UIButton * buy = [[cell.contentView subviews] objectAtIndex:3];
        [buy addTarget:self action:@selector(sorry) forControlEvents:UIControlEventTouchUpInside];
    }

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)joke{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Blague" message:@"Pourquoi les gorilles ont un gros nez ?\n\nParcequ'ils ont des gros doigts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}
-(void)sorry{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Desole" message:@"On travaille a faire cette functionalite disponible le plus vite possible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

-(void)initList{
    list = @[
             @{@"image":@"Joke-1.png",@"text":@"Blague",@"price":@1000},
             @{@"image":@"001.png",@"text":@"Cookie bombe",@"price":@7000},
             @{@"image":@"002.png",@"text":@"Cool rayures",@"price":@8000},
             @{@"image":@"003.png",@"text":@"Lolipop sucette",@"price":@9000},
             @{@"image":@"004.png",@"text":@"Oiseau jaune",@"price":@10000},
             @{@"image":@"005.png",@"text":@"Oeuf en promotion",@"price":@20000},
             @{@"image":@"006.png",@"text":@"Cochon vert",@"price":@10500},
             @{@"image":@"007.png",@"text":@"Potion magique",@"price":@11000},
             @{@"image":@"008.png",@"text":@"500 Gem",@"price":@7000},
            ];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initList];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
