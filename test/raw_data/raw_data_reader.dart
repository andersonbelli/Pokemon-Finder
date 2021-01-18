import 'dart:io';

String readder(String name) =>
    File('.\\test\\raw_data\\$name').readAsStringSync();
