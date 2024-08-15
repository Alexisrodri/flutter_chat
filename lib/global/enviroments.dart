
import 'dart:io';

class Enviroments {
  //Conexion a render  https://socket-io-bands.onrender.com/
  static String apiUrl = Platform.isAndroid ? 'http://192.168.100.40:3000/api' : 'http://localhost:3000/api';  
  static String socketUrl = Platform.isAndroid ? 'http://192.168.100.40:3000' : 'http://localhost:3000';  
}
