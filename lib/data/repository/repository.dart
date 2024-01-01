import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:valorant_insider_bloc/widget/constant/constant.dart';
import 'package:valorant_insider_bloc/data/models/agent_model.dart';
import 'package:valorant_insider_bloc/data/models/buddies_model.dart';
import 'package:valorant_insider_bloc/data/models/weapon_model.dart';

class Repository {
   Future<List<BuddiesModel>> getAllBuddies() async {
    List<BuddiesModel> listBuddies = [];

    try {
      Uri url = Uri.parse(urlBuddies);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tempdata = json.decode(response.body)['data'];
        var data = tempdata.map((e) => BuddiesModel.fromJson(e));
        listBuddies = List<BuddiesModel>.from(data);
      }
    } catch (e) {
      listBuddies = [];
    }

    return listBuddies;
  }

   Future<List<AgentModel>> getAllAgent() async {
    List<AgentModel> listAgent = [];
    try {
      Uri url = Uri.parse(urlAgent);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tempdata = json.decode(response.body)['data'];
        var data = tempdata.map((e) => AgentModel.fromJson(e));
        listAgent = List<AgentModel>.from(data);
      }
    } catch (e) {
      listAgent = [];
    }
    return listAgent;
  }

   Future<List<WeaponModel>> getAllWeapon() async {
    List<WeaponModel> listWeapons = [];
    try {
      Uri url = Uri.parse(urlWeapon);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tempdata = json.decode(response.body)['data'];
        var data = tempdata.map((e) => WeaponModel.fromJson(e));
        listWeapons = List<WeaponModel>.from(data);
      }
    } catch (e) {
      listWeapons = [];
      // Get.snackbar("Error", e.toString());
    }
    return listWeapons;
  }
}
