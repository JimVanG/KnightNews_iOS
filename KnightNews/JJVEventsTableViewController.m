//
//  JJVEventsTableViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVEventsTableViewController.h"
#import "JJVEventItem.h"
#import "JJVEventsTableViewCell.h"
#import "Constants.h"

NSString *const EVENT_NAME = @"event_name";
NSString *const EVENT_DATE = @"event_date";
NSString *const EVENT_DESC = @"event_desc";

@interface JJVEventsTableViewController ()

@property (nonatomic, strong) NSString *element;
@property (nonatomic, strong) JJVEventItem *eventItem;
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation JJVEventsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Events";
        self.tabBarItem.image = [UIImage imageNamed:@"events_25"];
        self.tabBarItem.title = @"Events";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //load the NIB file for the tableview cells
    UINib *cellNib = [UINib nibWithNibName:@"JJVEventsTableViewCell" bundle: nil];
    //register the nib to be reused
    [self.tableView registerNib: cellNib forCellReuseIdentifier:@"JJVEventsTableViewCell"];
    
    self.items = [[NSMutableArray alloc] init];
    
    self.xmlParser = [[NSXMLParser alloc]initWithContentsOfURL:
                      [NSURL URLWithString: @"http://knightnews.com/events.xml"]];
    self.xmlParser.delegate = self;
    self.xmlParser.shouldResolveExternalEntities = NO;
    
    [self.xmlParser parse];
    
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


#pragma mark - NSXMLParser delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.element = elementName;
    
    //each new event item starts with "event_name" so this we will need to create a new
    //event item object here.
    if ([self.element isEqualToString: EVENT_NAME]) {
        self.eventItem = [[JJVEventItem alloc] init];
        
        self.tempTitle = [[NSMutableString alloc] init];
        self.tempDesc = [[NSMutableString alloc] init];
        self.tempDate = [[NSMutableString alloc] init];
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.element isEqualToString: EVENT_NAME]) {
        [self.tempTitle appendString: string];
    }
    else if ([self.element isEqualToString: EVENT_DATE]){
        [self.tempDate appendString: string];
    }
    else if ([self.element isEqualToString: EVENT_DESC]){
        [self.tempDesc appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString: EVENT_NAME]) {
        self.eventItem.title = self.tempTitle;
    }
    else if ([elementName isEqualToString: EVENT_DATE]) {
        self.eventItem.date = self.tempDate;
    }
    else if ([elementName isEqualToString: EVENT_DESC]) {
        self.eventItem.desc = self.tempDesc;
        
        //The way that the XML is formed, after we have parsed the
        //eventDescription we have parsed the entire event object.
        [self.items addObject: self.eventItem];
        
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJVEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJVEventsTableViewCell" forIndexPath: indexPath];
    
    JJVEventItem *e = [self.items objectAtIndex: indexPath.item];
    // Configure the cell...
    cell.nameLabel.text = e.title;
    cell.descriptionLabel.text = [e.desc stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.dateLabel.text = [e.date stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return cell;
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
