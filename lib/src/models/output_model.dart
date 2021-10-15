import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_coinselect/src/abstracts/io_model_abstract.dart';

// Output Model
class OutputModel extends IOModelAbstract {
  @override
  ByteData? script;

  @override
  int? value;

  @override
  String? address;

  OutputModel({this.value, this.script, this.address});

  OutputModel.from(OutputModel other) {
    script = other.script;
    value = other.value;
    address = other.address;
  }

  // Compares two OutputModels. Checks equality status
  isEqual(OutputModel other) {
    bool scriptOk = script == null && other.script == null;
    if (script != null && other.script != null) {
      scriptOk = hex.encode(Uint8List.view(script!.buffer)) ==
          hex.encode(Uint8List.view(other.script!.buffer));
    }

    return ((scriptOk && value == other.value && address == other.address));
  }

  @override
  String toString() {
    List<String> str = [];
    if (address != null) str.add('"address": "$address"');
    if (value != null) str.add('"value": $value');
    if (script != null) str.add('"script": "${script.toString()}"');

    return "{${str.join(",")}}";
  }
}
