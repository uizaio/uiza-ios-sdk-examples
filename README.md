# uiza-ios-sdk-examples
## uiza-ios-sdk-examples
## How to build
Requirement:

Xcode > 10.x

Swift > 4.x

Install Pod:

Open terminal and type

```
sudo gem install cocoapods
pod setup
```

Jump into exmaple directory and type:

```
pod install
```

Then click <a name="fenced-code-block">UizaPlayerTab.xcworkspace</a> to open project

### Notice

If you use UizaSDK 7.2, please add [Sentry](https://docs.sentry.io/clients/cocoa/) and `pod 'FrameLayoutKit'` mannually in podfile

### Swift 5

You can see UizaPlayerTab example


### Swift 3.2

You can see UizaPlayerV4 example

### How to customize Uiza Player Theme

To customize theme of Uiza Player, you follow these steps:

* Inheriting ``UZPlayerTheme``, for example we create UZPlayerCustomTheme()
* Overriding ``updateUI`` method to init your controls
* Overriding ``layoutControls(rect: CGRect)`` method to layout your controls.
* Overriding ``cleanUI()`` method to clean code, for example: removing delegate, removing gesture target,...
* Overriding ``allButtons() -> [UIButton]`` to returns all custom buttons if applicable
* Overriding ``showLoader()`` method to show loading indicator
* Overriding ``hideLoader()`` to hide loading indicator
* Overriding ``update(withResource: UZPlayerResource?, video: UZVideoItem?, playlist: [UZVideoItem]?)`` to update your UI according to video or playlist
* Call:

```
 let playerViewController = UZPlayerViewController()
 
 playerViewController.player.controlView.theme = UZPlayerCustomTheme()  
```
You can customize exist components of UizaPlayer:

* ``backButton:NKButton``
* ``playlistButton:NKButton``
* ``helpButton:NKButton``
* ``ccButton:NKButton``
* ``settingButton:NKButton``
* ``volumeButton:NKButton``
* ``playpauseCenterButton:NKButton``
* ``playpauseButton:NKButton``
* ``forwardButton:NKButton``
* ``backwardButton:NKButton``
* ``nextButton:NKButton``
* ``previousButton:NKButton``
* ``fullscreenButton:NKButton``
* ``timeSlider:UZSlider``
* ``castingButton:UZCastButton``
* ``totalTimeLabel:UILabel``
* ``remainTimeLabel:UILabel``

And relayout them by addSubview to controlView using some FrameLayout, for example ``StackFrameLayout``,....

You can add new components to UizaPlayer by:
* Creating new components, for example: UIButton, UILabel,...
* Creating delegate for components

See detail in [UZPlayerCustomTheme](https://github.com/uizaio/uiza-ios-sdk-examples/blob/master/UizaPlayerTab/UizaPlayerTab/Themes/UZPlayerCustomTheme.swift)