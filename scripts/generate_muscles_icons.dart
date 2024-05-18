import 'dart:io';

void main() {
  final dir = Directory('assets/muscles/');
  final buffer = StringBuffer();

  buffer.writeln('class IconAssets {');
  buffer.writeln('  static const List<Map<String, String>> icons = [');

  for (var file in dir.listSync()) {
    if (file is File) {
      final fileName = file.uri.pathSegments.last;
      final iconName = fileName.split('.').first;
      buffer.writeln("    {'name': '$iconName', 'path': 'assets/muscles/$fileName'},");
    }
  }

  buffer.writeln('  ];');
  buffer.writeln('}');

  final outputFile = File('lib/icon_assets.dart');
  outputFile.writeAsStringSync(buffer.toString());
}
