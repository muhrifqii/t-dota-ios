<p align="center">
  <h1 align="center">Dota Char Stat</h1>
</p>
<p align="center">
  <h3 align="center">An iOS SwiftUI <a href="https://www.opendota.com">OpenDota</a> Heroes Browser built with (almost) VIPER</h3>
</p>
<p align="center">
  <img src="https://img.shields.io/badge/-5.3-RED.svg?logo=swift&logoColor=white" />
  <a href="https://github.com/muhrifqii/t-dota-ios/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-BLUE.svg" />
  </a>  
</p>
<p align="center">
  <img src="https://github.com/muhrifqii/t-dota-ios/blob/master/.github/content/ss1.png" width="200"/>
  &nbsp;
  <img src="https://github.com/muhrifqii/t-dota-ios/blob/master/.github/content/app_preview.gif" width="200"/>
  &nbsp;
  <img src="https://github.com/muhrifqii/t-dota-ios/blob/master/.github/content/ss2.png" width="200"/>
</p>

### Stack used in this project
- SwiftUI
- Coredata
- Codable
- Carthage (https://github.com/Carthage/Carthage)
- Alamofire (https://github.com/Alamofire/Alamofire)
- Moya (https://github.com/Moya/Moya)
- Kingfisher SwiftUI (https://github.com/onevcat/Kingfisher)
- QGrid (https://github.com/Q-Mobile/QGrid)
- Introspect (https://github.com/siteline/SwiftUI-Introspect)

### Architecture being used is VIPER
To proof that Routing (or Coordinating or Wireframing) on SwiftUI is hard to implement with vanilla VIPER when using `NavigationLink`

```sequence
|Wireframe| <-- (as Dependency Injection, its not used as router here)
   __|__           |            |                 |               |
 |SwiftUI| <--> |View| <--> |Presenter| <--> |Interactor| <--> |Entity|
```
