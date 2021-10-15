import '../fixtures.dart';

List<FixtureInput> toFixtureInput(dynamic obj) {
  if (obj is int) {
    obj = [obj];
  }
  final objMapped = List.from(obj).asMap().entries.map((entry) {
    Map<String, dynamic> json = {};

    if (entry.value is int) {
      json['i'] = entry.key;
      json['value'] = entry.value;
    } else if (entry.value is Map<String, dynamic>) {
      json = entry.value;
      if (!json.containsKey('i')) {
        json['i'] = entry.key;
      }
    } else {
      throw ArgumentError(
          'Input value can only be of type int or Map<String, dynamic>.');
    }
    return FixtureInput.fromJSON(json);
  });

  return List<FixtureInput>.from(objMapped);
}

List<FixtureOutput> toFixtureOutput(dynamic obj) {
  if (obj is int) {
    obj = [obj];
  }

  final objMapped = List.from(obj).asMap().entries.map((entry) {
    Map<String, dynamic> json = {};

    if (entry.value is int) {
      json['value'] = entry.value;
    } else if (entry.value is Map<String, dynamic>) {
      json = Map.from(entry.value);
    } else if (entry.value != null) {
      throw ArgumentError(
          'Output value can only be of type int or Map<String, dynamic>.');
    }
    return FixtureOutput.fromJSON(json);
  });

  return List<FixtureOutput>.from(objMapped);
}

List<FixtureExpectInput> toFixtureExpectInput(dynamic obj) {
  final objMapped = List.from(obj).asMap().entries.map((entry) {
    if (entry.value is Map<String, dynamic>) {
      final Map<String, dynamic> tmp = entry.value;
      if (!tmp.containsKey('i')) {
        tmp['i'] = entry.key;
      }

      return FixtureExpectInput.fromJSON(tmp);
    } else {
      throw ArgumentError('Expected inputs must be Map<String, dynamic> type.');
    }
  });
  return List.from(objMapped);
}

List<FixtureExpectOutput> toFixtureExpectOutput(dynamic obj) {
  final o = List<FixtureExpectOutput>.from(List.from(obj).map((e) {
    return FixtureExpectOutput.fromJSON(e);
  }));
  return o;
}
