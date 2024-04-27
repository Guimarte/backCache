import 'dart:io';

import 'package:backend_cidades/controllers/cidades_controller.dart';
import 'package:backend_cidades/controllers/estados_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router();

void main() async {
  final ip = InternetAddress.anyIPv4;
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  final CidadesController cidadesController = CidadesController();
  final EstadosController estadosController = EstadosController();

  router.get(
      "/buscar-cidades/<estado>", cidadesController.getAllCidadesFromCache);
  router.get(
      "/buscar-estados", estadosController.getAllEstadosFromCache);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);

  print('Server listening on port ${server.port}');
}
