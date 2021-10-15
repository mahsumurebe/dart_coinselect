import 'package:dart_coinselect/dart_coinselect.dart';
import 'package:dart_coinselect/src/models/models.dart';
import 'package:dart_coinselect/src/models/selection_model.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  group('Testing blackjack algorithm', () {
    for (Fixture fixture in coinSelectFixtures) {
      test(fixture.description, () {
        List<InputModel> inputModels =
            List<InputModel>.from(fixture.inputs.map((e) => e.toInputModel()));
        List<OutputModel> outputModels = List<OutputModel>.from(
            fixture.outputs.map((e) => e.toOutputModel()));

        final SelectionModel actual =
            coinSelect(inputModels, outputModels, fixture.feeRate);

        final SelectionModel expected = fixture.expected.toSelectionModel();

        expect(actual.isEqual(expected), isTrue);
      });
    }
  });
}
