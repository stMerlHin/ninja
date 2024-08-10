import 'package:flutter/foundation.dart';

class GroupedObject<G extends CanBeGrouped>
    implements CanBeGrouped, Iterable<G> {
  final Set<G> _objects = {};
  final dynamic id;
  GroupedObject({required this.id});

  List<G> get elements => _objects.toList();

  bool add(G element) {
    if (id != element.matchingId) {
      return false;
    }
    return _objects.add(element);
  }

  bool addAll(GroupedObject<G> object) {
    if (object.id != id) {
      return false;
    }
    _objects.addAll(object.elements);
    return true;
  }

  bool remove(G element) {
    return _objects.remove(element);
  }

  void removeWhere(bool Function(G element) test) {
    _objects.removeWhere(test);
  }

  void clear() {
    _objects.clear();
  }

  @override
  get matchingId => id;

  @override
  bool operator ==(Object other) {
    if (other is GroupedObject<G>) {
      return id == other.id && setEquals(_objects, other._objects);
    }
    return false;
  }

  @override
  int get hashCode => '${_objects.hashCode} $id $matchingId'.hashCode;

  @override
  int get length => _objects.length;

  @override
  bool any(bool Function(G element) test) {
    return _objects.any(test);
  }

  @override
  Iterable<R> cast<R>() {
    return _objects.cast();
  }

  @override
  bool contains(Object? element) {
    return _objects.contains(element);
  }

  @override
  G elementAt(int index) {
    return _objects.elementAt(index);
  }

  @override
  bool every(bool Function(G element) test) {
    return _objects.every(test);
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(G element) toElements) {
    return _objects.expand(toElements);
  }

  @override
  get first => _objects.first;

  @override
  G firstWhere(bool Function(G element) test, {G Function()? orElse}) {
    return _objects.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, G element) combine) {
    return _objects.fold(initialValue, combine);
  }

  @override
  Iterable<G> followedBy(Iterable<G> other) {
    return _objects.followedBy(other);
  }

  @override
  void forEach(void Function(G element) action) {
    for (var element in _objects) {
      action(element);
    }
  }

  @override
  bool get isEmpty => _objects.isEmpty;

  @override
  bool get isNotEmpty => _objects.isNotEmpty;

  @override
  Iterator<G> get iterator => _objects.iterator;

  @override
  String join([String separator = ""]) {
    return _objects.join(separator);
  }

  @override
  get last => _objects.last;

  @override
  G lastWhere(bool Function(G element) test, {G Function()? orElse}) {
    return _objects.lastWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> map<T>(T Function(G e) toElement) {
    return _objects.map(toElement);
  }

  @override
  G reduce(G Function(G value, G element) combine) {
    return _objects.reduce(combine);
  }

  @override
  get single => _objects.single;

  @override
  G singleWhere(bool Function(G element) test, {G Function()? orElse}) {
    return _objects.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<G> skip(int count) {
    return _objects.skip(count);
  }

  @override
  Iterable<G> skipWhile(bool Function(G value) test) {
    return _objects.skipWhile(test);
  }

  @override
  Iterable<G> take(int count) {
    return _objects.take(count);
  }

  @override
  Iterable<G> takeWhile(bool Function(G value) test) {
    return _objects.takeWhile(test);
  }

  @override
  List<G> toList({bool growable = true}) {
    return _objects.toList(growable: growable);
  }

  @override
  Set<G> toSet() {
    return _objects.toSet();
  }

  @override
  Iterable<G> where(bool Function(G element) test) {
    return _objects.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return _objects.whereType();
  }

  G operator [](int value) {
    return _objects.toList()[value];
  }

  @override
  String toString() {
    return toList().toString();
  }
}

abstract class CanBeGrouped {
  dynamic get matchingId;
}

mixin GroupedObjectList<G extends CanBeGrouped>
    implements Iterable<GroupedObject<G>> {
  final List<GroupedObject<G>> _objects = [];

  void _addGroup(GroupedObject<G> object) {
    final d = _objects.where((element) => element.id == object.id);
    if (d.isEmpty) {
      _objects.add(object);
      return;
    }
    d.first.addAll(object);
  }

  void addAll(List<CanBeGrouped> elements) {
    for (var element in elements) {
      add(element);
    }
  }

  void add(CanBeGrouped element, {bool checkExistence = false}) {
    if (checkExistence) {
      if (contains(element)) {
        return;
      }
    }
    if (element is GroupedObject<G>) {
      if (element.isEmpty) {
        return;
      }
      _addGroup(element);
      return;
    }
    if (element is G) {
      _addGroup(
        GroupedObject(id: element.matchingId)..add(element),
      );
    }
  }

  GroupedObject<G>? get(String matchingId) {
    final data = where((element) => element.matchingId == matchingId);
    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }

  bool remove(CanBeGrouped value) {
    if (value is G) {
      final d =
          _objects.where((element) => element.matchingId == value.matchingId);
      if (d.isNotEmpty) {
        d.first.remove(value);
        if (d.first.isEmpty) {
          _objects.remove(d.first);
        }
        return true;
      }
    }
    return _objects.remove(value);
  }

  GroupedObject<G> removeAt(int index) {
    return _objects.removeAt(index);
  }

  GroupedObject<G> removeLast() {
    return _objects.removeLast();
  }

  void removeWhere(bool Function(GroupedObject<G> element) test) {
    _objects.removeWhere(test);
  }

  void clear() {
    _objects.clear();
  }

  @override
  bool any(bool Function(GroupedObject<G> element) test) {
    return _objects.any(test);
  }

  @override
  Iterable<R> cast<R>() {
    return _objects.cast();
  }

  @override
  bool contains(Object? element) {
    if (element is G) {
      for (var ele in _objects) {
        if (ele.contains(element)) {
          return true;
        }
      }
      return false;
    }
    return _objects.contains(element);
  }

  @override
  GroupedObject<G> elementAt(int index) {
    return _objects.elementAt(index);
  }

  @override
  bool every(bool Function(GroupedObject<G> element) test) {
    return _objects.every(test);
  }

  @override
  Iterable<T> expand<T>(
      Iterable<T> Function(GroupedObject<G> element) toElements) {
    return _objects.expand(toElements);
  }

  @override
  get first => _objects.first;

  @override
  GroupedObject<G> firstWhere(bool Function(GroupedObject<G> element) test,
      {GroupedObject<G> Function()? orElse}) {
    return _objects.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue,
      T Function(T previousValue, GroupedObject<G> element) combine) {
    return _objects.fold(initialValue, combine);
  }

  @override
  Iterable<GroupedObject<G>> followedBy(Iterable<GroupedObject<G>> other) {
    return _objects.followedBy(other);
  }

  @override
  void forEach(void Function(GroupedObject<G> element) action) {
    for (var element in _objects) {
      action(element);
    }
  }

  @override
  bool get isEmpty => _objects.isEmpty;

  @override
  bool get isNotEmpty => _objects.isNotEmpty;

  @override
  Iterator<GroupedObject<G>> get iterator => _objects.iterator;

  @override
  String join([String separator = ""]) {
    return _objects.join(separator);
  }

  @override
  get last => _objects.last;

  @override
  GroupedObject<G> lastWhere(bool Function(GroupedObject<G> element) test,
      {GroupedObject<G> Function()? orElse}) {
    return _objects.lastWhere(test, orElse: orElse);
  }

  @override
  int get length => _objects.length;

  @override
  Iterable<T> map<T>(T Function(GroupedObject<G> e) toElement) {
    return _objects.map(toElement);
  }

  @override
  GroupedObject<G> reduce(
      GroupedObject<G> Function(
              GroupedObject<G> value, GroupedObject<G> element)
          combine) {
    return _objects.reduce(combine);
  }

  @override
  get single => _objects.single;

  @override
  GroupedObject<G> singleWhere(bool Function(GroupedObject<G> element) test,
      {GroupedObject<G> Function()? orElse}) {
    return _objects.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<GroupedObject<G>> skip(int count) {
    return _objects.skip(count);
  }

  @override
  Iterable<GroupedObject<G>> skipWhile(
      bool Function(GroupedObject<G> value) test) {
    return _objects.skipWhile(test);
  }

  @override
  Iterable<GroupedObject<G>> take(int count) {
    return _objects.take(count);
  }

  @override
  Iterable<GroupedObject<G>> takeWhile(
      bool Function(GroupedObject<G> value) test) {
    return _objects.takeWhile(test);
  }

  @override
  List<GroupedObject<G>> toList({bool growable = true}) {
    return _objects.toList(growable: growable);
  }

  @override
  Set<GroupedObject<G>> toSet() {
    return _objects.toSet();
  }

  @override
  Iterable<GroupedObject<G>> where(
      bool Function(GroupedObject<G> element) test) {
    return _objects.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return _objects.whereType();
  }

  GroupedObject<G> operator [](int value) {
    return _objects[value];
  }

// void operator []=(int index, GroupedObject<G> value) {
//   objects[index]= value;
// }
}
