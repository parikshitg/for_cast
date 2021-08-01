String getCityLocalTime(timezone){
  String hhmm =  DateTime.now().toUtc().add(Duration(seconds: timezone)).toString().substring(11,16);
  int hh = int.parse(hhmm.substring(0,2));

  if (hh > 11){
    return hhmm + ' PM';
  }
  return hhmm + ' AM';
}