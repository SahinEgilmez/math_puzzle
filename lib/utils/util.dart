class Util {
  static String operator;
  static int level = 1;
  static int min = 1;
  static int max = 20;
  static int count = 2;
  static double period = 0.010;
  static bool loading = true;

  static void updateLevel(int score) {
    if (score < 100)
      Util.level = 1;
    else if (score < 200)
      Util.level = 2;
    else if (score < 500)
      Util.level = 3;
    else if (score < 1000)
      Util.level = 4;
    else if (score < 2500)
      Util.level = 5;
    else if (score < 10000)
      Util.level = 6;
    else if (score < 20000)
      Util.level = 7;
    else if (score < 50000)
      Util.level = 8;
    else if (score < 100000)
      Util.level = 9;
    else
      Util.level = 10;

    switch (Util.level) {
      case 1:
        Util.period = 0.10;
        Util.count = 2;
        break;
      case 2:
        Util.period = 0.020;
        break;
      case 3:
        Util.period = 0.025;
        Util.count = 3;
        Util.max = 25;
        break;
      case 4:
        Util.period = 0.030;
        Util.max = 30;
        break;
      case 5:
        Util.period = 0.035;
        Util.count = 4;
        Util.max = 35;
        break;
      case 6:
        Util.period = 0.040;
        Util.max = 40;
        break;
      case 7:
        Util.period = 0.045;
        Util.max = 45;
        break;
      case 8:
        Util.period = 0.050;
        Util.max = 50;
        break;
      case 9:
        Util.period = 0.055;
        Util.max = 55;
        break;
      case 10:
        Util.count = 5;
        Util.period = 0.060;
        Util.max = 60;
        break;
    }

    print("NEW LEVEL:" + level.toString() + "," + period.toString() + "-" + count.toString());
  }
}
