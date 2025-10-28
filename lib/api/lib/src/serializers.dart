//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:todo_api_client/src/date_serializer.dart';
import 'package:todo_api_client/src/model/date.dart';

import 'package:todo_api_client/src/model/change_password_request.dart';
import 'package:todo_api_client/src/model/generic_error_response.dart';
import 'package:todo_api_client/src/model/generic_response_login_response.dart';
import 'package:todo_api_client/src/model/generic_response_output.dart';
import 'package:todo_api_client/src/model/generic_response_string.dart';
import 'package:todo_api_client/src/model/login_request.dart';
import 'package:todo_api_client/src/model/login_response.dart';
import 'package:todo_api_client/src/model/output.dart';
import 'package:todo_api_client/src/model/register_request.dart';
import 'package:todo_api_client/src/model/reset_password_request.dart';
import 'package:todo_api_client/src/model/task_dto.dart';
import 'package:todo_api_client/src/model/user_type.dart';

part 'serializers.g.dart';

@SerializersFor([
  ChangePasswordRequest,
  GenericErrorResponse,
  GenericResponseLoginResponse,
  GenericResponseOutput,
  GenericResponseString,
  LoginRequest,
  LoginResponse,
  Output,
  RegisterRequest,
  ResetPasswordRequest,
  TaskDTO,
  UserType,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskDTO)]),
        () => ListBuilder<TaskDTO>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
