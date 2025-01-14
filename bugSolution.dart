```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Process jsonData
    } else {
      // Log the error with details
      print('API request failed with status code: ${response.statusCode}, body: ${response.body}');
      //Show user friendly error message
      //In real world application, show error to the user using a dialog or snackbar
      print('Failed to load data. Please try again later.');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } on SocketException catch (e) {
    print('Network error: $e');
    print('Retrying...');
    await Future.delayed(Duration(seconds: 2)); //Retry after 2 seconds
    await fetchData();//Retry the API call
  } on FormatException catch (e){
      print('Failed to parse JSON: $e');
      //Show user friendly error message
      print('Failed to load data. Please try again later.');
  } catch (e) {
    print('An unexpected error occurred: $e');
    //Show user friendly error message
      print('Failed to load data. Please try again later.');
  }
}
```