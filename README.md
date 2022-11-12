# SwiftyWeatherApp

### What I learned 
- Getting famalier with alamofire Pod.
- How to working with APIs.
- Encodable & Decodable protocols
- JSONEncoder & JSONDecoder classes

## App Preview

![Simulator Screen Recording - iPhone 14 Pro Max - 2022-11-11 at 20 40 54](https://user-images.githubusercontent.com/100219531/201412537-f5a9739d-d902-4ee6-b3fc-6ac9c9efde0a.gif)


### Refactoring notes
- Moved Networking logic into seperate class.
- Created a model class for the weather containing its attributes.
- Used the view contoller for only updating the UI. It must not know any logic other than UI.
- Used completion handler to pass the data from the Networking class to MainVC.
- Converted temperature units using Apple's `Measurement` class.
- Networking class is UI independent.
- Using `guard let` is more convienent than `if let` in the cases I have fixed. 
- Removed Cocoapods and used SPM instead, you should never include your pods files inside your project, they will be fetched on every local machine if it ran `pod install`. This can be solved by adding the pods content inside the `.gitignore` file. 
- Rely more on enums insted of strings snice you can easilty miss-spell some.



