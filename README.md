# TMApp

TMApp is a simple movie list view app that gives you the latest trending movies list along with other information of that movies such as its release date,
vote count, percentage of people liked the movie and information related to movie certificate by sensor board i.e A -> Adult(18+) or U/A.  

## Features

- [x] VIPER
- [x] Contains Dark Mode Support
- [x] Code based UI development (No xib, No storyoard)
- [x] Unit testing
- [x] Useful Extensions
- [x] Git braching module wise

## Implementation Description

Things taken care at the development.

1. Modular: I have tried my best to split the design in views and hence implemented every of the view object in a UIView class which means that it can be used everywhere from a tableviewcell to collectionview cell to any viewcontroller's view.
2. Gitable: Tried to maintain sanity of modularity using git branches with the concept of having to generic, feature[s], UI[s] based branching.
3. Discardable: Since I have used VIPER, any part of the code can be discarded.

## Requirements

- iOS 10.0+
- Xcode 11.0, 12.0+
- Swift 5.0+

## Meta

Jeet Kapadia - jeet10214@gmail.com
Distributed under the MIT license. See ``LICENSE`` for more information.
GitHub](https://github.com/jeet10214)
