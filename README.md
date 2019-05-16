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

## Usage

### Framework Init

Always initialize the framework with following line before using any UizaSDK methods:

```
import UizaSDK
UizaSDK.initWith(appId: appId, token: appKey, api: appUri, enviroment: .production, version: .v3)
```
* appId: your appId. You can get it by access your Dashboard of your workspace.
* appKey: your app's key. You can get it by access your Dashboard of your workspace.
* appUri:
 * If using v3 api, you can get it by access your Dashboard
 * If using v4 api, you only input this `ap-southeast-1-api.uiza.co`
* version: you can use `v3` or `v4`

### Disable App Transport Security (ATS) to able play video
You need to add these lines to Info.plist file:

```xml
<key>NSAppTransportSecurity</key>  
<dict>  
  <key>NSAllowsArbitraryLoads</key><true/>  
</dict>
```

### Disable App Transport Security (ATS) to able  livestream

You need to add these lines to Info.plist file:

~~~xml
<key>NSCameraUsageDescription</key>
<string>App needs access to camera for livestream</string>
<key>NSMicrophoneUsageDescription</key>
<string>App needs access to microphone for livestream</string>
~~~

### Call API

```swift
let playerViewController = UZPlayerViewController()
playerViewController.player.loadVideo(entityId: ENTITY_ID)
present(playerViewController, animated: true, completion: nil)
```

### How to play video

~~~swift
let playerViewController = UZPlayerViewController()
playerViewController.player.loadVideo(entityId: ENTITY_ID)
present(playerViewController, animated: true, completion: nil)
~~~
### How to broadcast livestream

To livestream, you need to follow these steps:

* Creating a live entity by call a post request to ``/api/public/v4/live/entity/feed`` for API v4 or ``/api/public/v3/live/entity/feed`` for API v3

```swift

func sendRequest(parameters params:[String: Any], link urlLink:String, protocol proto: String, completion: @escaping ([String: Any]?, Error?) -> Void){
        let requestBody = try? JSONSerialization.data(withJSONObject: params)
        let url = URL(string: urlLink)
        var request = URLRequest(url: url!)
        request.httpMethod = proto
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(String(describing: requestBody))", forHTTPHeaderField: "Content-Length")
        request.setValue(sdkKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                completion(nil, error)
                return
            }
            let response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? [String: Any]{
                print("\(response)")
                completion(response, nil)
                return
            }
        }
        task.resume()
    }
```
* Starting live entity
* Push data to live's url

```swift
@IBAction func createLive(_ sender: UIButton) {
        let mode = modePicker.selectedRow(inComponent: modePickerComponent)
        let encode = modePicker.selectedRow(inComponent: encodePickerComponent)
        let dvr = modePicker.selectedRow(inComponent: dvrPickerComponent)
        if(liveName.text == nil){
            return
        }
        if(liveName.text!.isEmpty){
            return
        }
        let params:[String:Any] = ["name": liveName.text!, "mode" : modeList[mode], "encode": encode, "dvr": dvr, "linkStream": [], "resourceMode": "single"]
        //create live event
        self.sendRequest(parameters: params, link: "https://" + sdkUri + "/api/public/v4/live/entity", protocol: "POST"){response, error in
            if error != nil {
                print("\(error)")
            }else{
//                print("\(response!["data"])")
                //start live event
                let data:[String:Any] = response!["data"] as! [String : Any]
                let liveId = data["id"]
                let liveParams:[String:Any] = ["id": liveId!]
                self.sendRequest(parameters: liveParams, link: "https://" + sdkUri + "/api/public/v4/live/entity/feed", protocol: "POST"){ response,error in
                    if error != nil {
                        print("\(error)")
                    }else{
                        let type:String = response!["type"] as! String
                        if type == "SUCCESS"{
                            sdkLiveId = liveId as! String
                            self.startLiveStream()
                        }else{

                        }
                    }
                }
                
            }
        }
    }
```
### How to change Uiza Player theme

You can change by adding these line:

~~~swift
let playerViewController = UZPlayerViewController()
playerViewController.player.theme = UZTheme1()
~~~

UizaPlayer currently has 7 built-in themes:

* UZTheme1
* UZTheme2
* UZTheme3
* UZTheme4
* UZTheme5
* UZTheme6
* UZTheme7

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