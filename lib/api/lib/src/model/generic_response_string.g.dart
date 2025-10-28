// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_string.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericResponseString extends GenericResponseString {
  @override
  final String? payload;
  @override
  final String? message;

  factory _$GenericResponseString(
          [void Function(GenericResponseStringBuilder)? updates]) =>
      (GenericResponseStringBuilder()..update(updates))._build();

  _$GenericResponseString._({this.payload, this.message}) : super._();
  @override
  GenericResponseString rebuild(
          void Function(GenericResponseStringBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericResponseStringBuilder toBuilder() =>
      GenericResponseStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericResponseString &&
        payload == other.payload &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, payload.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenericResponseString')
          ..add('payload', payload)
          ..add('message', message))
        .toString();
  }
}

class GenericResponseStringBuilder
    implements Builder<GenericResponseString, GenericResponseStringBuilder> {
  _$GenericResponseString? _$v;

  String? _payload;
  String? get payload => _$this._payload;
  set payload(String? payload) => _$this._payload = payload;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GenericResponseStringBuilder() {
    GenericResponseString._defaults(this);
  }

  GenericResponseStringBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _payload = $v.payload;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericResponseString other) {
    _$v = other as _$GenericResponseString;
  }

  @override
  void update(void Function(GenericResponseStringBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericResponseString build() => _build();

  _$GenericResponseString _build() {
    final _$result = _$v ??
        _$GenericResponseString._(
          payload: payload,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
