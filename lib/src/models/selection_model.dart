import 'package:dart_coinselect/src/models/models.dart';

class SelectionModel {
  int fee;

  List<InputModel>? inputs;
  List<OutputModel>? outputs;

  SelectionModel(this.fee, {this.inputs, this.outputs});

  isEqual(SelectionModel other) {
    bool inputOk = inputs == null && other.inputs == null;
    bool outputOk = outputs == null && other.outputs == null;

    if (inputs != null && other.inputs != null) {
      inputOk = inputs!.every((element) {
        return other.inputs!.any((element2) {
          return element.isEqual(element2);
        });
      });
    }
    if (outputs != null && other.outputs != null) {
      outputOk = outputs!.every((element) {
        return other.outputs!.any((element2) {
          return element.isEqual(element2);
        });
      });
    }
    return fee == other.fee && inputOk && outputOk;
  }

  @override
  String toString() {
    List<String> str = ['"fee": "$fee"'];
    if (inputs != null) str.add('"inputs": ${inputs.toString()}');
    if (outputs != null) str.add('"outputs": ${outputs.toString()}');

    return "{${str.join(",")}}";
  }
}
