import 'utils/base.dart';

List<Fixture> breakFixtures = [
  Fixture.fromJSON({
    "description": "1:1, no remainder",
    "feeRate": 10,
    "inputs": [11920],
    "outputs": [10000],
    "expected": {
      "inputs": [
        {"value": 11920}
      ],
      "outputs": [
        {"value": 10000}
      ],
      "fee": 1920
    }
  }),
  Fixture.fromJSON({
    "description": "1:1",
    "feeRate": 10,
    "inputs": [12000],
    "outputs": [
      {"address": "woop", "value": 10000}
    ],
    "expected": {
      "fee": 2000,
      "inputs": [
        {"value": 12000}
      ],
      "outputs": [
        {"address": "woop", "value": 10000}
      ]
    }
  }),
  Fixture.fromJSON({
    "description": "1:1, w/ change",
    "feeRate": 10,
    "inputs": [12000],
    "outputs": [8000],
    "expected": {
      "inputs": [
        {"value": 12000}
      ],
      "outputs": [
        {"value": 8000},
        {"value": 1740}
      ],
      "fee": 2260
    }
  }),
  Fixture.fromJSON({
    "description": "1:2, strange output type",
    "feeRate": 10,
    "inputs": [27000],
    "outputs": [
      {
        "script": {"length": 220},
        "value": 10000
      }
    ],
    "expected": {
      "inputs": [
        {"value": 27000}
      ],
      "outputs": [
        {
          "script": {"length": 220},
          "value": 10000
        },
        {
          "script": {"length": 220},
          "value": 10000
        }
      ],
      "fee": 7000
    }
  }),
  Fixture.fromJSON({
    "description": "1:4",
    "feeRate": 10,
    "inputs": [12000],
    "outputs": [2000],
    "expected": {
      "inputs": [
        {"value": 12000}
      ],
      "outputs": [
        {"value": 2000},
        {"value": 2000},
        {"value": 2000},
        {"value": 2000}
      ],
      "fee": 4000
    }
  }),
  Fixture.fromJSON({
    "description": "2:5",
    "feeRate": 10,
    "inputs": [3000, 12000],
    "outputs": [2000],
    "expected": {
      "inputs": [
        {"value": 3000},
        {"value": 12000}
      ],
      "outputs": [
        {"value": 2000},
        {"value": 2000},
        {"value": 2000},
        {"value": 2000},
        {"value": 2000}
      ],
      "fee": 5000
    }
  }),
  Fixture.fromJSON({
    "description": "2:5, no fee",
    "feeRate": 0,
    "inputs": [5000, 10000],
    "outputs": [3000],
    "expected": {
      "inputs": [
        {"value": 5000},
        {"value": 10000}
      ],
      "outputs": [
        {"value": 3000},
        {"value": 3000},
        {"value": 3000},
        {"value": 3000},
        {"value": 3000}
      ],
      "fee": 0
    }
  }),
  Fixture.fromJSON({
    "description": "2:2 (+1), w/ change",
    "feeRate": 7,
    "inputs": [16000],
    "outputs": [6000],
    "expected": {
      "inputs": [
        {"value": 16000}
      ],
      "outputs": [
        {"value": 6000},
        {"value": 6000},
        {"value": 2180}
      ],
      "fee": 1820
    }
  }),
  Fixture.fromJSON({
    "description": "2:3 (+1), no fee, w/ change",
    "feeRate": 0,
    "inputs": [5000, 10000],
    "outputs": [4000],
    "expected": {
      "inputs": [
        {"value": 5000},
        {"value": 10000}
      ],
      "outputs": [
        {"value": 4000},
        {"value": 4000},
        {"value": 4000},
        {"value": 3000}
      ],
      "fee": 0
    }
  }),
  Fixture.fromJSON({
    "description": "not enough funds",
    "feeRate": 10,
    "inputs": [41000, 1000],
    "outputs": [40000],
    "expected": {"fee": 3400}
  }),
  Fixture.fromJSON({
    "description": "no inputs",
    "feeRate": 10,
    "inputs": [],
    "outputs": [2000],
    "expected": {"fee": 440}
  })
];
