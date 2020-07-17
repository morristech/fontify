import 'package:args/args.dart';

void defineOptions(ArgParser argParser) {
  argParser
    ..addSeparator('Flutter class options:')
    ..addOption(
      'output-class-file',
      abbr: 'o',
      help: 'Output path for Flutter-compatible class that contains identifiers for the icons. Example: lib/icons.dart',
      valueHelp: 'path',
    )
    ..addOption(
      'indent',
      abbr: 'i',
      help: 'Number of spaces in leading indentation for Flutter class file.',
      valueHelp: 'indent',
      defaultsTo: '2',
    )
    ..addOption(
      'class-name',
      abbr: 'c',
      help: 'Class name.',
      valueHelp: 'name',
    )
    ..addSeparator('Font options:')
    ..addOption(
      'font-name',
      abbr: 'f',
      help: 'Font name.',
      valueHelp: 'name',
    )
    ..addFlag(
      'normalize',
      help: 'Enables glyph normalization for the font. Disable this if every icon has the same size and positioning.',
      defaultsTo: true,
    )
    ..addFlag(
      'ignore-shapes',
      help: 'Disables SVG shape-to-path conversion (circle, rect, etc.).',
      defaultsTo: true,
    )
    ..addSeparator('Other options:')
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Display every logging message.',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Shows this usage information.',
      negatable: false,
    );
}