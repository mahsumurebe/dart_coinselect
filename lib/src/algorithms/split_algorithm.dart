import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:dart_coinselect/src/utils.dart' as utils;

// split utxos between each output, ignores outputs with .value defined
SelectionModel splitAlgorithm(
    List<InputModel> utxos, List<OutputModel> outputs, int feeRate) {
  int bytesAccum = utils.transactionBytes(utxos, outputs);
  int fee = feeRate * bytesAccum;
  if (outputs.isEmpty) {
    return SelectionModel(fee);
  }

  int? inAccum = utils.sumOrNull(utxos);
  int? outAccum = utils.sumForgiving(outputs);
  int? remaining;
  if (inAccum != null && outAccum != null) {
    remaining = inAccum - outAccum - fee;
  }

  if (remaining == null || remaining < 0) {
    return SelectionModel(fee);
  }

  int unspecified = outputs.fold(0, (a, x) {
    return a + (x.value == null ? 1 : 0);
  });

  if (remaining == 0 && unspecified == 0) {
    return utils.finalize(utxos, outputs, feeRate);
  }

  int splitOutputsCount = outputs.fold(0, (a, x) {
    return a + (x.value == null || x.value == 0 ? 1 : 0);
  });
  int splitValue = (remaining / splitOutputsCount).floor();

  // ensure every output is either user defined, or over the threshold
  if (!outputs.every((x) =>
      x.value != null || (splitValue > utils.dustThreshold(/*x, */ feeRate)))) {
    return SelectionModel(fee);
  }

  // assign splitValue to outputs not user defined
  final mapped = outputs.map((x) {
    if (x.value != null) return x;

    // not user defined, but still copy over any non-value fields
    OutputModel y = OutputModel.from(x);
    y.value = splitValue;
    return y;
  });

  outputs = List.from(mapped);

  return utils.finalize(utxos, outputs, feeRate);
}
