import 'package:get/get.dart';

class Greetings{
  //శుభోదయం నేను మీకు ఎలా సహాయం చేయగలను
  // శుభ మధ్యాహ్నం నేను మీకు ఎలా సహాయం చేయగలను
  //శుభ సాయంత్రం నేను మీకు ఎలా సహాయం చేయగలను
  //మీ ప్రస్తుత ఖాతా బ్యాలెన్స్ 200 రూపాయలు అందుబాటులో ఉంది

  static greetingText (){
    var time = DateTime.now().hour;
    if (time > 6 && time < 12) {
      return 'Good Morning'.tr;
    } else if(time >  12 && time < 17) {
      return 'Good Afternoon'.tr;
    }
    else {
      return 'Good Evening'.tr;
    }
  }
}