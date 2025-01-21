class MarkdownUtil {
  static List<String> getKeywords(String markdown) {
    final RegExp keywordRegex = RegExp(r'(?<!#)#([^\s#]+)');
    final matches = keywordRegex.allMatches(markdown);
    return matches.map((m) => m.group(1) ?? '').toList();
  }

  static String? getTitle(String markdown) {
    final RegExp titleRegex = RegExp(r'#\s+([^\n]+)');
    final match = titleRegex.firstMatch(markdown);
    return match?.group(1);
  }

  static String? getBriefSummary(String markdown) {
    final RegExp summaryRegex = RegExp(r'#[^\n]*\n>\s*([^\n]+)');
    final match = summaryRegex.firstMatch(markdown);
    return match?.group(1);
  }

  static List<Map<String, List<String>>> getMainSections(String markdown) {
    final sections = <Map<String, List<String>>>[];
    final RegExp sectionRegex = RegExp(r'###\s+([^\n]+)\n((?:-[^\n]+\n?)+)', multiLine: true);
    final RegExp bulletRegex = RegExp(r'-\s+([^\n]+)');

    for (final match in sectionRegex.allMatches(markdown)) {
      final title = match.group(1) ?? '';
      final content = match.group(2) ?? '';

      final bullets = bulletRegex.allMatches(content).map((m) => m.group(1)?.trim() ?? '').where((bullet) => bullet.isNotEmpty).toList();

      if (bullets.isNotEmpty) {
        sections.add({
          title: bullets
        });
      }
    }
    return sections;
  }

  static List<String> getImportantQuotes(String markdown) {
    final RegExp quoteRegex = RegExp(r'>\s*"([^"]+)"');
    final matches = quoteRegex.allMatches(markdown);
    return matches.map((m) => m.group(1) ?? '').toList();
  }

  static List<Map<String, String>> getAdditionalNotes(String markdown) {
    final notes = <Map<String, String>>[];
    final RegExp noteRegex = RegExp(r'\*([^*]+)\*\s*-\s*([^\n]+)');

    for (final match in noteRegex.allMatches(markdown)) {
      final term = match.group(1)?.trim() ?? '';
      final explanation = match.group(2)?.trim() ?? '';
      notes.add({
        term: explanation
      });
    }
    return notes;
  }
}
