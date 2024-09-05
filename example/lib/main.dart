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
                  'bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhYTVlNGU2OS01NGRmLTExZWMtYjMzOS0xZjczYjNlMTAwYTciLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoiaHV5Lm5ndXllbkBoYXBpLnNvbHV0aW9ucyIsInNjb3BlIjpbInJlYWQiXSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3QiLCJuYW1lIjoiaHV5Lm5ndXllbkBoYXBpLnNvbHV0aW9ucyIsImV4cCI6MTcyNTQwMDg1NSwidXVpZF9hY2NvdW50IjoiYWE1ZTRlNjktNTRkZi0xMWVjLWIzMzktMWY3M2IzZTEwMGE3IiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiIwN2RlNjQ1OC1mZmM4LTRjMzktYTIwMS1mOTdiYTNhYTY3NTAiLCJjbGllbnRfaWQiOiI4X2hvdXIifQ.XVJ9uV0bBk7OvMKhRdJC4Zwrc6tUImg2coduciVgr8T3QHbKfdSPkRywsZ0PI6HbcipNHZneDZdqVE7Zw8iIXlMcBKkbE9xbuH2Z2NI3z-nLuSaSAB57aaOSN-8vWcnqr1OBPEYsbWb869M2R2f6Rkta09D4EY-duTg2RwUDk_LUZ2voICLoMBbCd0dVw4XbK1q2yezpCl6-5NZy4d3Fnxxz6OFpwoOdmkTWnn40DQzaE--lti0LhdXzDKFx39Cpk116HyTdxPjzKUWDmJW3Q2AFBc4h-renI4f8WebG3hU3svum51oS-cNylEO6imoN7IBAyLny5EAZJ1jRXsqXhQ',
                  'd24f2ace-e494-4c06-e053-63199f0a6f97',
                  'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAI+waDo0v7oMdgDTPPjnfnn7MMwHvt4rCw0nyS0ft5LwCHceDcJ60Ndv+m/zWeLMM3kEiZdzhmm/T3FdhGK5qHUCAwEAAQ==',
                  language: 'en',
                );

                print(data);
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
