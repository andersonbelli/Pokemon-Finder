import 'dart:io';

String readRawFile(String name) =>
    File('.\\test\\raw_data\\$name').readAsStringSync();
