//
//  KKNewsViewController.m
//  KnightNews
//
//  Created by Kyle Kirkland on 9/29/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsViewController.h"
#import "KKNewsFeaturedTableViewCell.h"
#import "KKNewsAPI.h"
#import "JJVStoryItemStore.h"
#import "JJVStoryItem.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSDate+NSDate_TimeAgo.h"
#import "JJVReaderViewController.h"
#import "JJVPageRootViewController.h"

@interface KKNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *newsArticles;
@end


@implementation KKNewsViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"News";
        self.tabBarItem.image = [UIImage imageNamed:@"newspaper_25"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"newspaper_25"];
        self.tabBarItem.title = @"News";
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTableView];
    
    [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Setup Methods 
-(void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"KKNewsFeaturedTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeaturedNewsCell"];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // UIRefreshControl
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(getData)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    
    self.tableView.alpha = 1.0;
}

-(void)getData
{
    // Make sure we arent refreshing
    if (!self.refreshControl.isRefreshing)
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    // Fetch the data.
    [[KKNewsAPI sharedUtilities] downloadNewsFeedWithCompletionBlock:^(BOOL success, NSError *error) {
        self.newsArticles = [[JJVStoryItemStore sharedStore] allItems];
        
        // Get on the main queue .
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];
            [self.refreshControl endRefreshing];

           // self.tableView.contentSize = CGSizeMake(self.view.frame.size.width, 316 * self.newsArticles.count);
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            [self fadeInView:self.tableView];
        });
        
    }];
    
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.newsArticles)
        return self.newsArticles.count;
    else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KKNewsFeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeaturedNewsCell"];

    return [self setUpFeaturedTableViewCellForTableView:cell atIndexPath:indexPath];
}


-(KKNewsFeaturedTableViewCell *)setUpFeaturedTableViewCellForTableView:(KKNewsFeaturedTableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    
    JJVStoryItem *item = (JJVStoryItem*)[self.newsArticles objectAtIndex:indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.articleImageView.image = nil;
    cell.articleImageView.alpha = 0.0;
    cell.articleAuthorLabel.text = item.author;
    cell.articleTitle.text = item.title;
    cell.articleTimeLabel.text = [item.date timeAgo];
    
    UIFontDescriptor* Descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{
                                                                                        UIFontDescriptorFamilyAttribute : @"Georgia"
                                                                                        }];
    cell.articlePreviewTextView.text = item.excerptParsed;
    cell.articlePreviewTextView.font = [UIFont fontWithDescriptor:Descriptor size:12.0f];
    cell.articlePreviewTextView.textColor = [UIColor darkGrayColor];
    
    [[KKNewsAPI sharedUtilities] downloadImageForUrl:item.imageUrl withCompletionBlock:^(BOOL success, NSError *error, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (image) {
                cell.articleImageView.clipsToBounds = YES;
                cell.articleImageView.image = image;
                //cell.articleImageView.layer.cornerRadius = 30.0;
                [self fadeInView:cell.articleImageView];
                //cell.articleImageView.frame = CGRectMake(10, 0, self.view.frame.size.width-20, 300);
            }
            else{
                cell.imageView.image = [UIImage imageNamed:@"news_error"];
                [self fadeInView:cell.articleImageView];
            }
        });
    }];
    
    
    cell.backgroundColor = [UIColor clearColor];
   // cell.contentView.backgroundColor = [UIColor darkGrayColor];
    
    return cell;
}


/*Assumes the alpha of aView is set to 0.0 */
-(void)fadeInView:(UIView*)aView
{
    [UIView animateWithDuration:0.3 animations:^{
        aView.alpha = 1.0;
    }];
}

// iOS 6+ code here
// Pre iOS 6 code here

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8)
    {
        // your code
       return [self heightForBasicCellAtIndexPath:indexPath];

    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static KKNewsFeaturedTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"FeaturedNewsCell"];
    });
    
    [self setUpFeaturedTableViewCellForTableView:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 300.0f;
}*/

/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}*/

/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}*/

#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JJVPageRootViewController *pageRootVC = [[JJVPageRootViewController alloc] init];
    pageRootVC.index = [[JJVStoryItemStore sharedStore] indexOfStory:[self.newsArticles objectAtIndex:indexPath.section]];
    [self.navigationController pushViewController:pageRootVC animated:YES];
}

@end
