MSButtonPanel
=============

MSButtonPanel is a UIView subclass that holds a row of buttons. Each button expands or collapses dynamically on selection. All developers need to do to initialize it is to pass in an array of strings to be displayed when each respective button is selected (as well as optional parameters for background colors, text colors, and fonts), like this: 

    MSButtonPanel *buttonPanel = [[MSButtonPanel alloc] initWithButtonTitles:@[@"Test", @"Test", @"Test", @"Test", @"Test"]];
    [self.view addSubview:buttonPanel];

Here's a short GIF showing it in action: 

![Test](MSButtonPanel.gif)
