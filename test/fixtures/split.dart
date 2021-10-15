import 'utils/base.dart';

List<Fixture> splitFixtures = [
  Fixture.fromJSON({
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
  }),
  Fixture.fromJSON({
    "description": "5 to 2",
    "feeRate": 10,
    "inputs": [10000, 10000, 10000, 10000, 10000],
    "outputs": [<String, dynamic>{}, <String, dynamic>{}],
    "expected": {
      "inputs": [
        {"value": 10000},
        {"value": 10000},
        {"value": 10000},
        {"value": 10000},
        {"value": 10000}
      ],
      "outputs": [
        {"value": 20910},
        {"value": 20910}
      ],
      "fee": 8180
    }
  }),
  Fixture.fromJSON({
    "description": "3 to 1",
    "feeRate": 10,
    "inputs": [10000, 10000, 10000],
    "outputs": [<String, dynamic>{}],
    "expected": {
      "inputs": [
        {"value": 10000},
        {"value": 10000},
        {"value": 10000}
      ],
      "outputs": [
        {"value": 25120}
      ],
      "fee": 4880
    }
  }),
  Fixture.fromJSON({
    "description": "3 to 3 (1 output pre-defined)",
    "feeRate": 10,
    "inputs": [10000, 10000, 10000],
    "outputs": [
      {"address": "foobar", "value": 12000},
      {"address": "fizzbuzz"},
      <String, dynamic>{}
    ],
    "expected": {
      "inputs": [
        {"value": 10000},
        {"value": 10000},
        {"value": 10000}
      ],
      "outputs": [
        {"address": "foobar", "value": 12000},
        {"address": "fizzbuzz", "value": 6220},
        {"value": 6220}
      ],
      "fee": 5560
    }
  }),
  Fixture.fromJSON({
    "description": "2 to 0 (no result)",
    "feeRate": 10,
    "inputs": [10000, 10000],
    "outputs": [],
    "expected": {"fee": 3060}
  }),
  Fixture.fromJSON({
    "description": "0 to 2 (no result)",
    "feeRate": 10,
    "inputs": [],
    "outputs": [<String, dynamic>{}, <String, dynamic>{}],
    "expected": {"fee": 780}
  }),
  Fixture.fromJSON({
    "description": "1 to 2, output is dust (no result)",
    "feeRate": 10,
    "inputs": [2000],
    "outputs": [<String, dynamic>{}],
    "expected": {"fee": 1920}
  }),
];
