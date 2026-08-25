import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

Future<http.Client> createSslPinningClient() async {
  final sslCert = await rootBundle.load('assets/certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

  HttpClient httpClient = HttpClient(context: securityContext);
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;

  return IOClient(httpClient);
}