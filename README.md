# HatchWorks
Application built to complete the Hatchworks iOS code challenge.

## Requirements
- Xcode 16.4
- iOS 18+

## Project setup
To run this project, you only need to open the HatchWorksCodeChallenge.xcodeproj file using Xcode. As Swift Package Manager is used for dependency management, Xcode will automatically download the libraries used by the project, and after finishing this, the application can be run.

## Third-party libraries
- [SDWebImage](https://github.com/SDWebImage/SDWebImageSwiftUI): SwiftUI image loading and cache framework.

## Architecture
<img width="2644" height="1364" alt="architecture" src="https://github.com/user-attachments/assets/a0dff9eb-afe9-4178-bba7-42734ca3d331" />
The Hatchworks app has been created using an architecture based on the [Clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) proposal that, in short terms, looks to create different layers to separate concerns and control the data and flow control of the system. In this case, there are three main layers in the Hatchworks app code:
- Presentation: Is in charge of all the visual elements and interfaces to be shown to the user. MVVM is being used as a design pattern, using the SwiftUI framework and Observable macros to create the communication between the View and the ViewModel that works as a bridge between this layer and the others.
- Domain: Keeps all the business logic and rules that define the app's behavior. In the Hatchworks app, this layer holds the Models used to retrieve the data from the Data layer, which is used in the Presentation layer. As this specific app doesn't require complex business logic, I have decided to remove any intermediate class in this layer to make the code more easy to navigate. In a more complex scenario, this layer will keep all the code related to the business logic and rules.
- Data: This layer is in charge of all the data necessary for the normal behavior of the Hatchworks App. A repository pattern is used to bring the data to the domain layer, in this case, the data request and response are made by the view models to the repository, which internally will retrieve the data from the API or the local persistence, being this operation transparent for the data requester. The Hatchworks app supports offline navigation, saving the models and data locally using the SwiftData framework.

Finally, there is a transversal layer that is in charge of holding all the external libraries used in the Hatchworks codebase, which in this case is only one. 

## App Features
As an overview, next, I will list the features added to the Hatchworks app:

**Shows**
It retrieves from the API the shows that the user will be able to see in the app. The user can select between `Movies` or `TV Series`, and for each one of these, there will be a highlighted item and four main categories. For `Movies`, the categories are:
- Now playing
- Popular
- Top rated
- Upcoming

For the `TV Series`, the four categories are:

- Airing today
- On the air
- Popular
- Top rated

In the main screen, the user will be able to see a highlighted item, and the first items of each category, also the user can see the full list of items per category and will be able to load more items using and lazy loader located at the end of the list.

The user can also select any item from either the main screen or the category list, and the app will show a detail view with more information about it.

This section of the app supports offline navigation.

**Search**
Allows the user to search for shows using a search text entry. The user can select if the search is on the `Movies` section or the `TV Series`. Here, the user is also able to select any item and see its detailed information.

This section works only with an internet connection due to the need for the search API.
