import 'package:gsheets/gsheets.dart';
import '../../model/user.dart';

class UserSheetApi {
  static const _crededntials = r'''
  {
  "type": "service_account",
  "project_id": "fevxmas2021",
  "private_key_id": "bc2403b93dadaf3d9bdcb7dd240e0e8a0a0d9e55",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCnYZiSxPDLEhRM\nvi9QG03kPnxriWkpoKnpOnDUFdC48l61HtGcXD0yRl81PWTZ8ohJyJ1roDF2YFIV\nsMiyFyiu+Shhf6wi8z3SDtU2B16V4txU7N61UTWFn8x1S77ZAX+kcYVaeDAmnl26\nMOK8ka8VMosukyCQs5MO6c5lXNVIoMXatUZhrCUuiy+DZuYEy0NeBSjmOQ12140C\naQKMWvm5Pz+DTgz1iQKx4/1YVB1Ur8LxuicZQ2XzZx6BAC+fQRtmSs5YR+jELsoO\nCJ+60ao5BsfKtwbEA6DwaZpchYpTkVeBgwR3yCd69Rgt+nFOSo02idJvHPyc8kDA\nogLzREh/AgMBAAECggEAIf2620ttTv/76V3SA+WXmttprvj3x0FeYAPDN/66JWTr\nAMMidCtzLguGeCxgl7YeIUXBWkLs6IpFASymhSwY0fe9UJd54JsfGdJzUAaNGck5\nT3HPBGlagilifwuD1VPtlPqMx0OTG7Sbeh1FXmADez2JcErmmRwuqB+pD4KbuaTA\ncWzfR8mRxNjTnj+N8hazH0Vaer8xAbIIGAY2jtxCRoSC/9OVFwqxodgVPgO2vNgZ\nudP7088RRlEhA6DEXUkBiPp33Hiv0+7OM8hlxsWkDtyN8IgQTApWFjtl8YrKYBLd\nSxC1i22U8g8f9JCKobzLQqdnWx6a75YA69r7Wk0VIQKBgQDbb5hNTScdgiy7DE31\nSXa07t1ZLJlO4FQn/6X2ScyLcr3WFRsYEY8zCAVPoPce0ar/9dF5FH6U+JEec4+t\nxgwWwtpeQz0OTTbL/rXfGsBdl0V8y7BFvS1XRpZIRYe85wyXPVBuAhKhVDkEXZ/6\nz3UDJ5pIVFDralOZ/xDd/phGLwKBgQDDRYWPVQSRNy1gkx6hVguJLv9Onf1PC7ZG\nhaagXm56iFAaMc8SAB7135RpAbBEiTwSI0nrepENlQ4kH3x4uuKtFJ5V+zflb6DC\nNUgkpQDCqwO8Hb6qBP9fGX7CgDtWTbMGDX4wbyXA8NE8WSTU5V5IHJ5KSrF7suZZ\noEXaqhHesQKBgQDCAlVeqwMVVN1ldwiKAKzCZZowWH0nPrFJN/8s1KzS8dyjpb9x\ntTyter7vWzqB9hBBA75zVcpgva/Yg4WZt0tC6H4W703REjWLgKSeH9HKLY+TOaec\n0RiAXHlMZqUPQBxiryQoTw7XslZC5OAn6TnkUyRWJK3ypexKcDgifhF1owKBgQDC\nokoU6q3pvHC7YQjX0PcgnrqVdv5kSo09T7wc/uLpuXL2GQ2HqJ0zf83iuG8kcRFy\nFsB4OSvZuOdmdAfSIp0L3ZBQrV0ykIhQ62DkPZ87adAIMjG4L9EGzle9sKj0RfAa\nKVrNFgwwexhjKYt/tLu77uKLtFWhsVjOnuThpkC3kQKBgQDNAwnjphTJ4aLF1j8V\njcazlauAezE3MzRz3J0WduUDwXaUAV9Ftn0DH4CXhMCACWMGkiOVjyjcnd5Yy2kT\nBxAZEaibjbmat91e6Vf8xWbDXCApyNvU9QwSfw2MptAHVmV0Cvc+Qy6aPHIAZLlJ\nUbm+brMMviQ3tDe4FjS+CPBZ3w==\n-----END PRIVATE KEY-----\n",
  "client_email": "fevxmas@fevxmas2021.iam.gserviceaccount.com",
  "client_id": "117763968760766986126",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fevxmas%40fevxmas2021.iam.gserviceaccount.com"
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