import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizbox/model/question.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/routes.dart';
import 'package:quizbox/view/splash.dart';

/// TODO:
/// [X] Seçenekleri InkWell'den Button'a döndür
/// [X] List separated ile ekrana Buttonları bastır.
/// [X] Puan sistemini düzenle.
/// [] Süreyi düzenle
///   [X] Yeni soruya geçildiği zaman süre resetle.
///   [] Süre dolduğu zaman hata ekranına git.
/// [X] Yeniden başlat butonuna tıklandığında dbden yeni soruları çeksin
/// [X] Kalan soru sayısı yanlış gösteriyor.
/// [] Lottieleri assets klasörünün içine yükle
/// [X] Sorular arası geçişleri daha smooth hale getir.
/// [] Close ikonunu daha kalın bir ikon ile değiştir.
/// [] Dark mode
/// [] Home kısmındaki kategorileri button ile tekrardan yap.
/// [] Ekran döndürmeyi kapat
/// [] Cong ekranına giderken hata veriyor.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final int countDown = 15;
  final int questionNumber = 0;
  final int score = 0;
  final int remainQuestion = 0;
  final int trueCounter = 0;
  final List<Question> questionBank = new List();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<TimeModel>(create: (_) => TimeModel(countDown)),
        ListenableProvider<QuestionProvider>(
            create: (_) => QuestionProvider(questionBank, questionNumber)),
        ListenableProvider<ScoreProvider>(
            create: (_) => ScoreProvider(score, remainQuestion, trueCounter)),
      ],
      child: MaterialApp(
        title: 'Quiz Box',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Splash(),
        initialRoute: Splash.routeName,
        routes: routes,
      ),
    );
  }
}
