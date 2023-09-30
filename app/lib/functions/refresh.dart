import 'dart:async';

Future<void> refreshData(Function fetchData, Function callback) async {
  try {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay

    final updatedData = await fetchData();

    callback(updatedData);

    print('Data refreshed successfully');
  } catch (e) {
    print('Error refreshing data: $e');
  }
}
