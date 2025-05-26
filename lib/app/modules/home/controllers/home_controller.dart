import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeController extends GetxController {
  Rx<BranchModel> branchModel = BranchModel().obs;
  Rx<BranchData> selectedBranch = BranchData().obs;
  RxBool isLoading= false.obs;
  final String cabinetVideoUrl = 'https://www.youtube.com/watch?v=7wLbZqS34ns&list=PLh0KqGKtX4oXua2PyUZe5w09z0pFQV6d-&index=16';
  Rx<YoutubePlayerController?> youtubePlayerController = Rx<YoutubePlayerController?>(null);


  fetchBranch() async {
    isLoading.value = true;
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.branchUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        branchModel.value= BranchModel.fromJson(decodedBody);
        print(branchModel.value);
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar('Failed', decodedBody['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<BranchData> saveBranchInfo() async {
    final savedBranchJson  = await PrefsHelper.getString('branchInfo');
    final branchData = BranchData.fromJson(jsonDecode(savedBranchJson));
    return branchData;
  }

  videoSetup()async{
    final branchData = await saveBranchInfo();
    if(branchData.youtubeLink!=null){
      String? videoId = YoutubePlayer.convertUrlToId(cabinetVideoUrl);
      youtubePlayerController.value = YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(autoPlay: true,mute: false,)
      ) ;
      print(youtubePlayerController.value);
    }
  }
}