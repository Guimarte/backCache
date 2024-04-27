import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:backend_cidades/controllers/estados_controller.dart';
import 'package:backend_cidades/models/cidades_model.dart';
import 'package:backend_cidades/models/estados_model.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

class CidadesController {
  Future getAllCidadesFromApiBrasil() async {
    List<EstadosModel> estadosModel = [];
    File estadosFile = File("lib/data/estados.json");
    var estado = estadosFile.readAsStringSync();
    estadosModel = EstadosModel.listFromJson(jsonDecode(estado));

    print(estadosModel);

    for (EstadosModel estado in estadosModel) {
      http.Response response = await http.get(Uri.parse(
          "https://brasilapi.com.br/api/ibge/municipios/v1/${estado.sigla}?providers=dados-abertos-br,gov,wikipedia"));
      List<CidadesModel> cidadesModel =
          CidadesModel.listFromJson(jsonDecode(response.body));
      File cidadesFile = File("lib/data/${estado.sigla}.json");
      String jsonCidades =
          jsonEncode(cidadesModel.map((e) => e.toJson()).toList());

      cidadesFile.writeAsStringSync(jsonCidades);
    }
  }

  FutureOr<Response> getAllCidadesFromCache(Request req, String estado) async {
    File estadosFile = File("lib/data/estados.json");
    File cidadesFile = File("lib/data/$estado.json");
    if (!estadosFile.existsSync() || !cidadesFile.existsSync()) {
      await EstadosController().getAllEstadosApiBrasil();
      await getAllCidadesFromApiBrasil();
    }
    String cidadesString = cidadesFile.readAsStringSync();

    List<CidadesModel> cidadesModel =
        CidadesModel.listFromJson(jsonDecode(cidadesString));

    return Response.ok(jsonEncode(cidadesModel), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader:
          "Access-Control-Allow-Origin, Accept"
    });
  }
}
