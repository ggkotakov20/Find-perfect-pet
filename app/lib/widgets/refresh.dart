import 'package:http/http.dart' as http;

Future<void> refreshData(Function dataFetcher, Function callback) async {
  try {
    final newData = await dataFetcher();
    callback(newData);
  } catch (e) {
    print('Error refreshing data: $e');
  }
}
