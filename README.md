# dart_coinselect

An unspent transaction output (UTXO) selection module for bitcoin.

**WARNING:** Value units are in `satoshi`s, **not** Bitcoin.

## Installation

    dart pub add dart_coinselect

## Algorithms
Module | Algorithm | Re-orders UTXOs?
-|-|-
`null` | Blackjack, with Accumulative fallback | By Descending Value
`AlgorithmsEnum.accumulative` | Accumulative - accumulates inputs until the target value (+fees) is reached, skipping detrimental inputs | -
`AlgorithmsEnum.blackjack` | Blackjack - accumulates inputs until the target value (+fees) is matched, does not accumulate inputs that go over the target value (within a threshold) | -
`AlgorithmsEnum.breakAlgo` | Break - breaks the input values into equal denominations of `output` (as provided) | -
`AlgorithmsEnum.split` | Split - splits the input values evenly between all `outputs`, any provided `output` with `.value` remains unchanged | -


**Note:** Each algorithm will add a change output if the `input - output - fee` value difference is over a dust threshold.
This is calculated independently by `utils.finalize`, irrespective of the algorithm chosen, for the purposes of safety.

**Pro-tip:** if you want to send-all inputs to an output address, `AlgorithmsEnum.split` with a partial output (`.address` defined, no `.value`) can be used to send-all, while leaving an appropriate amount for the `fee`.

## Example

``` dart
import 'package:dart_coinselect/coinselect.dart';

const feeRate = 55;

void main() {
  List<InputModel> utxos = [
    InputModel(
        i: 0,
        txid:
            '61d520ccb74288c96bc1a2b20ea1c0d5a704776dd0164a396efec3ea7040349d',
        value: 10000),
  ];

  List<OutputModel> outputs = [
    OutputModel(address: '1EHNa6Q4Jz2uvNExL497mE43ikXhwF6kZm', value: 5000)
  ];

  final selection = coinSelect(utxos, outputs, feeRate);

  print(selection);
  // Output is '{"fee": "10560"}"
  // the accumulated fee is always returned for analysis

  // .inputs and .outputs will be null if no solution was found
  if (selection.inputs == null || selection.outputs == null) return;

  // Create raw transaciton and sign it...
}
```


## License [MIT](LICENSE)