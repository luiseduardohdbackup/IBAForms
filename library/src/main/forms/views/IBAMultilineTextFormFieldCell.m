//
// Copyright 2010 Itty Bitty Apps Pty Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "IBAMultilineTextFormFieldCell.h"
#import "IBAFormConstants.h"


static const CGFloat kTextViewPadding = 8.;

@interface IBAMultilineTextView : UITextView
@end

@interface IBAMultilineTextFormFieldCell ()
- (CGRect)textViewFrame:(CGSize)size;
@end


@implementation IBAMultilineTextFormFieldCell

@synthesize textView;

- (void)dealloc {
	IBA_RELEASE_SAFELY(textView);

	[super dealloc];
}


- (id)initWithFormFieldStyle:(IBAFormFieldStyle *)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFormFieldStyle:style reuseIdentifier:reuseIdentifier]) {
		// Create the text view for data entry
		textView = [[IBAMultilineTextView alloc] initWithFrame:CGRectZero];
//		textView.contentInset = UIEdgeInsetsZero;
		textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		textView.scrollEnabled = NO;
		textView.font = [UIFont systemFontOfSize:16];
		textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
		textView.autocorrectionType = UITextAutocorrectionTypeDefault;
		textView.dataDetectorTypes = UIDataDetectorTypeAll;
		textView.keyboardType =UIKeyboardTypeASCIICapable;

		[self.cellView addSubview:self.textView];
	}

    return self;
}

- (void)activate {
	[super activate];

//	self.textView.backgroundColor = [UIColor clearColor];
}


- (void)applyFormFieldStyle {
	[super applyFormFieldStyle];

//	self.textView.contentInset = UIEdgeInsetsZero;
	self.backgroundColor = [UIColor blueColor];
	self.textView.font = self.formFieldStyle.valueFont;
	self.textView.textColor = [UIColor blackColor]; //self.formFieldStyle.valueTextColor;
	self.textView.backgroundColor = [UIColor redColor]; //self.formFieldStyle.valueBackgroundColor;
														//	self.textView.backgroundColor = [UIColor yellowColor]; //self.formFieldStyle.valueBackgroundColor;
}

- (CGSize)sizeThatFits:(CGSize)size {
//	CGSize viewSize = CGRectInset([self textViewFrame:size], (kTextViewPadding * -1), (kTextViewPadding * -1)).size;
	CGSize viewSize = [self textViewFrame:size].size;

	return viewSize;
}

- (void)layoutSubviews {
	textView.frame = [self textViewFrame:[self bounds].size];
}

- (CGRect)textViewFrame:(CGSize)size {
	CGSize newTextViewSize = [self.textView.text sizeWithFont:self.formFieldStyle.valueFont
											constrainedToSize:CGSizeMake(size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];

	CGSize suggestedTextViewSize = [self.textView sizeThatFits:size];
	
	newTextViewSize.height = MAX(newTextViewSize.height, size.height);
	newTextViewSize.width = MAX(newTextViewSize.width, size.width);

	CGRect newTextViewFrame = CGRectMake(0, 0, newTextViewSize.width, newTextViewSize.height);
	return newTextViewFrame;
}

@end


@implementation IBAMultilineTextView

- (UIEdgeInsets) contentInset {
	return UIEdgeInsetsZero; 
}

@end
