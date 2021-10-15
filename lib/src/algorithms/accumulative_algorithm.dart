import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:dart_coinselect/src/utils.dart' as utils;

// only add inputs if they don't bust the target value (aka, exact match)
// worst-case: O(n)
SelectionModel accumulativeAlgorithm(
    List<InputModel> utxos, List<OutputModel> outputs, int feeRate) {
  int bytesAccum = utils.transactionBytes(<InputModel>[], outputs);

  int inAccum = 0;
  List<InputModel> inputs = [];
  final int? outAccum = utils.sumOrNull(outputs);

  for (var i = 0; i < utxos.length; ++i) {
    var utxo = utxos[i];
    var utxoBytes = utils.inputBytes(utxo);
    var utxoFee = feeRate * utxoBytes;

    // skip detrimental input
    if (utxo.value != null && utxoFee > utxo.value!) {
      if (i == utxos.length - 1) {
        return SelectionModel(feeRate * (bytesAccum + utxoBytes));
      }
      continue;
    }

    bytesAccum += utxoBytes;
    inAccum += utxo.value!;
    inputs.add(utxo);

    int fee = feeRate * bytesAccum;

    // go again?
    if (outAccum != null && inAccum < outAccum + fee) continue;

    return utils.finalize(inputs, outputs, feeRate);
  }

  return SelectionModel(feeRate * bytesAccum);
}
