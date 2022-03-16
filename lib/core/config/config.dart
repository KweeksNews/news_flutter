mixin CONFIG {
  /// Site hostname.
  /// Accessible via https protocol.
  static const String hostName = 'www.kweeksnews.com';

  /// Site post categories.
  /// Array in format ['Category Name', 'Category ID']
  static const List<List<String>> categories = [
    ['Artikel', '1'],
    ['Kabar', '953'],
    ['Cerpen', '5'],
    ['Puisi', '4'],
    ['Video', '19'],
    ['Podcast', '67'],
  ];

  /// Headers for any http request
  static const Map<String, String> headers = {
    'accept': 'application/json; charset=utf-8',
    'cache-control': 'no-cache',
    'content-type': 'application/json; charset=utf-8',
    'user-agent': 'KweeksNews/2.0.0 (+com.kweeksnews)',
  };
}
