import 'package:flutter_bakery/config/color/color.dart';

import '../../view/home/model/cupcake_model.dart';

class DummyData {
  static final List<CupCakeModel> cupCakeList = [
    CupCakeModel(
      cupCakeImage: "assets/images/blueberry.png",
      cupCakeTopImage: "assets/images/blueberry_toppings.png",
      backgroundColor: AppColor.purple,
    ),
    CupCakeModel(
      cupCakeImage: "assets/images/rasberry.png",
      cupCakeTopImage: "assets/images/rasberry_toppings.png",
      backgroundColor: AppColor.red,
    ),
    CupCakeModel(
      cupCakeImage: "assets/images/strawberry.png",
      cupCakeTopImage: "assets/images/strawberry_toppings.png",
      backgroundColor: AppColor.peech,
    ),
    CupCakeModel(
      cupCakeImage: "assets/images/choclate.png",
      cupCakeTopImage: "assets/images/choclate_toppings.png",
      backgroundColor: AppColor.brown,
    ),
  ];
}
