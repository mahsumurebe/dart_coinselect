import 'dart:typed_data';

import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';

import 'mappers.dart';

class FixtureOutput {
  final int? value;
  final String? address;
  final ByteData? script;

  FixtureOutput({this.value, this.script, this.address});

  factory FixtureOutput.fromJSON(Map<String, dynamic> obj) {
    ByteData? script;

    if (obj.containsKey('script') && obj['script'] is Object) {
      Map<String, dynamic> tmpScript = obj['script'];
      if (tmpScript.containsKey('length')) {
        script = ByteData(tmpScript['length']);
      }
    }

    return FixtureOutput(
        value: obj['value'] as int?,
        address: obj['address'] as String?,
        script: script);
  }

  OutputModel toOutputModel() {
    return OutputModel(value: value, script: script, address: address);
  }
}

class FixtureInput {
  final int i;
  final int value;
  final ByteData? script;
  final String? address;

  FixtureInput(
      {required this.value, required this.i, this.script, this.address});

  factory FixtureInput.fromJSON(Map<String, dynamic> obj) {
    ByteData? script;

    if (obj.containsKey('script') && obj['script'] is Object) {
      Map<String, dynamic> tmpScript = obj['script'];
      if (tmpScript.containsKey('length')) {
        script = ByteData(tmpScript['length']);
      }
    }

    return FixtureInput(
        value: obj['value'] as int,
        i: obj['i'] as int,
        address: obj['address'] as String?,
        script: script);
  }

  toInputModel() {
    return InputModel(i: i, value: value, script: script, address: address);
  }
}

class FixtureExpectOutput {
  final int value;
  final ByteData? script;
  final String? address;

  FixtureExpectOutput({required this.value, this.script, this.address});

  factory FixtureExpectOutput.fromJSON(Map<String, dynamic> obj) {
    ByteData? script;

    if (obj.containsKey('script') && obj['script'] is Object) {
      Map<String, dynamic> tmpScript = obj['script'];
      if (tmpScript.containsKey('length')) {
        script = ByteData(tmpScript['length']);
      }
    }

    return FixtureExpectOutput(
        value: obj['value'] as int,
        script: script,
        address: obj['address'] as String?);
  }

  toOutputModel() {
    return OutputModel(value: value, address: address, script: script);
  }
}

class FixtureExpectInput {
  final int value;
  final int i;
  final String? address;
  final ByteData? script;

  FixtureExpectInput(
      {required this.i, required this.value, this.address, this.script});

  factory FixtureExpectInput.fromJSON(Map<String, dynamic> obj) {
    ByteData? script;

    if (obj.containsKey('script') && obj['script'] is Object) {
      Map<String, dynamic> tmpScript = obj['script'];
      if (tmpScript.containsKey('length')) {
        script = ByteData(tmpScript['length']);
      }
    }

    return FixtureExpectInput(
      value: obj['value'] as int,
      i: obj['i'] as int,
      address: obj['address'] as String?,
      script: script,
    );
  }

  toInputModel() {
    return InputModel(i: i, script: script, address: address, value: value);
  }
}

class FixtureExpected {
  final List<FixtureExpectInput>? inputs;
  final List<FixtureExpectOutput>? outputs;
  final int fee;

  FixtureExpected({required this.fee, this.inputs, this.outputs});

  factory FixtureExpected.fromJSON(Map<String, dynamic> obj) {
    List<FixtureExpectInput>? inputs;
    List<FixtureExpectOutput>? outputs;
    if (obj.containsKey('inputs')) {
      inputs = toFixtureExpectInput(obj['inputs']);
    }
    if (obj.containsKey('outputs')) {
      outputs = toFixtureExpectOutput(obj['outputs']);
    }
    int fee = obj['fee'] as int;

    return FixtureExpected(inputs: inputs, outputs: outputs, fee: fee);
  }

  toSelectionModel() {
    List<InputModel>? _inputs;
    List<OutputModel>? _outputs;

    if (inputs != null) {
      _inputs =
          List<InputModel>.from((inputs ?? []).map((i) => i.toInputModel()));
    }
    if (outputs != null) {
      _outputs =
          List<OutputModel>.from((outputs ?? []).map((o) => o.toOutputModel()));
    }
    return SelectionModel(fee, inputs: _inputs, outputs: _outputs);
  }
}

class Fixture {
  final String description;

  final int feeRate;

  final List<FixtureInput> inputs;

  final List<FixtureOutput> outputs;

  final FixtureExpected expected;

  Fixture(
      {required this.description,
      required this.feeRate,
      required this.inputs,
      required this.outputs,
      required this.expected});

  factory Fixture.fromJSON(Map<String, dynamic> obj) {
    return Fixture(
        description: obj['description'] as String,
        feeRate: obj['feeRate'] as int,
        inputs: toFixtureInput(obj['inputs']),
        outputs: toFixtureOutput(obj['outputs']),
        expected: FixtureExpected.fromJSON(obj['expected']));
  }
}
