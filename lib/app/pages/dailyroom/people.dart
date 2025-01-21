import 'package:flutter/material.dart';

class People extends StatefulWidget {
  const People({super.key});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  late TextEditingController _adults;
  late TextEditingController _kids;
  late TextEditingController _visitors;

  @override
  void initState() {
    super.initState();
    _adults = TextEditingController();
    _kids = TextEditingController();
    _visitors = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _adults.dispose();
    _kids.dispose();
    _visitors.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('성인'),
            SizedBox(
              width: 30,
              child: TextField(
                controller: _adults,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: -1),
                ),
              ),
            ),
            Text('명, '),
            SizedBox(
              width: 15,
            ),
            Text('소인'),
            SizedBox(
              width: 30,
              child: TextField(
                controller: _kids,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: -1), // 세로 패딩 제거
                  isDense: true, // 내부 공간을 조밀하게 만듦
                ),
              ),
            ),
            Text('명, '),
            SizedBox(
              width: 15,
            ),
            Text('방문객'),
            SizedBox(
              width: 30,
              child: TextField(
                controller: _visitors,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: -1), // 세로 패딩 제거
                  isDense: true, // 내부 공간을 조밀하게 만듦
                ),
              ),
            ),
            Text('명, '),
          ],
        ),
      ),
    );
  }
}
