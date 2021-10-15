import 'package:dart_coinselect/src/algorithms/algorithms.dart';
import 'package:dart_coinselect/src/enums/algorithms_enum.dart';
import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:dart_coinselect/src/utils.dart' as utils;

export 'algorithms/blackjack_algorithm.dart';

int _utxoScore(InputModel input, int feeRate) {
  if (input.value == null) {
    return 0;
  }
  return input.value! - (feeRate * utils.inputBytes(input));
}

SelectionModel coinSelect(
    List<InputModel> utxos, List<OutputModel> outputs, int feeRate,
    {AlgorithmsEnum? algo}) {
  switch (algo) {
    case AlgorithmsEnum.accumulative:
      return accumulativeAlgorithm(utxos, outputs, feeRate);
    case AlgorithmsEnum.blackjack:
      return blackjackAlgorithm(utxos, outputs, feeRate);
    case AlgorithmsEnum.breakAlgo:
      if (outputs.length > 1) {
        throw ArgumentError(
            'Output parameter must contain at most one element.');
      }

      return breakAlgorithm(utxos, outputs.first, feeRate);
    case AlgorithmsEnum.split:
      return splitAlgorithm(utxos, outputs, feeRate);
    default:
      {
        utxos.sort((a, b) => _utxoScore(b, feeRate) - _utxoScore(a, feeRate));

        SelectionModel base = blackjackAlgorithm(utxos, outputs, feeRate);
        if (base.inputs != null) {
          return base;
        }

        return accumulativeAlgorithm(utxos, outputs, feeRate);
      }
  }
}
