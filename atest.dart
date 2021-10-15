import './test/fixtures/fixtures.dart';
void main() {
  final fixture = Fixture.fromJSON({
    "description": "1 to 3",
    "feeRate": 10,
    "inputs": [18000],
    "outputs": [<String, dynamic>{}, <String, dynamic>{}, <String, dynamic>{}],
    "expected": {
      "inputs": [
        {"value": 18000}
      ],
      "outputs": [
        {"value": 5133},
        {"value": 5133},
        {"value": 5133}
      ],
      "fee": 2601
    }
  });

  print(fixture);
}