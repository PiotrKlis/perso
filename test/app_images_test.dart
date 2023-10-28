import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:perso/app/styleguide/value/app_assets.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.dummyPic1).existsSync(), isTrue);
    expect(File(AppImages.dummyPic2).existsSync(), isTrue);
    expect(File(AppImages.dummyPic3).existsSync(), isTrue);
    expect(File(AppImages.screenshot).existsSync(), isTrue);
    expect(File(AppImages.trainer).existsSync(), isTrue);
    expect(File(AppImages.trainer1).existsSync(), isTrue);
    expect(File(AppImages.trainer2).existsSync(), isTrue);
    expect(File(AppImages.trainer3).existsSync(), isTrue);
  });
}
