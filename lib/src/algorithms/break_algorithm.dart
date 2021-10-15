import 'package:dart_coinselect/src/models/input_model.dart';
import 'package:dart_coinselect/src/models/output_model.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:dart_coinselect/src/utils.dart' as utils;

// break utxos into the maximum number of 'output' possible
SelectionModel breakAlgorithm(List<InputModel> utxos, OutputModel output, int feeRate) {
  int bytesAccum = utils.transactionBytes(utxos, <OutputModel>[]);
  int? inAccum = utils.sumOrNull(utxos);
  if (output.value == null || inAccum == null) {
    return SelectionModel(feeRate * bytesAccum);
  }

  int outputBytes = utils.outputBytes(output);
  int outAccum = 0;
  List<OutputModel> outputs = [];

  while (true) {
    int fee = feeRate * (bytesAccum + outputBytes);

    // did we bust?
    if (inAccum < (outAccum + fee + output.value!)) {
      // premature?
      if (outAccum == 0) {
        return SelectionModel(fee);
      }

      break;
    }

    bytesAccum += outputBytes;
    outAccum += output.value!;
    outputs.add(output);
  }

  return utils.finalize(utxos, outputs, feeRate);
}
