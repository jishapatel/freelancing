import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../remote/models/programs_response.dart';

class ProgramsProvider extends ChangeNotifier {
  static const apiEndpoint =
      'https://632017e19f82827dcf24a655.mockapi.io/api/programs';

  bool isLoading = true;
  String error = '';
  ProgramsResponse programsResponse = ProgramsResponse(
    requestId: '',
    items: [],
    count: 0,
    anyKey: '',
  );

  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        programsResponse = programsResponseFromJson(response.body);
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
