//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:todo_api_client/src/model/login_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generic_response_login_response.g.dart';

/// GenericResponseLoginResponse
///
/// Properties:
/// * [payload] 
/// * [message] 
@BuiltValue()
abstract class GenericResponseLoginResponse implements Built<GenericResponseLoginResponse, GenericResponseLoginResponseBuilder> {
  @BuiltValueField(wireName: r'payload')
  LoginResponse? get payload;

  @BuiltValueField(wireName: r'message')
  String? get message;

  GenericResponseLoginResponse._();

  factory GenericResponseLoginResponse([void updates(GenericResponseLoginResponseBuilder b)]) = _$GenericResponseLoginResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenericResponseLoginResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenericResponseLoginResponse> get serializer => _$GenericResponseLoginResponseSerializer();
}

class _$GenericResponseLoginResponseSerializer implements PrimitiveSerializer<GenericResponseLoginResponse> {
  @override
  final Iterable<Type> types = const [GenericResponseLoginResponse, _$GenericResponseLoginResponse];

  @override
  final String wireName = r'GenericResponseLoginResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenericResponseLoginResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.payload != null) {
      yield r'payload';
      yield serializers.serialize(
        object.payload,
        specifiedType: const FullType(LoginResponse),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenericResponseLoginResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenericResponseLoginResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LoginResponse),
          ) as LoginResponse;
          result.payload.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenericResponseLoginResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenericResponseLoginResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

