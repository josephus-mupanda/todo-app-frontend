// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_login_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericResponseLoginResponse extends GenericResponseLoginResponse {
  @override
  final LoginResponse? payload;
  @override
  final String? message;

  factory _$GenericResponseLoginResponse(
          [void Function(GenericResponseLoginResponseBuilder)? updates]) =>
      (GenericResponseLoginResponseBuilder()..update(updates))._build();

  _$GenericResponseLoginResponse._({this.payload, this.message}) : super._();
  @override
  GenericResponseLoginResponse rebuild(
          void Function(GenericResponseLoginResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericResponseLoginResponseBuilder toBuilder() =>
      GenericResponseLoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericResponseLoginResponse &&
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
    return (newBuiltValueToStringHelper(r'GenericResponseLoginResponse')
          ..add('payload', payload)
          ..add('message', message))
        .toString();
  }
}

class GenericResponseLoginResponseBuilder
    implements
        Builder<GenericResponseLoginResponse,
            GenericResponseLoginResponseBuilder> {
  _$GenericResponseLoginResponse? _$v;

  LoginResponseBuilder? _payload;
  LoginResponseBuilder get payload =>
      _$this._payload ??= LoginResponseBuilder();
  set payload(LoginResponseBuilder? payload) => _$this._payload = payload;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GenericResponseLoginResponseBuilder() {
    GenericResponseLoginResponse._defaults(this);
  }

  GenericResponseLoginResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _payload = $v.payload?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericResponseLoginResponse other) {
    _$v = other as _$GenericResponseLoginResponse;
  }

  @override
  void update(void Function(GenericResponseLoginResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericResponseLoginResponse build() => _build();

  _$GenericResponseLoginResponse _build() {
    _$GenericResponseLoginResponse _$result;
    try {
      _$result = _$v ??
          _$GenericResponseLoginResponse._(
            payload: _payload?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'payload';
        _payload?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GenericResponseLoginResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
