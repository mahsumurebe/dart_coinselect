import 'dart:typed_data';

// InputModel and OutputModel abstract
abstract class IOModelAbstract {
  abstract int? value;
  abstract ByteData? script;
  abstract String? address;
}
