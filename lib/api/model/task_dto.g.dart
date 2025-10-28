// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TaskDTO extends TaskDTO {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final bool? completed;
  @override
  final String? userId;

  factory _$TaskDTO([void Function(TaskDTOBuilder)? updates]) =>
      (TaskDTOBuilder()..update(updates))._build();

  _$TaskDTO._({this.id, this.title, this.completed, this.userId}) : super._();
  @override
  TaskDTO rebuild(void Function(TaskDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskDTOBuilder toBuilder() => TaskDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskDTO &&
        id == other.id &&
        title == other.title &&
        completed == other.completed &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TaskDTO')
          ..add('id', id)
          ..add('title', title)
          ..add('completed', completed)
          ..add('userId', userId))
        .toString();
  }
}

class TaskDTOBuilder implements Builder<TaskDTO, TaskDTOBuilder> {
  _$TaskDTO? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  bool? _completed;
  bool? get completed => _$this._completed;
  set completed(bool? completed) => _$this._completed = completed;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  TaskDTOBuilder() {
    TaskDTO._defaults(this);
  }

  TaskDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _completed = $v.completed;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskDTO other) {
    _$v = other as _$TaskDTO;
  }

  @override
  void update(void Function(TaskDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TaskDTO build() => _build();

  _$TaskDTO _build() {
    final _$result = _$v ??
        _$TaskDTO._(
          id: id,
          title: title,
          completed: completed,
          userId: userId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
