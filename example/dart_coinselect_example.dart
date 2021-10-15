import 'package:dart_coinselect/dart_coinselect.dart';

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
  // Output is  'Instance of 'SelectionModel': {"fee": "10560}"
  // Because inputs value is lower than outputs value + fee
  // the accumulated fee is always returned for analysis

  // .inputs and .outputs will be null if no solution was found
  if (selection.inputs == null || selection.outputs == null) return;

  // Create raw transaciton and sign it...
}
