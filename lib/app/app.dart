import 'package:flutter/material.dart';
import 'package:flutter_firebase_study/app/pages/persnnelStatus/caravan_persnnel_status.dart';
import 'package:flutter_firebase_study/app/pages/reservation/caravan_reservation_status.dart';
import 'package:flutter_firebase_study/app/pages/revenue/caravan_revenue.dart';
import 'package:flutter_firebase_study/app/pages/dailyroom/dailyroom.dart';

class App extends StatelessWidget {
  const App({super.key});

  //메인 페이지에서 화면 전환
  void _navigatinToScreen(BuildContext context, String item) {
    Widget screen;

    switch (item) {
      case '일일 객실 현황':
        screen = DailyRoom(title: item);
        break;
      case '카라반 인원 현황':
        screen = CaravanPersnnelStatus(title: item);
        break;
      case '카라반 예약 건 수':
        screen = CaravanReservationStatus(title: item);
        break;
      //매출은 먼저 지정된 비밀번호 입력 후 화면 띄우는 기능으로 추가
      case '카라반 매출':
        screen = CaravanRevenue(title: item);
        break;
      default:
        screen = DailyRoom(title: item);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    List items = ['일일 객실 현황', '카라반 인원 현황', '카라반 예약 건 수', '카라반 매출'];

    return Scaffold(
      appBar: AppBar(
        title: Text('카라반 전체 관리'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _navigatinToScreen(context, item);
                  },
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
