// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserType _$USER = const UserType._('USER');
const UserType _$ADMIN = const UserType._('ADMIN');

UserType _$valueOf(String name) {
  switch (name) {
    case 'USER':
      return _$USER;
    case 'ADMIN':
      return _$ADMIN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserType> _$values = BuiltSet<UserType>(const <UserType>[
  _$USER,
  _$ADMIN,
]);

class _$UserTypeMeta {
  const _$UserTypeMeta();
  UserType get USER => _$USER;
  UserType get ADMIN => _$ADMIN;
  UserType valueOf(String name) => _$valueOf(name);
  BuiltSet<UserType> get values => _$values;
}

abstract class _$UserTypeMixin {
  // ignore: non_constant_identifier_names
  _$UserTypeMeta get UserType => const _$UserTypeMeta();
}

Serializer<UserType> _$userTypeSerializer = _$UserTypeSerializer();

class _$UserTypeSerializer implements PrimitiveSerializer<UserType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'ADMIN': 'ADMIN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'ADMIN': 'ADMIN',
  };

  @override
  final Iterable<Type> types = const <Type>[UserType];
  @override
  final String wireName = 'UserType';

  @override
  Object serialize(Serializers serializers, UserType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
