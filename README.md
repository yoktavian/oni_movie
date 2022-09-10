# Oni Movie

A playground to explore flutter project using multiple modules.

## Getting Started

1. For the demo you can download the apk on the demo folder.

### Project Structure
```
Main
|--- library
|    |- oni_api
|    |- oni_router
|    |- oni_service_locator
|--- module
|    |- base
|    |  |- api_client
|    |- feature
|    |  |- feature_home
|    |  |- feature_search
|    |- shared
|    |  |- data
|    |  |  |- data_movie
|    |  |- domain
|    |  |  |- domain_movie
|    |  |- entity
|    |  |- navigation
|    |  |- onion
```

A. Library

All of module under library package should be ready to publish as an external library. 

For `oni_api` case this is just a wrapper of `Dio`. Why i need to wrap `Dio` into my own library? just because if in the features, we want to change the another 3rd party library for network layer we don't need to change the implementation in a lot of files, it's supposed to be impact on the `oni_api` only, that's it. So for each module that depends on my abstraction that is `OniApi` the method & behaviour is should be the same `get, post, put, etc` but the changes is only in the implementation class that client shouldn't be know about that.

`oni_router` was created to help us maintain our routing in flutter. abstraction layer to define some of routes and also the redirection. as you know flutter currently have 2 kind of navigations the first one is navigation1.0 and the another one is navigation2.0. currently i am using navigation1.0 with an abstraction layer in the `oni_router` it self. so if in the feature we want to change the navgiation from navigation1.0 to navigation2.0 we just need to change on the `oni_router` module.

`oni_service_locator` is a simple dependcy injection that help us to reduce the dependcy and decoupled the usage of class/object. also the another benefit is we don't have to reinitialize the same class multiple times. if you need some object you just need to call `serviceLocator.get<YourClass>()` that's it. currently it's only support for factory initialization, haven't support singleton yet.

B. Module

Base module only contains `api_client`. `api_client` that's just an implementation of `oni_api` library. So for spesific usage on this project, i create `api_client` module for that as a network layer in this project. There is an `interceptor` as well that contains any kind of configuration depends on the `FlavorConfig` like put `api_key` in the headers.

Feature module must be contains a lot of `features`. If in the feature there are some new feature we need to add the feature on this module. So if we have so many engineers that work together, and there are so many squads based on features it would be easy for us to work independently without conflict or just to minimize it. Each feature can depends on domain layer & entity layers except the data layer.

Shared module contains all of modules that have a high possibility to reuse in several modules. But it's not totally allowed to import all of the modules on the another modules that we have, depends on which layer it is. for example we have data, data shouldn't be import by `feature_module`, because `feature_module` is a presentation layer and to be able get data, presentation layer must be depends on the domain layer instead then domain connect to data layer and give it back to presentation layer via domain.

`Navigation` module was created to help us maintain the path and bundles for each screen. So for each features should be depends on this module to be able get all of the routes of the another screen.

`Onion` was created to standardize the design. So for sure the module contains some of reusable widgets that used in some of modules. It would be easy to reuse the component in several features, just need to import the library and we can use a lot of widget from there. Also there some style as well like textStyle and also color that can be used as a standardization for the project. With this module, we can exactly restrict our designer or developer to use another color or style except the style that already provided in the `Onion` module. That's just one of solution that we can take to standardize the design. The benefit of standarization would be powerfull because everysingle times we need to create new page we just need to use available component. But again, the designer and engineer must be align on that :)

# QnA
6. How to deal with memory leak & FPS drop?

`Answer:`

Before we're moving into the solution, we have to know the rootcause first. Ask the QA or someone that report the issue, and make sure we know how to reproduce it. After we're really sure and get enough information about that, we can start to investigate the screen. In flutter we have profiler/devtools to inspect all of process that run in our app. So we can inspect in spesific screen than find which code that lead to memory leak or causing FPS drop. usually it's because there are some process that run in async process and before the proceess has been done user already close the screen, so async process still running and keep the memory there even it's not gonna be use anymore. if it's not handled properly it will lead memory leak. the simple example is when we have a controller in screen, don't forget to dispose it when the screen disposed. so if it's no longer used, the memory can be cleared perfectly by garbage collector (GC). Talking about FPS drop, usually this is caused by there are some heavy process that run in the main thread, like parsing a big json so it will lead fps drop because the process blocking the main thread to long. because system need to render no longer than 16 ms to get 60 fps for each rendering session, if there is some process block the ui and exceed than that time, there will be some frame skipped and it make fps drop then you can see the ui will be very laggy/junky. the solution is, we have to offload any heavy process into another thread, don't use main thread. one of the solution that already provided by flutter team is we can use compute to offload the process like parsing a big json into the another thread.

7. How to avoid build apk/ipa multiple times manually?

`Answer:`

In the development phase we have something called continues integration/continues delivery (CI/CD) that can help us to build the apk everysingle times we merged our branch to master/main. Also we can config the system easyly using a Job in the pipeline to create the apk/ipa. Just need to configure our pipeline, need to create some script, and do integration with our project. We can use job pipeline in gitlab, or github action, or the another one that i know is we can use codemagic as well.
