import 'package:dart_coinselect/dart_coinselect.dart';
import 'package:dart_coinselect/src/enums/algorithms_enum.dart';
import 'package:dart_coinselect/src/models/models.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  group('Testing break algorithm', () {
    for (Fixture fixture in breakFixtures) {
      test(fixture.description, () {
        List<InputModel> inputModels =
            List<InputModel>.from(fixture.inputs.map((e) => e.toInputModel()));
        List<OutputModel> outputModels = List<OutputModel>.from(
            fixture.outputs.map((e) => e.toOutputModel()));

        final actual = coinSelect(inputModels, outputModels, fixture.feeRate,
            algo: AlgorithmsEnum.breakAlgo);

        expect(actual.isEqual(fixture.expected.toSelectionModel()), isTrue);
      });
    }
  });
}
