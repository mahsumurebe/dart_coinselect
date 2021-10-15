// Empty transaction size
const int txEmptySize = 4 + 1 + 1 + 4;
// P2WPKH inputs have fixed size. The contributions of a 32-byte transaction id, a four-byte position, a one-byte variable-length integer, an empty unlocking script, and a four-byte sequence number result in a total size of 41 bytes.
const int txInputBase = 32 + 4 + 1 + 4;
// Combined script size
const int txInputPubKeyHash = 107;
// Output base size
const int txOutputBase = 8 + 1;
// Output hash and locking-script size
const int txOutputPubKeyHash = 25;
// Transaction blank output size
const int txBlankOutput = txOutputBase + txOutputPubKeyHash;
