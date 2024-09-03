import 'package:flutter/material.dart';
import 'package:vnpt_ekyc/vnpt_ekyc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Running on:'),
            FilledButton(
              onPressed: () async {
                final data = await VnptEkycPlatform.instance.extractEKYC(
                  'bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhYTVlNGU2OS01NGRmLTExZWMtYjMzOS0xZjczYjNlMTAwYTciLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoiaHV5Lm5ndXllbkBoYXBpLnNvbHV0aW9ucyIsInNjb3BlIjpbInJlYWQiXSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3QiLCJuYW1lIjoiaHV5Lm5ndXllbkBoYXBpLnNvbHV0aW9ucyIsImV4cCI6MTcyNDE1MTU0MSwidXVpZF9hY2NvdW50IjoiYWE1ZTRlNjktNTRkZi0xMWVjLWIzMzktMWY3M2IzZTEwMGE3IiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiJkZmZhY2VjYi1hOWMzLTRlNzItOTFmMy01ODIzMzBhMjUxOGQiLCJjbGllbnRfaWQiOiI4X2hvdXIifQ.jFgyqUcIchgcILuL6P4ZKXsfqjMzqOl6OajnkRZpAkX9FDBB8IpEYiAurD6TeV6pA8u-K2QO84QPkgpHErQaqKgZeL_C5a7lc2ZuagmcuVneMqCfgnt_vecovOBEjDgGnzVMUjpU1_y_EffiGPFsway2WCxB-APGaPMLWzYZePAqVWCUk0vgRhugaWV1X-yPjBEKMDvBrONMe0dZlTw3GPny5cH9u5-aG99ozgd_InWEAWjxdIYemHJzxl9u6ZiYH0e0a22TMZ4CWNwCduFL6e3W4sdc8NOhdN0sCCn5uc0MgyJeyM0Xjm7OSR9X6fRBfD4TR-kjbS9kMat5pRgnYQ',
                  'd24f2ace-e494-4c06-e053-63199f0a6f97',
                  'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAI+waDo0v7oMdgDTPPjnfnn7MMwHvt4rCw0nyS0ft5LwCHceDcJ60Ndv+m/zWeLMM3kEiZdzhmm/T3FdhGK5qHUCAwEAAQ==',
                  language: 'en',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(data.toString()),
                  ),
                );
              },
              child: const Text('Extract EKYC'),
            ),
          ],
        ),
      ),
    );
  }
}
