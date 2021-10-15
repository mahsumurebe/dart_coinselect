import 'package:dart_coinselect/dart_coinselect.dart';
import 'package:dart_coinselect/src/enums/algorithms_enum.dart';
import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  group('Testing accumulative algorithm', () {
    for (Fixture fixture in accumulativeFixtures) {
      test(fixture.description, () {
        List<InputModel> inputModels =
            List<InputModel>.from(fixture.inputs.map((e) => e.toInputModel()));
        List<OutputModel> outputModels = List<OutputModel>.from(
            fixture.outputs.map((e) => e.toOutputModel()));

        final SelectionModel actual = coinSelect(
            inputModels, outputModels, fixture.feeRate,
            algo: AlgorithmsEnum.accumulative);

        final SelectionModel expected = fixture.expected.toSelectionModel();

        expect(actual.isEqual(expected), isTrue);
      });
    }
  });
}
