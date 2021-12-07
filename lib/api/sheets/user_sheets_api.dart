import 'package:gsheets/gsheets.dart';
import '../../model/user.dart';

class UserSheetApi {
  static const _crededntials = r'''
  {
  "type": "service_account",
  "project_id": "christmas-register-2021",
  "private_key_id": "554801926ec67232095851069783f93462dff9ec",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDlsjAaEetkI6IZ\nDfL1K9naqM6o9bPwey8+aLElBtZjLjAeSeU/kWmRH4TO8xWVWj5rW1PEFerhCTnt\n62s/GpHIhnYRBbh1NMuw5p5vUBhavhj5FJ3cegnRBQzfMCUeblaVhRg3RGqa0zYQ\nnwoJt0l8/ywi+9KuB1ZKm/E4IHSFMuovdrAKWujIcx0X+8aikdZan3aN4QTZQVUO\nSjlidZxviqIqT8J8v8P3wdNAQggfpNof9O9Wk4v60gLSfE6/SSHtmm07A7hBZTDU\n26bZvwOOPY40Vm66HUYSnl10rCiFqTvcEyvDog75gjTAl6QQ+SaLbNfLFR7+y1TI\nEkxJoA5jAgMBAAECggEAD9eCScoCmh17CI9VumMT22jZF/4aMvPMBlniHdOi5aRB\n3VTrYr78sO2jk0JgsrROqcjatiNs16hzPl2GQAvtEg90BSiH2E2T3teJBdRYWanS\nvxsU6CfilW/ru1jutnKVtio/yVAGqjb2+558ar8hamWO/bqwhSAsa2jl8iEK6ETB\nPKT2fBC47udgnxhssIPx4wSYb3KWjdO/e1pMBYP4C02aPEsoSn1iJ6/nCcHw4JlG\n/ALhfR3yk2jQsDIMqBtkrH3PERwUMV1h1LeRJ5v8+2MNBiuJnGc1nmZ72oI1E+GP\ndOunTvMtzgMYGvrSCewxuSdwi47TjIHoUcR4J/NywQKBgQD4XSCiG9OGm7VMcRqN\njVTFbYWydPM7spgq2rwAAHDabk/zba0fgkCcNNUA3CvSVDQytZLg9p0qakbG1pQQ\ntwZsHFhhIsvkF637S1A1SyINAvSXf5xR/lc/YaTb8jvXfiwfwH6srGAfhs13/XP5\nhczRQKetBMK5BvgX8zRN2H1+tQKBgQDswiBpZjEDC6XT6PkF1GjhaOHW5gK9zNEw\nmH7asjekmD5yXhXqs338bhRQQgyLvUWiIcglB6PvTqcYIc/0DiXk8jGIwfOQV9em\nsVaNPh+l7ZrzdxLuhVr7C9CZd6yaFhChZ4Y1/qZA8Cm+OwteJ5eCwIJ3LanljX3I\nLWcsaFJvtwKBgQD1+e3W/64oM9CEK8R7iwz5F3aBfvhjGIdCci4d5lHe08AVPHto\nqGzrCBwpZOV1wvWLf28/pJ+VoXoFdgFg6JPQwOX7FiZO+fDS4A1JKudHcbTi0nz0\na+znFgLb3vXLf+edbt1GkNYGg1C91ORmrVBjsiAe6IceDzvpJHKZ4p6vvQKBgG0C\niOfenIx5bXXfm+D6RvwaTXmj1/lJ97t3S1kom4QWcRI5jb/NuyFiEcpOTvZ8RDZ9\ndWjPVsTVowvybYxCg2IhvXrpSlrYhzuCBYbs5qeAekrFNZtLHXPfocE3n+omZKvc\nPahYwnW93opvJzHH6vPR7YAwLzy5ZAOqHAoPUn2LAoGBAPbyaiAh2IYyxw7CsMR/\nTPA5C5Si6bFLkYW2BJ/WLNceBO9EZeTlp2iMGdyab+eXD7na95HWqWS+2vyVREiG\ni2PtpJ9QHvUWlspkZoALfFzxfxbKRMks0JcGWbsOPY1hnrp5yVgsnBN3LQERfW3C\nbF1oWPsbMTO9xi+GMlFNSwlF\n-----END PRIVATE KEY-----\n",
  "client_email": "fevchristmas@christmas-register-2021.iam.gserviceaccount.com",
  "client_id": "102658080750055187770",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fevchristmas%40christmas-register-2021.iam.gserviceaccount.com"
}
  ''';
  static final _spreadsheetId = '1ec81tmGKS-mkEeJip78mkgdNrxRXb9Cex_Tc6fG6OtE';
  static final _gsheets = GSheets(_crededntials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'register');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}