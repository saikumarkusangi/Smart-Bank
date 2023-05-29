import 'package:bank/services/services.dart';

export './images.dart';
export './commands.dart';
export './greetings.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<String> telugumonths = [
  'జనవరి',
  'ఫిబ్రవరి',
  'మార్చ్',
  'ఏప్రిల్',
  'మే',
  'జూన్',
  'జూలై',
  'ఆగస్టు',
  'సెప్టెంబర్',
  'అక్టోబర్',
  'నవంబర్',
  'డిసెంబర్'
];
List profile_audios = [];

play_profilr_audios() async {
  for (var i = 0; i < profile_audios.length; i++) {
    await TtsApi.api(profile_audios[i].toString());
  }
}
