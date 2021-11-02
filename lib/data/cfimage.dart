import 'package:intl/intl.dart';

class CFImage {
  static DateFormat formatter = DateFormat("yyyy-MM-dd'T'hh:mm:ss");
  String id;
  String fileName;
  DateTime uploaded;

  CFImage(this.id, this.fileName, this.uploaded);
}
