import 'package:dart_coinselect/src/abstracts/io_model_abstract.dart';
import 'package:dart_coinselect/src/constants.dart';
import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';

int inputBytes(InputModel input) {
  return txInputBase +
      (input.script != null ? input.script!.lengthInBytes : txInputPubKeyHash);
}

int outputBytes(OutputModel output) {
  return txOutputBase +
      (output.script != null
          ? output.script!.lengthInBytes
          : txOutputPubKeyHash);
}

int dustThreshold(/*OutputModel output, */ int feeRate) {
  return inputBytes(InputModel(i: 0)) * feeRate;
}

int transactionBytes(List<InputModel> inputs, List<OutputModel> outputs) {
  int inputByte =
      inputs.fold(0, (prevValue, input) => prevValue + inputBytes(input));
  int outputByte =
      outputs.fold(0, (prevValue, output) => prevValue + outputBytes(output));
  return txEmptySize + inputByte + outputByte;
}

int? sumOrNull(List<IOModelAbstract> arr) {
  return arr.fold(
      0,
      (previousValue, element) =>
          element.value == null ? null : previousValue! + element.value!);
}

int? sumForgiving(List<IOModelAbstract> arr) {
  return arr.fold(
      0,
      (previousValue, element) =>
          (previousValue ?? 0) + (element.value != null ? element.value! : 0));
}

SelectionModel finalize(
    List<InputModel> inputs, List<OutputModel> outputs, int feeRate) {
  final int bytesAccum = transactionBytes(inputs, outputs);
  final int feeAfterExtraOutput = feeRate * (bytesAccum + txBlankOutput);

  int? inputSum = sumOrNull(inputs);
  int? outputSum = sumOrNull(outputs);

  int remainderAfterExtraOutput;
  int fee = 0;

  if (inputSum != null && outputSum != null) {
    remainderAfterExtraOutput = inputSum - (outputSum + feeAfterExtraOutput);
    fee = inputSum - outputSum;
  } else {
    return SelectionModel(feeRate * bytesAccum);
  }

  if (remainderAfterExtraOutput > dustThreshold(/*OutputModel(), */ feeRate)) {
    outputs.add(OutputModel(value: remainderAfterExtraOutput));

    inputSum = sumOrNull(inputs);
    outputSum = sumOrNull(outputs);
  }

  if (inputSum != null && outputSum != null) {
    fee = inputSum - outputSum;
  }

  return SelectionModel(fee, inputs: inputs, outputs: outputs);
}
