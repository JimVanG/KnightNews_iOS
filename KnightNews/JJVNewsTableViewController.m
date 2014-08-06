//
//  JJVNewsTableViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 6/20/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVNewsTableViewController.h"
#import "JJVWebViewController.h"
#import "JJVStoryItem.h"
#import "JJVStoryItemStore.h"
#import "JJVReaderViewController.h"

NSString *const TITLE_CONSTANT = @"title_plain";
NSString *const URL_CONSTANT = @"url";
NSString *const POSTS_CONSTANT = @"posts";
NSString *const EXCERPT_CONSTANT = @"excerpt";
NSString *const CONTENT_CONSTANT = @"content";
NSString *const DATE_CONSTANT = @"date";
NSString *const IMAGE_CONSTANT = @"image";
NSString *const AUTHOR_CONSTANT = @"author";
NSString *const NAME_CONSTANT = @"name";
NSString *const CUSTOM_FIELD_CONSTANT = @"custom_fields";

@interface JJVNewsTableViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *items;

@end

@implementation JJVNewsTableViewController

//kinda like onCreate()?
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Recent News";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        
        //kick off request when we're created
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.webViewController = [[JJVWebViewController alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Networking methods

- (void)fetchFeed
{
    NSString *requestString = @"http://knightnews.com/api/get_recent_posts/";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", jsonObject);
        
        
        [self parseJSONObject: jsonObject];
        
        
        //NSLog(@"%@", self.items);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    [dataTask resume];
}

-(void)parseJSONObject:(NSDictionary *)jsonObject
{
    //get the list of posts (top most level of the JSON object)
    self.items = jsonObject[POSTS_CONSTANT];
    
    int count = 0;
    //get each posts attributes, each post is stored in a dictionary
    for (NSDictionary *post in self.items) {
        JJVStoryItem *storyItem = [[JJVStoryItem alloc] init];
        
        storyItem.position = count++;

        storyItem.url = post[URL_CONSTANT];
        storyItem.title = post[TITLE_CONSTANT];
        storyItem.contents = post[CONTENT_CONSTANT];
        storyItem.excerpt = post[EXCERPT_CONSTANT];
        storyItem.date = post[DATE_CONSTANT];
        
        //these fields are in their own seperate dictionaries
        NSDictionary *innerDictionary = post[AUTHOR_CONSTANT];
        storyItem.author = innerDictionary[NAME_CONSTANT];
        
        innerDictionary = post[CUSTOM_FIELD_CONSTANT];
        NSArray *customFieldsArray = innerDictionary[IMAGE_CONSTANT];
        //image url is inside of an array inside of a dictionary
        storyItem.imageUrl = customFieldsArray[0];
        
        //add to our store
        [[JJVStoryItemStore sharedStore] addItem: storyItem];
    }

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[JJVStoryItemStore sharedStore] numberOfStories];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    
    //configure the cells...
    JJVStoryItem *story = [[JJVStoryItemStore sharedStore] getItemAt: indexPath.row];
    cell.textLabel.text = story.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the corresponding story item
    JJVStoryItem *selectedStory = [[JJVStoryItemStore sharedStore] getItemAt:indexPath.row];
    
    //initialize a readerView
    JJVReaderViewController *readerView = [[JJVReaderViewController alloc] init];
    
    //pass the selected story along to the reader view
    readerView.item = selectedStory;
    
    //push the reader view controller onto the screen
    [self.navigationController pushViewController:readerView
                                         animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
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
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
