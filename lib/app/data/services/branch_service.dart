import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../modules/home/model/branch_model.dart';
import '../api_constants.dart';

class BranchService extends GetxService {
  final branchModel = BranchModel().obs;

  Future<BranchModel> getBranches() async {
    if (branchModel.value.data != null) {
      return branchModel.value;
    }

    final response = await http.get(
      Uri.parse(ApiConstants.branchUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      branchModel.value = BranchModel.fromJson(jsonDecode(response.body));
      return branchModel.value;
    } else {
      throw Exception('Failed to load branches');
    }
  }
}