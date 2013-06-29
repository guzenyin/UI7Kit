//
//  UITMasterViewController.m
//  UIKitExtensionTestApp
//
//  Created by Jeong YunWon on 12. 10. 24..
//  Copyright (c) 2012 youknowone.org. All rights reserved.
//

#import "UITMasterViewController.h"

#import "UITDetailViewController.h"

@interface UITMasterViewController ()

@property(nonatomic, strong) NSArray *details, *issues;

@end

@implementation UITMasterViewController
						
- (void)dealloc {
    self.details = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAlert:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;

    self.details = @[
                     @"Detail",
                     @"Custom",
//                     @"PreparedCellTable",
                     @"Text",
//                     @"SubviewTable",
                     ];
    self.issues = @[@1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlert:(id)sender {
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.details.count;
        case 1:
            return self.issues.count;
        default:
            break;
    }
    assert(NO);
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    switch (indexPath.section) {
        case 0:
            cellIdentifier = self.details[indexPath.row];
            break;
        case 1:
            cellIdentifier = [@"#%@" format:self.issues[indexPath.row]];
            break;
        default:
            assert(NO);
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIImage *originalImage = [UIImage imageNamed:@"UI7TableViewCellDisclosureIndicator"];
    // TEST: UIImage -imageByResizingToSize:
    UIImage *bulletImage = [originalImage imageByResizingToSize:CGSizeMake(15.0, 20.0)];
    cell.imageView.image = bulletImage;

    cell.textLabel.text = cellIdentifier;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Example views";
        case 1:
            return @"Issues regression test";
        default:
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == tableView.numberOfSections - 1) {
        return @"FOOTER!";
    }
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.listTableView setEditing:editing animated:animated];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

@end
