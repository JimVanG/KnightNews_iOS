//
//  JJVSettingsTableViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 10/17/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVSettingsTableViewController.h"
#import "JJVWebViewController.h"

@interface JJVSettingsTableViewController ()

@property (nonatomic, strong) NSMutableArray *settingsDataArray;


@end

@implementation JJVSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Info";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsDataArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UISettingsTableViewController"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *aboutArray = [[NSArray alloc] initWithObjects:@"About", nil];
    NSDictionary *aboutItemsArrayDict = [NSDictionary dictionaryWithObject: aboutArray
                                                                    forKey: @"data"];
    [self.settingsDataArray addObject: aboutItemsArrayDict];
    
    //contributions section
    NSArray *contributionsArray = [[NSArray alloc] initWithObjects:@"App Repository (GitHub)", nil];
    NSDictionary *contributionsArrayDict = [NSDictionary dictionaryWithObject: contributionsArray
                                                                       forKey: @"data"];
    [self.settingsDataArray addObject: contributionsArrayDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.settingsDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSDictionary *dict = [self.settingsDataArray objectAtIndex: section];
    NSArray *array = [dict objectForKey: @"data"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0){
        return @"About KnightNews";
    }
    if(section == 1){
        return @"Contribute to KnightNews for iOS";
    }else{
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UISettingsTableViewController" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"UISettingsTableViewController"];
    }
    
    NSDictionary *dictionary = [self.settingsDataArray objectAtIndex: indexPath.section];
    NSArray *array = [dictionary objectForKey: @"data"];
    NSString *cellValue = [array objectAtIndex: indexPath.row];
    cell.textLabel.text = cellValue;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selectedCell = nil;
    NSDictionary *dictionary = [self.settingsDataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    selectedCell = [array objectAtIndex:indexPath.row];
    
    switch (indexPath.section) {
        case 0:{
            //Open up About VC
            JJVWebViewController *webVC = [[JJVWebViewController alloc] init];
            webVC.urlRequest = [NSURLRequest requestWithURL:
                                [NSURL URLWithString:
                                 @"http://knightnews.com/about/"]];
            [self.navigationController pushViewController: webVC animated: YES];
            break;
        }
            
        case 1:{
            //Open up repo link in our webviewVC
//            JJVWebViewController *webVC = [[JJVWebViewController alloc] init];
//            webVC.urlRequest = [NSURLRequest requestWithURL:
//                                [NSURL URLWithString:
//                                 @"https://github.com/JimVanG/KnightNews_iOS"]];
//            [self.navigationController pushViewController: webVC animated: YES];
            
            //Open app in Safari
            [[UIApplication sharedApplication] openURL:
                                  [NSURL URLWithString:
                                   @"https://github.com/JimVanG/KnightNews_iOS"]];
            break;
        }
        default:{
            NSLog(@"%@", selectedCell);
            break;
        }
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
