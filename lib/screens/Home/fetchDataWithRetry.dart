import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retry/retry.dart';

Future<void> fetchDataWithRetry() async {
  final r = RetryOptions(maxAttempts: 5);

  await r.retry(
        () => fetchData(),
    retryIf: (e) => e is FirebaseException,
  );
}

Future<void> fetchData() async {
  // Your data fetching logic here
  final notes = await FirebaseFirestore.instance.collection('pdfs').get();
  final data = await FirebaseFirestore.instance.collection('results').get();
  // Process data
}
