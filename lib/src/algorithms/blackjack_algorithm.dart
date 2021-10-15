import 'package:dart_coinselect/src/models/input_model.dart';
import 'package:dart_coinselect/src/models/output_model.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:dart_coinselect/src/utils.dart' as utils;

// only add inputs if they don't bust the target value (aka, exact match)
// worst-case: O(n)
SelectionModel blackjackAlgorithm(
    List<InputModel> utxos, List<OutputModel> outputs, int feeRate) {
  int bytesAccum = utils.transactionBytes(<InputModel>[], outputs);

  int inAccum = 0;
  List<InputModel> inputs = [];
  final int? outAccum = utils.sumOrNull(outputs);
  final threshold = utils.dustThreshold(/*OutputModel(), */ feeRate);

  for (var i = 0; i < utxos.length; ++i) {
    var input = utxos[i];
    var inputBytes = utils.inputBytes(input);
    var fee = feeRate * (bytesAccum + inputBytes);

    // would it waste value?
    if (input.value != null && outAccum != null) {
      if ((inAccum + input.value!) > (outAccum + fee + threshold)) {
        continue;
      }
    }

    bytesAccum += inputBytes;
    inAccum += input.value!;
    inputs.add(input);

    // go again?
    if (outAccum != null && inAccum < outAccum + fee) {
      continue;
    }

    return utils.finalize(inputs, outputs, feeRate);
  }

  return SelectionModel(feeRate * bytesAccum);
}
