import 'utils/base.dart';

List<Fixture> accumulativeFixtures = [
  Fixture.fromJSON({
    "description": "1 output, no change",
    "feeRate": 10,
    "inputs": [102001],
    "outputs": [100000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 102001}
      ],
      "outputs": [
        {"value": 100000}
      ],
      "fee": 2001
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, change expected",
    "feeRate": 5,
    "inputs": [106001],
    "outputs": [100000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 106001}
      ],
      "outputs": [
        {"value": 100000},
        {"value": 4871}
      ],
      "fee": 1130
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, change expected, value > 2^32",
    "feeRate": 5,
    "inputs": [5000000000],
    "outputs": [1],
    "expected": {
      "inputs": [
        {"i": 0, "value": 5000000000}
      ],
      "outputs": [
        {"value": 1},
        {"value": 4999998869}
      ],
      "fee": 1130
    }
  }),
  Fixture.fromJSON({
    "description":
        "1 output, sub-optimal inputs (if re-ordered), direct possible",
    "feeRate": 10,
    "inputs": [10000, 40000, 40000],
    "outputs": [7700],
    "expected": {
      "inputs": [
        {"i": 0, "value": 10000}
      ],
      "outputs": [
        {"value": 7700}
      ],
      "fee": 2300
    }
  }),
  Fixture.fromJSON({
    "description":
        "1 output, sub-optimal inputs (if re-ordered), direct possible, but slightly higher fee",
    "feeRate": 10,
    "inputs": [10000, 40000, 40000],
    "outputs": [6800],
    "expected": {
      "inputs": [
        {"i": 0, "value": 10000}
      ],
      "outputs": [
        {"value": 6800}
      ],
      "fee": 3200
    }
  }),
  Fixture.fromJSON({
    "description":
        "1 output, sub-optimal inputs (if re-ordered, no direct possible), change expected",
    "feeRate": 5,
    "inputs": [10000, 40000, 40000],
    "outputs": [4700],
    "expected": {
      "inputs": [
        {"i": 0, "value": 10000}
      ],
      "outputs": [
        {"value": 4700},
        {"value": 4170}
      ],
      "fee": 1130
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, passes, skipped detrimental input",
    "feeRate": 5,
    "inputs": [
      {
        "script": {"length": 1000},
        "value": 3000
      },
      {"value": 3000},
      {"value": 3000}
    ],
    "outputs": [4000],
    "expected": {
      "fee": 2000,
      "inputs": [
        {"i": 1, "value": 3000},
        {"i": 2, "value": 3000}
      ],
      "outputs": [
        {"value": 4000}
      ]
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, fails, skips (and finishes on) detrimental input",
    "feeRate": 55,
    "inputs": [
      {"value": 44000},
      {"value": 800}
    ],
    "outputs": [38000],
    "expected": {"fee": 18700}
  }),
  Fixture.fromJSON({
    "description": "1 output, passes, poor ordering causing high fee",
    "feeRate": 5,
    "inputs": [
      {
        "script": {"length": 500},
        "value": 3000
      },
      {"value": 3000},
      {"value": 3000}
    ],
    "outputs": [4000],
    "expected": {
      "inputs": [
        {
          "i": 0,
          "script": {"length": 500},
          "value": 3000
        },
        {"i": 1, "value": 3000},
        {"i": 2, "value": 3000}
      ],
      "outputs": [
        {"value": 4000}
      ],
      "fee": 5000
    }
  }),
  Fixture.fromJSON({
    "description":
        "1 output, passes, improved ordering causing low fee, no waste",
    "feeRate": 5,
    "inputs": [
      {"value": 3000},
      {"value": 3000},
      {
        "script": {"length": 400},
        "value": 3000
      }
    ],
    "outputs": [4000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 3000},
        {"i": 1, "value": 3000}
      ],
      "outputs": [
        {"value": 4000}
      ],
      "fee": 2000
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, optimal inputs, no change",
    "feeRate": 10,
    "inputs": [10000],
    "outputs": [7700],
    "expected": {
      "inputs": [
        {"i": 0, "value": 10000}
      ],
      "outputs": [
        {"value": 7700}
      ],
      "fee": 2300
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, no fee, change expected",
    "feeRate": 0,
    "inputs": [5000, 5000, 5000, 5000, 5000, 5000],
    "outputs": [28000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 5000},
        {"i": 1, "value": 5000},
        {"i": 2, "value": 5000},
        {"i": 3, "value": 5000},
        {"i": 4, "value": 5000},
        {"i": 5, "value": 5000}
      ],
      "outputs": [
        {"value": 28000},
        {"value": 2000}
      ],
      "fee": 0
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, script provided, no change",
    "feeRate": 10,
    "inputs": [100000],
    "outputs": [
      {
        "script": {"length": 200},
        "value": 95000
      }
    ],
    "expected": {
      "inputs": [
        {"i": 0, "value": 100000}
      ],
      "outputs": [
        {
          "script": {"length": 200},
          "value": 95000
        }
      ],
      "fee": 5000
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, script provided, change expected",
    "feeRate": 10,
    "inputs": [200000],
    "outputs": [
      {
        "script": {"length": 200},
        "value": 95000
      }
    ],
    "expected": {
      "inputs": [
        {"i": 0, "value": 200000}
      ],
      "outputs": [
        {
          "script": {"length": 200},
          "value": 95000
        },
        {"value": 100990}
      ],
      "fee": 4010
    }
  }),
  Fixture.fromJSON({
    "description": "1 output, 2 inputs (related), no change",
    "feeRate": 10,
    "inputs": [
      {"address": "a", "value": 100000},
      {"address": "a", "value": 2000}
    ],
    "outputs": [98000],
    "expected": {
      "inputs": [
        {"i": 0, "address": "a", "value": 100000}
      ],
      "outputs": [
        {"value": 98000}
      ],
      "fee": 2000
    }
  }),
  Fixture.fromJSON({
    "description": "many outputs, no change",
    "feeRate": 10,
    "inputs": [30000, 12220, 10001],
    "outputs": [35000, 5000, 5000, 1000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 30000},
        {"i": 1, "value": 12220},
        {"i": 2, "value": 10001}
      ],
      "outputs": [
        {"value": 35000},
        {"value": 5000},
        {"value": 5000},
        {"value": 1000}
      ],
      "fee": 6221
    }
  }),
  Fixture.fromJSON({
    "description": "many outputs, change expected",
    "feeRate": 10,
    "inputs": [30000, 14220, 10001],
    "outputs": [35000, 5000, 5000, 1000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 30000},
        {"i": 1, "value": 14220},
        {"i": 2, "value": 10001}
      ],
      "outputs": [
        {"value": 35000},
        {"value": 5000},
        {"value": 5000},
        {"value": 1000},
        {"value": 1981}
      ],
      "fee": 6240
    }
  }),
  Fixture.fromJSON({
    "description": "many outputs, no fee, change expected",
    "feeRate": 0,
    "inputs": [5000, 5000, 5000, 5000, 5000, 5000],
    "outputs": [28000, 1000],
    "expected": {
      "inputs": [
        {"i": 0, "value": 5000},
        {"i": 1, "value": 5000},
        {"i": 2, "value": 5000},
        {"i": 3, "value": 5000},
        {"i": 4, "value": 5000},
        {"i": 5, "value": 5000}
      ],
      "outputs": [
        {"value": 28000},
        {"value": 1000},
        {"value": 1000}
      ],
      "fee": 0
    }
  }),
  Fixture.fromJSON({
    "description": "no outputs, no change",
    "feeRate": 10,
    "inputs": [1900],
    "outputs": [],
    "expected": {
      "inputs": [
        {"i": 0, "value": 1900}
      ],
      "outputs": [],
      "fee": 1900
    }
  }),
  Fixture.fromJSON({
    "description": "no outputs, change expected",
    "feeRate": 10,
    "inputs": [20000],
    "outputs": [],
    "expected": {
      "inputs": [
        {"i": 0, "value": 20000}
      ],
      "outputs": [
        {"value": 18080}
      ],
      "fee": 1920
    }
  }),
  Fixture.fromJSON({
    "description": "inputs used in order of DESCENDING",
    "feeRate": 10,
    "inputs": [
      20000,
      {
        "script": {"length": 300},
        "value": 10000
      },
      10000
    ],
    "outputs": [25000],
    "expected": {
      "fee": 7150,
      "inputs": [
        {"i": 0, "value": 20000},
        {
          "i": 1,
          "script": {"length": 300},
          "value": 10000
        },
        {"i": 2, "value": 10000}
      ],
      "outputs": [
        {"value": 25000},
        {"value": 7850}
      ]
    }
  }),
  Fixture.fromJSON({
    "description": "not enough funds, empty result",
    "feeRate": 10,
    "inputs": [20000],
    "outputs": [40000],
    "expected": {"fee": 1920}
  }),
  Fixture.fromJSON({
    "description": "not enough funds (w/ fee), empty result",
    "feeRate": 10,
    "inputs": [40000],
    "outputs": [40000],
    "expected": {"fee": 1920}
  }),
  Fixture.fromJSON({
    "description": "not enough funds (no inputs), empty result",
    "feeRate": 10,
    "inputs": [],
    "outputs": [],
    "expected": {"fee": 100}
  }),
  Fixture.fromJSON({
    "description": "not enough funds (no inputs), empty result (>1KiB)",
    "feeRate": 10,
    "inputs": [],
    "outputs": [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1
    ],
    "expected": {"fee": 9960}
  }),
];
