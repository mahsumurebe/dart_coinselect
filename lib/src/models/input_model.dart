import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_coinselect/src/abstracts/io_model_abstract.dart';

// Input Model
class InputModel extends IOModelAbstract {
  int i;
  String? txid;

  @override
  ByteData? script;

  @override
  int? value;

  @override
  String? address;

  InputModel(
      {required this.i, this.txid, this.value, this.script, this.address});

  // Compares two InputModels. Checks equality status
  isEqual(InputModel other) {
    bool scriptOk = script == null && other.script == null;
    if (script != null && other.script != null) {
      final hex1 = hex.encode(Uint8List.view(script!.buffer));
      final hex2 = hex.encode(Uint8List.view(other.script!.buffer));
      scriptOk = hex1 == hex2;
    }
    return i == other.i &&
        scriptOk &&
        value == other.value &&
        address == other.address;
  }

  @override
  String toString() {
    List<String> str = ['"i": "$i"'];
    if (txid != null) str.add('"txid": "$txid"');
    if (address != null) str.add('"address": "$address"');
    if (value != null) str.add('"value": $value');
    if (script != null) str.add('"script": "${script.toString()}"');

    return "{${str.join(",")}}";
  }
}
