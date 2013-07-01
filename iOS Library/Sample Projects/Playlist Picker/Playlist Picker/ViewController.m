//
//  ViewController.m
//  Empty CocoaLibSpotify Project
//
//  Created by Daniel Kennett on 02/08/2012.
/*
 Copyright 2013 Spotify AB

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ViewController.h"
#import "CocoaLibSpotify.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

#pragma mark - Picking

-(IBAction)pickTrack:(id)sender {
	SPPlaylistPickerViewController *picker = [[SPPlaylistPickerViewController alloc] initWithMode:SPPlaylistPickerModeTrack
																						inSession:[SPSession sharedSession]];
	picker.allowCancel = YES;
	picker.allowPlaylistCreation = YES;

	__weak typeof(picker) weakPicker = picker;

	picker.cancellationHandler = ^{
		NSLog(@"Track picker was cancelled");
		[weakPicker dismissViewControllerAnimated:YES completion:nil];
	};
	
	picker.itemPickedHandler = ^(SPPlaylist *playlist, SPPlaylistItem *track) {
		NSLog(@"Track picker picked track %@ in playlist %@", track, playlist);
		[weakPicker dismissViewControllerAnimated:YES completion:nil];
	};

	[self presentModalViewController:picker animated:YES];
}

-(IBAction)pickPlaylist:(id)sender {

	SPPlaylistPickerViewController *picker = [[SPPlaylistPickerViewController alloc] initWithMode:SPPlaylistPickerModePlaylist
																						inSession:[SPSession sharedSession]];
	picker.allowCancel = YES;
	picker.allowPlaylistCreation = YES;

	__weak typeof(picker) weakPicker = picker;

	picker.cancellationHandler = ^{
		NSLog(@"Playlist picker was cancelled");
		[weakPicker dismissViewControllerAnimated:YES completion:nil];
	};

	picker.itemPickedHandler = ^(SPPlaylist *playlist, SPPlaylistItem *track) {
		NSLog(@"Playlist picker picked playlist %@", playlist);
		[weakPicker dismissViewControllerAnimated:YES completion:nil];
	};

	[self presentModalViewController:picker animated:YES];
	
}

@end