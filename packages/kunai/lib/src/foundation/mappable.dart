mixin Mappable {
  ///{@template recycle_shared.model.IdentifiedObject.toMap}
  ///
  /// Save this instance to map.
  ///
  /// [store] should be set to true if the map is about to be passed to firestore.
  /// Defaults to true.
  ///
  /// {@endtemplate}
  Map<String, dynamic> toMap([bool store = true]);
}
