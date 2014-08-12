//
//  MasterViewController.m
//  TroyStory4
//
//  Created by Iván Mervich on 8/12/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MasterViewController.h"
#import "Trojan.h"

@interface MasterViewController ()

@property NSArray *trojans;
@property BOOL toggle;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self loadData];
}

- (void)loadData
{
	NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"prowess" ascending:NO];
	NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
	NSArray *sortDescriptors = @[sortDescriptor1, sortDescriptor2];
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Trojan"];
	request.sortDescriptors = sortDescriptors;

	if (self.toggle) {
		request.predicate = [NSPredicate predicateWithFormat:@"prowess >= %d", 5];
	} else {
		request.predicate = [NSPredicate predicateWithFormat:@"prowess < %d", 5];
	}

	self.trojans = [self.managedObjectContext executeFetchRequest:request error:nil];
	[self.tableView reloadData];
}

#pragma mark - IBActions

- (IBAction)onToggleProwess:(id)sender
{
	self.toggle = !self.toggle;
	[self loadData];
}

- (IBAction)onNewTrojanConquest:(UITextField *)sender
{
	Trojan *trojan = [NSEntityDescription insertNewObjectForEntityForName:@"Trojan" inManagedObjectContext:self.managedObjectContext];
	trojan.name = sender.text;
	//number between 0 and 10
	trojan.prowess = [NSNumber numberWithInt:arc4random_uniform(11)];
	[self.managedObjectContext save:nil];
	[sender resignFirstResponder];
	[self loadData];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	Trojan *trojan = self.trojans[indexPath.row];
	cell.textLabel.text = trojan.name;
	cell.detailTextLabel.text = trojan.prowess.description;
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.trojans.count;
}

@end
