// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Output extends Output {
  @override
  final String? id;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final UserType? userType;
  @override
  final bool? enabled;
  @override
  final BuiltSet<String>? roleIds;
  @override
  final BuiltSet<String>? tasksIds;

  factory _$Output([void Function(OutputBuilder)? updates]) =>
      (OutputBuilder()..update(updates))._build();

  _$Output._(
      {this.id,
      this.username,
      this.email,
      this.userType,
      this.enabled,
      this.roleIds,
      this.tasksIds})
      : super._();
  @override
  Output rebuild(void Function(OutputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OutputBuilder toBuilder() => OutputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Output &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        userType == other.userType &&
        enabled == other.enabled &&
        roleIds == other.roleIds &&
        tasksIds == other.tasksIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, userType.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, roleIds.hashCode);
    _$hash = $jc(_$hash, tasksIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Output')
          ..add('id', id)
          ..add('username', username)
          ..add('email', email)
          ..add('userType', userType)
          ..add('enabled', enabled)
          ..add('roleIds', roleIds)
          ..add('tasksIds', tasksIds))
        .toString();
  }
}

class OutputBuilder implements Builder<Output, OutputBuilder> {
  _$Output? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  UserType? _userType;
  UserType? get userType => _$this._userType;
  set userType(UserType? userType) => _$this._userType = userType;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  SetBuilder<String>? _roleIds;
  SetBuilder<String> get roleIds => _$this._roleIds ??= SetBuilder<String>();
  set roleIds(SetBuilder<String>? roleIds) => _$this._roleIds = roleIds;

  SetBuilder<String>? _tasksIds;
  SetBuilder<String> get tasksIds => _$this._tasksIds ??= SetBuilder<String>();
  set tasksIds(SetBuilder<String>? tasksIds) => _$this._tasksIds = tasksIds;

  OutputBuilder() {
    Output._defaults(this);
  }

  OutputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _email = $v.email;
      _userType = $v.userType;
      _enabled = $v.enabled;
      _roleIds = $v.roleIds?.toBuilder();
      _tasksIds = $v.tasksIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Output other) {
    _$v = other as _$Output;
  }

  @override
  void update(void Function(OutputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Output build() => _build();

  _$Output _build() {
    _$Output _$result;
    try {
      _$result = _$v ??
          _$Output._(
            id: id,
            username: username,
            email: email,
            userType: userType,
            enabled: enabled,
            roleIds: _roleIds?.build(),
            tasksIds: _tasksIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roleIds';
        _roleIds?.build();
        _$failedField = 'tasksIds';
        _tasksIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Output', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
