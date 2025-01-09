import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersonalCenterPage extends StatefulWidget {
  const PersonalCenterPage({super.key});

  @override
  State<PersonalCenterPage> createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          Card(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 32, 50, 32),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/headPortrait.png'),
                  ),
                ),
                Column(
                  children: [
                    Text('Whale', style: TextStyle(fontSize: 30,)),
                    SizedBox(height: 20,),
                    Text('在自己身上，克服这个时代', style: TextStyle(fontSize: 13,))
                  ],
                )
              ],
            ),
          ),
          Card(
            child: SizedBox(
              height: 125,  // 设置Card的固定高度
              width: double.infinity,  // 设置宽度最大化
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,  // 将文本左对齐
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),  // 可选：设置文本周围的间距
                      child: Text("成就:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  // 横向滚动的图片列表
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,  // 设置横向滚动
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/trophy.png'), // 替换为你自己的图片路径
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4, 8, 4, 10),
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('我的任务'),
                          subtitle: Text('任务详情')
                      ),
                    ),


                  ],
                ),
              )
            )
          )
        ],
      ),
    );
  }
}
