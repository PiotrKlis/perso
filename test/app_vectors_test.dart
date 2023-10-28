import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:perso/app/styleguide/value/app_assets.dart';

void main() {
  test('app_vectors assets test', () {
    expect(File(AppVectors.bodybuilding).existsSync(), isTrue);
    expect(File(AppVectors.calisthenics).existsSync(), isTrue);
    expect(File(AppVectors.cardio).existsSync(), isTrue);
    expect(File(AppVectors.crossfit).existsSync(), isTrue);
    expect(File(AppVectors.endurance).existsSync(), isTrue);
    expect(File(AppVectors.gymnastics).existsSync(), isTrue);
    expect(File(AppVectors.yoga).existsSync(), isTrue);
  });
}
