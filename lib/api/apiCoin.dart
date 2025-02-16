import 'dart:convert';
import 'package:http/http.dart' as http;

// 获取余额的函数
Future<int> getCoinCount() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5000/get_coin'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['coin_count'];
  } else {
    throw Exception('获取虚拟币余额失败');
  }
}

// 点击赚币的函数
Future<int> earnCoin() async {
  final response = await http.post(Uri.parse('http://10.0.2.2:5000/earn_coin'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['coin_count'];
  } else {
    throw Exception('赚取虚拟币失败');
  }
}
