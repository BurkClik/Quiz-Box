import 'package:flutter/material.dart';
import 'package:quizbox/model/question.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/services/database_helper.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizbox/view/question_view.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    context.read<QuestionProvider>().resetQuestionNumber();
    updateTimer();
    clearList();
    resetScore();
    resetTrueNumber();
  }

  void updateTimer() {
    context.read<TimeModel>().resetCountDown(15);
  }

  void clearList() {
    if (context.read<QuestionProvider>().questionBank.length > 0) {
      context.read<QuestionProvider>().deleteAllItem();
    }
  }

  void resetScore() {
    if (context.read<ScoreProvider>().score > 0) {
      context.read<ScoreProvider>().resetScore();
    }
  }

  void resetTrueNumber() {
    if (context.read<ScoreProvider>().trueQuestion > 0) {
      context.read<ScoreProvider>().resetTrueCount();
    }
  }

  Future<void> connectDB(String category) async {
    List<String> difficult = ['Easy', 'Medium', 'Hard'];
    for (int i = 0; i < 3; i++) {
      await dbHelper.getCategoryRandom(category, difficult[i]).then((value) {
        setState(() {
          value.forEach((element) {
            context.read<QuestionProvider>().addItem(Question.map(element));
          });
          context.read<ScoreProvider>().setRemainQuestion(
              context.read<QuestionProvider>().questionBank.length - 1);
        });
      });
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => QuestionView(),
      ),
    );
  }

  Future<void> connectDBAllQuestion() async {
    List<String> difficult = ['Easy', 'Medium', 'Hard'];
    for (int i = 0; i < 3; i++) {
      await dbHelper.getRandom(difficult[i]).then((value) {
        setState(() {
          value.forEach((element) {
            context.read<QuestionProvider>().addItem(Question.map(element));
          });
          context.read<ScoreProvider>().setRemainQuestion(
              context.read<QuestionProvider>().questionBank.length - 1);
        });
      });
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => QuestionView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: getProportionateScreenHeight(36.0)),
                child: Container(
                  width: getProportionateScreenWidth(307),
                  height: getProportionateScreenHeight(118),
                  child: Image.asset("assets/images/ulan.png"),
                ),
              ),
              SizedBox(height: 62),
              CategoryRow(
                leftCategoryName: 'Genel Kültür',
                leftAssetName: 'assets/icons/culture.svg',
                lGetData: () {
                  connectDBAllQuestion();
                },
                rightCategoryName: 'Bilim',
                rightAssetName: 'assets/icons/science.svg',
                rGetData: () {
                  connectDB('Science');
                },
              ),
              SizedBox(height: 10),
              CategoryRow(
                leftCategoryName: 'Edebiyat',
                leftAssetName: 'assets/icons/literature.svg',
                lGetData: () {
                  connectDB('Literature');
                },
                rightCategoryName: 'Sinema',
                rightAssetName: 'assets/icons/cinema.svg',
                rGetData: () {
                  connectDB('Cinema');
                },
              ),
              SizedBox(height: 10),
              CategoryRow(
                leftCategoryName: 'Tarih',
                leftAssetName: 'assets/icons/ancient.svg',
                leftHeight: 52.0,
                leftWidth: 52.0,
                lGetData: () {
                  connectDB('History');
                },
                rightCategoryName: 'Coğrafya',
                rightAssetName: 'assets/icons/earth.svg',
                rightHeight: 52.0,
                rightWidth: 52.0,
                rGetData: () {
                  connectDB('Geography');
                },
              ),
              SizedBox(height: 10),
              CategoryRow(
                leftCategoryName: 'Spor',
                leftAssetName: 'assets/icons/sport.svg',
                leftHeight: 52.0,
                leftWidth: 52.0,
                lGetData: () {
                  connectDB('Sport');
                },
                rightCategoryName: 'Müzik',
                rightAssetName: 'assets/icons/music.svg',
                rightHeight: 52.0,
                rightWidth: 52.0,
                rGetData: () {
                  connectDB('Music');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {
  final String leftCategoryName;
  final String leftAssetName;
  final String rightCategoryName;
  final String rightAssetName;
  final double leftWidth;
  final double leftHeight;
  final double rightWidth;
  final double rightHeight;
  final Function lGetData;
  final Function rGetData;

  CategoryRow({
    @required this.leftCategoryName,
    @required this.leftAssetName,
    @required this.rightCategoryName,
    @required this.rightAssetName,
    this.lGetData,
    this.rGetData,
    double leftWidth,
    double leftHeight,
    double rightWidth,
    double rightHeight,
  })  : leftWidth = leftWidth ?? 64.0,
        leftHeight = leftHeight ?? 64.0,
        rightWidth = rightWidth ?? 64.0,
        rightHeight = rightHeight ?? 64.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryBox(
          categoryName: leftCategoryName,
          assetName: leftAssetName,
          width: leftWidth,
          height: leftHeight,
          getData: lGetData,
        ),
        SizedBox(width: getProportionateScreenHeight(48.0)),
        CategoryBox(
          categoryName: rightCategoryName,
          assetName: rightAssetName,
          width: rightWidth,
          height: rightHeight,
          getData: rGetData,
        ),
      ],
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String categoryName;
  final String assetName;
  final double width;
  final double height;
  final Function getData;

  CategoryBox(
      {@required this.categoryName,
      @required this.assetName,
      this.getData,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: getProportionateScreenWidth(120.0),
          height: getProportionateScreenHeight(120.0),
          decoration: kCategoryBoxDeco,
          child: Material(
            type: MaterialType.transparency,
            color: Colors.transparent,
            child: InkWell(
              highlightColor: kThirdColor,
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                getData();
                switch (categoryName) {
                  case 'Genel Kültür':
                    context
                        .read<QuestionProvider>()
                        .updateCategory('Knowledge');
                    break;
                  case 'Bilim':
                    context.read<QuestionProvider>().updateCategory('Science');
                    break;
                  case 'Edebiyat':
                    context
                        .read<QuestionProvider>()
                        .updateCategory('Literature');
                    break;
                  case 'Sinema':
                    context.read<QuestionProvider>().updateCategory('Cinema');
                    break;
                  case 'Tarih':
                    context.read<QuestionProvider>().updateCategory('History');
                    break;
                  case 'Coğrafya':
                    context
                        .read<QuestionProvider>()
                        .updateCategory('Geography');
                    break;
                  case 'Spor':
                    context.read<QuestionProvider>().updateCategory('Sport');
                    break;
                  case 'Müzik':
                    context.read<QuestionProvider>().updateCategory('Music');
                    break;
                  default:
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    assetName,
                    width: getProportionateScreenWidth(width),
                    height: getProportionateScreenHeight(height),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(8.0),
                      top: getProportionateScreenHeight(8.0),
                    ),
                    child: Text(categoryName, style: kCategoryTextStyle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
