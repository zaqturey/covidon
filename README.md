# covidon

A project to get covid info.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help to get started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Commits History

### Updated 'DataRepository' class by common code into a separate method (code reusability) 
***data_repository.dart***
1. _getDataRefreshingToken<T>() --> Added this new method to check if '_accessToken' is valid or not and then calling the passed in function 'onGetData' using that 'accessToken'
2. getEndpointDataApiV1(Endpoint endpoint) --> Refactored to use '_getDataRefreshingToken<T>()'
3. getAllEndpointDataApiV1() --> Refactored to use '_getDataRefreshingToken<T>()'


### Updated 'EndpointsData' class 
***endpoints_data.dart***
1. Getters -> Added getters using 'Endpoint' enum values
2. toString() -> Overridden 'toString()' to get/print debugging information about an 'EndpointsData' object 


### Added a Model class to create a 'Map<Endpoint, int>' by using the List<int> and used it in '_getAllEndpointDataApiV1()'
***endpoints_data.dart***
1. EndpointsData -> A new Class has been added, that takes a 'Map<Endpoint, int>' parameter for its default constructor.

***data_repository.dart***
1. _getAllEndpointDataApiV1() -> method has been updated to put the responses from 'Future.wait' to final variable i.e. 'endpointsValues'
2. _getAllEndpointDataApiV1() -> updated the method signature to return 'Future<EndpointsData>'
3. EndpointsData ->  Created a new 'Map<Endpoint, int>' i.e. 'EndpointsData' using 'Endpoint' enums and Indexes from 'endpointsValues' and added it as return value for '_getAllEndpointDataApiV1()'.  


### Refactored '_getAllEndpointDataApiV1()' to Fetch data PARALLELY
***data_repository.dart***
1. _getAllEndpointDataApiV1() -> method has been refactored to use 'Future.wait' to process requests PARALLELY and then put the responses in the Temp list.


### Added a method to fetch data from all the Endpoints
***data_repository.dart***
1. _getAllEndpointDataApiV1() -> Added this new method that will SEQUENTIALLY fetch the Data from all the Endpoints


### Added a separate Card widget, that will be used by Endpoints
***endpoint_card.dart***
1. A new 'EndpointCard' class (that extends a stl widget) has been added, that takes an 'Endpoint' and 'int' parameters for its default constructor.
2. Defined the 'Card' widget to display the passed in values for 'Endpoint' and 'int' .

***dashboard.dart***
1. Defined an int variable i.e. '_cases'.
2. _updateData() -> function that gets the EndpointData using ' Provider.of<DataRepository>' and then calling the 'setState' to update the value of '_cases' variable.
3. initState() -> overridden 'initState' to call '_updateData()'
1. Added 'EndpointCard' as children of the 'ListView', (passing 'endpoint: Endpoint.cases', and 'value: _cases' as arguments)


### Refactoring - Started implementing a separate UI layer
***dashboard.dart***
1. Added a new 'UI' folder.
2. Added a new 'Dashboard' class (that extends a stf widget) in a newly crated 'dashboard.dart' file.

***main.dart***
1. Refactored 'home' widget to call 'Dashboard()' instead to 'MyHomePage()'
2. Removed implementation for 'MyHomePage()' widget.


### Added 'Provider' package to make 'DataRepository' available throughout the 'MaterialApp' widget. 
***main.dart***
1. Wrapped 'MaterialApp' in another Widget i.e. 'Provider<DataRepository>'
2. Added 'Create' method (required by the Provider) that implement a Closure method for 'DataRepository' (passing required 'APIService' argument to it.)
3. In 'MaterialApp' widget, disabled 'debugShowCheckedModeBanner' by setting its value to 'false'
4. Added Dark theme for 'MaterialApp'
5. Updated default values for 'ThemeData' i.e. 'scaffoldBackgroundColor' and 'cardColor'
 

### Separating the 'Presentation' layer by creating a separate 'DataRepository' class
***endpoint.dart***
1. Added a new 'DataRepository' class with a class constructor that accepts a required 'apiService' parameter.
2. Added 'getEndpointDataApiV1' method that accepts an 'Endpoint' parameter and returns a 'Future<int>' after querying the 'accessToken' and 'endpoint'


### Added functionality to fetch and display endpoint data i.e. 'Cases', ''Recovered'
***endpoint.dart***
1. Added a new 'enum' i.e. 'Endpoint' that will be used to refer available API Endpoints

***api_endpoint.dart***
1. Added variables required to create new Endpoint Uri i.e.  'basePath', 'apiVersionV1', '_paths'
2. '_paths' will store a 'Map' of the 'Endpoint' enum and API endpoint text.
3. Method 'getEndpointUriNcovV1' is added to generate and return a Uri, based on the 'Endpoint' parameter
 
***api_service.dart***
1. Added a new Variable i.e. '_responseJsonKeys' that will store a 'Map' of the 'Endpoint' enum and corresponding API Key name'
2. Added a new method i.e. 'getEndpointDataApiV1' that will i.e.
2.1. Accepts two required parameters i.e. 'String accessToken' and 'Endpoint endpoint'
2.2. Makes a GET request using the passed in 'endpoint'
2.3. Based on the 'endpoint', it gets the corresponding '_responseJsonKeys' and then fetches its Value from the JSON response
2.4. returns the response as an int value.
2.5. Implemented error handling if there is an issue in fetching the JSON response 

***main.dart***
1. Fetched values for 'cases' and 'recovered' using 'apiService.getEndpointDataApiV1'
2. Added separate Text widgets to display values for 'cases' and 'recovered' 
3. Updated 'setState()' to the 'Text widgets' whenever the value for 'cases' and 'recovered' changes.

### Updated 'main.dart' to display 'accessToken' received from 'APIService'
***main.dart***
1. Replaced 'int _counter' with 'String _accessToken'.
2. Replaced '_incrementCounter()' with '_updateAccessToken()' i.e.
2.1. It fetches the 'accessToken' from 'apiService.getAccessToken()'.
2.2. in the 'SetState()', assign the new value of 'accessToken' to '_accessToken'.
3. Updated 'onPressed' of FAB to call '_updateAccessToken' instead of '_incrementCounter'.
4. Updated 'Text' to use value of '_accessToken' instead of '_counter'.
 

### Added Static API Keys, Factory Constructor, URI creation, Making HTTP request and processing HTTP response
***api_keys.dart***
1. Added a new Dart file i.e. 'api_keys.dart'
2. Added 'ncovApiV1SandboxKey' (and V2) Api KEYs that will be used to get to access-token.

***api_endpoint.dart***
- Note:   
- Instance of the class will be used to build and return a desired URI.
1. Added a new Dart file i.e. 'api_endpoint.dart'
2. Added a default Constructor that accepts a @required String parameter i.e. 'this.apiKey' 
3. Added a Factory constructor i.e. 'APIEndpoint.sandboxV1()' that returns an 'apiKey' from 'api_keys.dart'
4. Added two static properties and associated values i.e. 'host' and 'port'
5. Added 'tokenUri()' method that returns a 'Uri' based on the values provided. 

***api_service.dart***
- Note:   
- Instance of the class will be used to make a Rest Request (Using URI) and return the API response i.e. 'Access Token' in this case.
1. Added a new Dart file i.e. 'api_service.dart'
2. Added a default Constructor that accepts a @required APIEndpoint parameter i.e. 'this.apiEndpoint' 
3. Added 'getAccessToken()' method that 
3.1. Makes an HTTP Post request using the URI received from 'apiEndpoint.getTokenUri().toString()'
3.2. Fetches and returns the value associated  'access_token' key present in the JSON response received from HTTP request.
3.2. Throw (and 'print') error (response) if (response.statusCode != 200).


