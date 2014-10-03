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

@interface KKNewsViewController () <UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KKNewsTableViewCell" bundle:nil]forCellReuseIdentifier:@"NewsCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"KKNewsFeaturedTableViewCell" bundle:nil]forCellReuseIdentifier:@"FeaturedNewsCell"];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(getData)
      forControlEvents:UIControlEventValueChanged];
   // [refresh setTintColor:[UIColor darkGrayColor]];
    
    self.refreshControl = refresh;
    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    
    //[self.view addSubview:self.tableView];
    
    self.tableView.alpha = 1.0;
}

-(void)getData
{
    if (!self.refreshControl.isRefreshing)
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    [[KKNewsAPI sharedUtilities] downloadNewsFeedWithCompletionBlock:^(BOOL success, NSError *error) {
        self.newsArticles = [[JJVStoryItemStore sharedStore] allItems];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            self.tableView.contentSize = CGSizeMake(self.view.frame.size.width, 316 * self.newsArticles.count);
            [self.refreshControl endRefreshing];
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
    switch (indexPath.section)
    {
        case 0:
            return [self setUpFeaturedTableViewCellForTableView:tableView atIndexPath:indexPath];
            break;
        case 1:
            return [self setUpFeaturedTableViewCellForTableView:tableView atIndexPath:indexPath];
            break;
            
        default:
            return [self setUpFeaturedTableViewCellForTableView:tableView atIndexPath:indexPath];
            break;
    }
}


-(KKNewsFeaturedTableViewCell *)setUpFeaturedTableViewCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath*)indexPath
{
    KKNewsFeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeaturedNewsCell"];
    
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
    cell.articlePreviewTextView.font = [UIFont fontWithDescriptor:Descriptor size:14.0f];
    cell.articlePreviewTextView.textColor = [UIColor darkGrayColor];
    NSLog(@"%@", item.date);
   // cell.articleTimeLabel.text = @"Test";
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.section == 0)
        return 300.0f;
    //else
        //return 170.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}*/

#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"TAP");
    JJVReaderViewController *readerView = [[JJVReaderViewController alloc]
                                           initWithNibName:nil bundle:nil];
    
    //pass the selected story along to the reader view
    JJVStoryItem *story = [self.newsArticles objectAtIndex:indexPath.section];
    
    readerView.item = story;
    
    //push the reader view controller onto the screen
    [self.navigationController pushViewController:readerView
                                         animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource


@end
