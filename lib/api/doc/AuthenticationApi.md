# todo_api_client.api.AuthenticationApi

## Load the API package
```dart
import 'package:todo_api_client/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changePassword**](AuthenticationApi.md#changepassword) | **POST** /api/auth/change-password | Change password with token
[**confirmUser**](AuthenticationApi.md#confirmuser) | **POST** /api/auth/confirm | Confirm user email
[**login**](AuthenticationApi.md#login) | **POST** /api/auth/login | Login a user and get JWT token
[**logout**](AuthenticationApi.md#logout) | **POST** /api/auth/logout | Logout a user
[**register**](AuthenticationApi.md#register) | **POST** /api/auth/register | Register a new user
[**resetPassword**](AuthenticationApi.md#resetpassword) | **POST** /api/auth/reset-password | Request password reset


# **changePassword**
> GenericResponseString changePassword(code, changePasswordRequest)

Change password with token

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final String code = code_example; // String | 
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    final response = api.changePassword(code, changePasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

[**GenericResponseString**](GenericResponseString.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmUser**
> GenericResponseString confirmUser(code)

Confirm user email

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final String code = code_example; // String | 

try {
    final response = api.confirmUser(code);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->confirmUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 

### Return type

[**GenericResponseString**](GenericResponseString.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> GenericResponseLoginResponse login(loginRequest)

Login a user and get JWT token

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final LoginRequest loginRequest = ; // LoginRequest | 

try {
    final response = api.login(loginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

[**GenericResponseLoginResponse**](GenericResponseLoginResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logout**
> GenericResponseString logout(authorization)

Logout a user

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final String authorization = authorization_example; // String | 

try {
    final response = api.logout(authorization);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->logout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authorization** | **String**|  | 

### Return type

[**GenericResponseString**](GenericResponseString.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> GenericResponseOutput register(registerRequest)

Register a new user

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final RegisterRequest registerRequest = ; // RegisterRequest | 

try {
    final response = api.register(registerRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)|  | 

### Return type

[**GenericResponseOutput**](GenericResponseOutput.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> GenericResponseString resetPassword(resetPasswordRequest)

Request password reset

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getAuthenticationApi();
final ResetPasswordRequest resetPasswordRequest = ; // ResetPasswordRequest | 

try {
    final response = api.resetPassword(resetPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordRequest** | [**ResetPasswordRequest**](ResetPasswordRequest.md)|  | 

### Return type

[**GenericResponseString**](GenericResponseString.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

