//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:todo_api_client/src/model/output.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generic_response_output.g.dart';

/// GenericResponseOutput
///
/// Properties:
/// * [payload] 
/// * [message] 
@BuiltValue()
abstract class GenericResponseOutput implements Built<GenericResponseOutput, GenericResponseOutputBuilder> {
  @BuiltValueField(wireName: r'payload')
  Output? get payload;

  @BuiltValueField(wireName: r'message')
  String? get message;

  GenericResponseOutput._();

  factory GenericResponseOutput([void updates(GenericResponseOutputBuilder b)]) = _$GenericResponseOutput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenericResponseOutputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenericResponseOutput> get serializer => _$GenericResponseOutputSerializer();
}

class _$GenericResponseOutputSerializer implements PrimitiveSerializer<GenericResponseOutput> {
  @override
  final Iterable<Type> types = const [GenericResponseOutput, _$GenericResponseOutput];

  @override
  final String wireName = r'GenericResponseOutput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenericResponseOutput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.payload != null) {
      yield r'payload';
      yield serializers.serialize(
        object.payload,
        specifiedType: const FullType(Output),
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
    GenericResponseOutput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenericResponseOutputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Output),
          ) as Output;
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
  GenericResponseOutput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenericResponseOutputBuilder();
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

