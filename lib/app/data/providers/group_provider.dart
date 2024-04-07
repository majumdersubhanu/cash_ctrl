import 'package:get/get.dart';

import '../models/group_model.dart';

class GroupProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Group.fromJson(map);
      if (map is List) return map.map((item) => Group.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Group?> getGroup(int id) async {
    final response = await get('group/$id');
    return response.body;
  }

  Future<Response<Group>> postGroup(Group group) async =>
      await post('group', group);

  Future<Response> deleteGroup(int id) async => await delete('group/$id');
}
