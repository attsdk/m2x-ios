
#import "AddStreamViewController.h"
#import "CBBStreamClient.h"

@interface AddStreamViewController ()

@end

@implementation AddStreamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tfStreamId.delegate = self;
    self.tfLogAValue.delegate = self;
    self.tfSymbol.delegate = self;
    self.tfUnit.delegate = self;
}

- (IBAction)addStream:(id)sender {
    
    NSString *streamID = [_tfStreamId text];
    
    NSString *acceptedChars = @"^[a-zA-Z0-9\\-\\_]+$";
    
    NSPredicate *checkCharacters = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", acceptedChars];
    
    if ([checkCharacters evaluateWithObject: streamID]) {
    
        NSMutableDictionary *args = [NSMutableDictionary dictionary];
        
        args[@"unit"] = @{ @"label": self.tfUnit.text, @"symbol": self.tfSymbol.text };
        
        if (![self.tfLogAValue.text isEqualToString:@""]) {
            args[@"value"] = self.tfLogAValue.text;
        }
        
        [_deviceClient createDataForStream:streamID
                                  inDevice:_device_id
                          withParameters:args
                       completionHandler:^(id object, NSURLResponse *response, NSError *error) {
                           
                       if (error) {
                           [self showError:error WithMessage:[error userInfo]];
                       } else {
                           [self.navigationController popViewControllerAnimated:YES];
                       }
            
        }];
        
    } else {
        
        [[[UIAlertView alloc] initWithTitle:@"Invalid Stream ID"
                                    message:@"Stream IDs can only contain letters, numbers, undescores, "
                                            @"and dashes — no spaces or special characters are allowed."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    }

}

-(void)showError:(NSError*)error
     WithMessage:(NSDictionary*)message
{
    [[[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                message:message.description
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}



#pragma mark - inputs focus

//hide text fields
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - 0.2 * viewRect.size.height;
    CGFloat denominator =0.6 * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _animatedDistance = floor(216 * heightFraction);
    }
    else
    {
        _animatedDistance = floor(162 * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

@end
