import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._();

  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
