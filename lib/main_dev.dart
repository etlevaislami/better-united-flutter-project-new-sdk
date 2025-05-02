import 'package:flutter_better_united/run.dart';

import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.dev;
  startApp(const App());
}