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
This project has 3 layers, presentation, domain, and data.

### Presentation
Presentation layer is Flutter a app module, contains UI related and services. There are 2 services in Presentation, NavigationService which using for navigating between screen, and PasscodeService for handling lock application with passcode when user inactive more than 10 seconds.

### Domain
Domain layer is a Dart module, contains object class and interface of Repository

### Data
Data layer is a Flutter package module, contains interaction with API. There are DTOs, Repository (implementation) and ApiService

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
To run unit test, run the following command from the root of the project
```dart
sh script/test.sh
```

## Run the integration test
To test on a real iOS / Android device, first connect the device and run the following command from the root of the project.

```dart
flutter test integration_test/smoke_test.dart
```

  
.  
.  
This project is licensed under the MIT License.

