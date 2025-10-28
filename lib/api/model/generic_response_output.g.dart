// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_output.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericResponseOutput extends GenericResponseOutput {
  @override
  final Output? payload;
  @override
  final String? message;

  factory _$GenericResponseOutput(
          [void Function(GenericResponseOutputBuilder)? updates]) =>
      (GenericResponseOutputBuilder()..update(updates))._build();

  _$GenericResponseOutput._({this.payload, this.message}) : super._();
  @override
  GenericResponseOutput rebuild(
          void Function(GenericResponseOutputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericResponseOutputBuilder toBuilder() =>
      GenericResponseOutputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericResponseOutput &&
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
    return (newBuiltValueToStringHelper(r'GenericResponseOutput')
          ..add('payload', payload)
          ..add('message', message))
        .toString();
  }
}

class GenericResponseOutputBuilder
    implements Builder<GenericResponseOutput, GenericResponseOutputBuilder> {
  _$GenericResponseOutput? _$v;

  OutputBuilder? _payload;
  OutputBuilder get payload => _$this._payload ??= OutputBuilder();
  set payload(OutputBuilder? payload) => _$this._payload = payload;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GenericResponseOutputBuilder() {
    GenericResponseOutput._defaults(this);
  }

  GenericResponseOutputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _payload = $v.payload?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericResponseOutput other) {
    _$v = other as _$GenericResponseOutput;
  }

  @override
  void update(void Function(GenericResponseOutputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericResponseOutput build() => _build();

  _$GenericResponseOutput _build() {
    _$GenericResponseOutput _$result;
    try {
      _$result = _$v ??
          _$GenericResponseOutput._(
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
            r'GenericResponseOutput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
