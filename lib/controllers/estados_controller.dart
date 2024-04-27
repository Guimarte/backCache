import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:backend_cidades/models/estados_model.dart';
import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

class EstadosController {
  Future getAllEstadosApiBrasil() async {
    http.Response response =
        await http.get(Uri.parse("https://brasilapi.com.br/api/ibge/uf/v1"));

    List<EstadosModel> estadosModel =
        EstadosModel.listFromJson(jsonDecode(response.body));

    String jsonEstados =
        jsonEncode(estadosModel.map((e) => e.toJson()).toList());

    File estadosFile = File("lib/data/estados.json");
    await estadosFile.writeAsString(jsonEstados);
  }

  FutureOr<Response> getAllEstadosFromCache(Request req) async {
    File estadosFile = File("lib/data/estados.json");
    if (!estadosFile.existsSync()) {
      await EstadosController().getAllEstadosApiBrasil();
    }
    String estadosString = estadosFile.readAsStringSync();

    List<EstadosModel> estadosModel =
        EstadosModel.listFromJson(jsonDecode(estadosString));

    return Response.ok(jsonEncode(estadosModel), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader:
          "Access-Control-Allow-Origin, Accept"
    });
  }
}
