import 'package:test/test.dart';
import 'package:todo_api_client/todo_api_client.dart';


/// tests for TasksApi
void main() {
  final instance = TodoApiClient().getTasksApi();

  group(TasksApi, () {
    // Create a new task
    //
    // Creates a task for the authenticated user.
    //
    //Future<TaskDTO> createTask(TaskDTO taskDTO) async
    test('test createTask', () async {
      // TODO
    });

    // Delete a task
    //
    // Deletes a task owned by the authenticated user.
    //
    //Future deleteTask(String id) async
    test('test deleteTask', () async {
      // TODO
    });

    // Get task by ID
    //
    // Fetches a task by its ID if it belongs to the authenticated user.
    //
    //Future<TaskDTO> getTaskById(String id) async
    test('test getTaskById', () async {
      // TODO
    });

    // Get all tasks for the authenticated user
    //
    // Returns all tasks created by the current authenticated user.
    //
    //Future<BuiltList<TaskDTO>> getTasks() async
    test('test getTasks', () async {
      // TODO
    });

    // Update a task
    //
    // Updates the title or completion status of an existing task owned by the authenticated user.
    //
    //Future<TaskDTO> updateTask(String id, TaskDTO taskDTO) async
    test('test updateTask', () async {
      // TODO
    });

  });
}
