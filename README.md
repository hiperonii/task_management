# Task Management Project

## Description
Task management project.

## Installation
1. Ensure you have Flutter SDK installed. If not, follow the official installation guide for your operating system.
2. Clone this repository using Git:
```bash
git clone https://github.com/hiperonii/task_management.git
```

## Run the project
1. Fetch the dependencies by run update_package.sh from the root of the project.
```dart
sh script/update_package.sh
```
2. Generate code by run generate_code.sh from the root of the project.
```dart
sh script/generate_code.sh
```

## Project structure
This project has 3 layers, presentation, domain, and data. Using *get_it* to do dependency injection. 

### Presentation
Presentation layer is a Flutter app module, contains UI related and services. Using MVVM pattern combines with *rxdart* as a statemanagement.  
There are 2 services, NavigationService which using for navigating between screen, and PasscodeService for handling lock application with passcode when user inactive more than 10 seconds.

### Domain
Domain layer is a Dart module, contains object class and interface of Repository. 

### Data
Data layer is a Flutter package module, contains interaction with API. There are DTOs, Mapper, implementation of Repository and ApiService.
Using *dio* as HTTP client, with *retrofit* to generate boilerplate code.

### Project  
root    
|--lib  
&emsp;&emsp;&emsp;|--main.dart      
&emsp;&emsp;&emsp;|--app.dart  
|--data  
&emsp;&emsp;&emsp;|--api_service    
&emsp;&emsp;&emsp;|--dto  
&emsp;&emsp;&emsp;|--repository (implement)   
|--domain  
&emsp;&emsp;&emsp;|--entity  
&emsp;&emsp;&emsp;|--repository (interface)  
|--presentation  
&emsp;&emsp;&emsp;|--screen  
&emsp;&emsp;&emsp;|--service  
|--script

## Run the unit test
To run unit test, run the following command from the root of the project.  
(Currently, I implemented test cases only in presentation layers, to test logic of view model)
```dart
sh script/test.sh
```

## Run the integration test
To test on a real iOS / Android device, first connect the device and run the following command from the root of the project.  
(There are 2 group of test cases, test TaskList and Passcode)

```dart
flutter test integration_test/smoke_test.dart
```

  
.  
.  
This project is licensed under the MIT License.

