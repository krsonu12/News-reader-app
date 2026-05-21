/// Pure domain entity — no JSON, no Flutter, no framework dependencies.
class Article {
  const Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
    required this.author,
  });

  final String title;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String sourceName;
  final String author;

  /// Stable identity key: prefer URL, fall back to a pipe-joined fingerprint.
  String get id {
    if (url.isNotEmpty) return url;

    final fallback = [
      title,
      description,
      content,
      urlToImage,
      publishedAt,
      sourceName,
      author,
    ].map((v) => v.trim()).where((v) => v.isNotEmpty).join('|');

    return fallback.isNotEmpty ? fallback : 'unknown_article';
  }

  Article copyWith({
    String? title,
    String? description,
    String? content,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? sourceName,
    String? author,
  }) {
    return Article(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      sourceName: sourceName ?? this.sourceName,
      author: author ?? this.author,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Article(title: $title, source: $sourceName)';
}
