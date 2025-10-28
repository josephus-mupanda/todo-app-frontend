# todo_api_client.api.TasksApi

## Load the API package
```dart
import 'package:todo_api_client/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createTask**](TasksApi.md#createtask) | **POST** /api/v1/tasks | Create a new task
[**deleteTask**](TasksApi.md#deletetask) | **DELETE** /api/v1/tasks/{id} | Delete a task
[**getTaskById**](TasksApi.md#gettaskbyid) | **GET** /api/v1/tasks/{id} | Get task by ID
[**getTasks**](TasksApi.md#gettasks) | **GET** /api/v1/tasks | Get all tasks for the authenticated user
[**updateTask**](TasksApi.md#updatetask) | **PUT** /api/v1/tasks/{id} | Update a task


# **createTask**
> TaskDTO createTask(taskDTO)

Create a new task

Creates a task for the authenticated user.

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getTasksApi();
final TaskDTO taskDTO = ; // TaskDTO | 

try {
    final response = api.createTask(taskDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->createTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskDTO** | [**TaskDTO**](TaskDTO.md)|  | 

### Return type

[**TaskDTO**](TaskDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTask**
> deleteTask(id)

Delete a task

Deletes a task owned by the authenticated user.

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getTasksApi();
final String id = id_example; // String | 

try {
    api.deleteTask(id);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTaskById**
> TaskDTO getTaskById(id)

Get task by ID

Fetches a task by its ID if it belongs to the authenticated user.

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getTasksApi();
final String id = id_example; // String | 

try {
    final response = api.getTaskById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->getTaskById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TaskDTO**](TaskDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTasks**
> BuiltList<TaskDTO> getTasks()

Get all tasks for the authenticated user

Returns all tasks created by the current authenticated user.

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getTasksApi();

try {
    final response = api.getTasks();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->getTasks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TaskDTO&gt;**](TaskDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTask**
> TaskDTO updateTask(id, taskDTO)

Update a task

Updates the title or completion status of an existing task owned by the authenticated user.

### Example
```dart
import 'package:todo_api_client/api.dart';

final api = TodoApiClient().getTasksApi();
final String id = id_example; // String | 
final TaskDTO taskDTO = ; // TaskDTO | 

try {
    final response = api.updateTask(id, taskDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->updateTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **taskDTO** | [**TaskDTO**](TaskDTO.md)|  | 

### Return type

[**TaskDTO**](TaskDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

