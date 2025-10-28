// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericErrorResponse extends GenericErrorResponse {
  @override
  final int? statusCode;
  @override
  final String? error;
  @override
  final String? message;
  @override
  final DateTime? timestamp;
  @override
  final String? path;

  factory _$GenericErrorResponse(
          [void Function(GenericErrorResponseBuilder)? updates]) =>
      (GenericErrorResponseBuilder()..update(updates))._build();

  _$GenericErrorResponse._(
      {this.statusCode, this.error, this.message, this.timestamp, this.path})
      : super._();
  @override
  GenericErrorResponse rebuild(
          void Function(GenericErrorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericErrorResponseBuilder toBuilder() =>
      GenericErrorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericErrorResponse &&
        statusCode == other.statusCode &&
        error == other.error &&
        message == other.message &&
        timestamp == other.timestamp &&
        path == other.path;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statusCode.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenericErrorResponse')
          ..add('statusCode', statusCode)
          ..add('error', error)
          ..add('message', message)
          ..add('timestamp', timestamp)
          ..add('path', path))
        .toString();
  }
}

class GenericErrorResponseBuilder
    implements Builder<GenericErrorResponse, GenericErrorResponseBuilder> {
  _$GenericErrorResponse? _$v;

  int? _statusCode;
  int? get statusCode => _$this._statusCode;
  set statusCode(int? statusCode) => _$this._statusCode = statusCode;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  GenericErrorResponseBuilder() {
    GenericErrorResponse._defaults(this);
  }

  GenericErrorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statusCode = $v.statusCode;
      _error = $v.error;
      _message = $v.message;
      _timestamp = $v.timestamp;
      _path = $v.path;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericErrorResponse other) {
    _$v = other as _$GenericErrorResponse;
  }

  @override
  void update(void Function(GenericErrorResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericErrorResponse build() => _build();

  _$GenericErrorResponse _build() {
    final _$result = _$v ??
        _$GenericErrorResponse._(
          statusCode: statusCode,
          error: error,
          message: message,
          timestamp: timestamp,
          path: path,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
