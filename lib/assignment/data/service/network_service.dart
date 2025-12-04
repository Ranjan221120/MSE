import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/pull_request_model.dart';

class NetworkService {
  
  Future<List<PullRequestModel>> getPullRequests() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/Ranjan221120/Bloc/pulls'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PullRequestModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pull requests');
    }
  }
}