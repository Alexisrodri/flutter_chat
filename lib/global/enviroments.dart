
import 'dart:io';

class Enviroments {
  //Conexion a render  https://socket-io-bands.onrender.com/
  static String apiUrl = Platform.isAndroid ? 'https://socket-io-bands.onrender.com/api' : 'https://socket-io-bands.onrender.com/api';  
  static String socketUrl = Platform.isAndroid ? 'https://socket-io-bands.onrender.com' : 'https://socket-io-bands.onrender.com';  
}
