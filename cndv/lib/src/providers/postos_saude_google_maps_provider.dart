

import 'package:cndv/src/models/postos_saude_atendimento_model.dart';

class PostosSaudeGoogleMapsProvider {

  /// TODO update google maps
  final String _url = 'https://googlemapsur.com';

  Future<bool> getMapPointers( PostosSaudeAtendimento postosSaude ) async {
      final url = '$_url';
      //final resp = await http.post(url, body: postosModelToJson(postosSaude)
      //final decodedData = json.decode(resp.body);
      //print( decodeData );
      return true;
  }
}