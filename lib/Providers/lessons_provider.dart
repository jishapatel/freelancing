import 'package:flutter/cupertino.dart';
import 'package:freelancing_task/remote/models/lessons_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LessonsProvider extends ChangeNotifier {
  static const apiEndpoint =
      'https://632017e19f82827dcf24a655.mockapi.io/api/lessons';

  bool isLoading = true;
  String error = '';
  LessonsResponse lessonsResponse = LessonsResponse(
    requestId: '',
    items: [],
    count: 0,
    anyKey: '',
  );

  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        lessonsResponse = lessonsResponseFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
