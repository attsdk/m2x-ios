
#import "AddStreamViewController.h"
#import "FeedsClient.h"

@interface AddStreamViewController ()

@end

@implementation AddStreamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_tfStreamId setDelegate:self];
    [_tfLogAValue setDelegate:self];
    [_tfSymbol setDelegate:self];
    [_tfUnit setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addStream:(id)sender {
    
    NSString *streamID = [_tfStreamId text];
    
    NSString *streamIDaceptedCharacters = @"^[a-zA-Z0-9\\-\\_]+$";
    
    NSPredicate *checkCharacters = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", streamIDaceptedCharacters];
    
    if ([checkCharacters evaluateWithObject: streamID]) {
    
        NSMutableDictionary *stream = [NSMutableDictionary dictionary];
        
        NSDictionary *unit = @{ @"label": [_tfUnit text], @"symbol": [_tfSymbol text] };
        
        [stream setObject:unit forKey:@"unit"];
        
        if(![[_tfLogAValue text] isEqualToString:@""])
            [stream setObject:[_tfLogAValue text] forKey:@"value"];
        
        [_feedClient createDataForStream:streamID inFeed:_feed_id withParameters:stream success:^(id object) {
            //stream successfully added, go back.
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error, NSDictionary *message) {
            [self showError:error WithMessage:message];
        }];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Stream ID"
                                                        message:@"Stream IDs can only contain letters, numbers, undescores, and dashes — no spaces or special characters are allowed."
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }

}

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
