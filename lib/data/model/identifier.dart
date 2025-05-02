import 'package:flutter_better_united/data/net/models/identifier_response.dart';

class Identifier {
  final int id;

  Identifier(this.id);

  Identifier.fromIdentifierResponse(IdentifierResponse identifier)
      : this(identifier.id);
}
