import 'package:bit_ascol/screens/Home/fetchDataWithRetry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retry/retry.dart';

Future<void> fetchDataWithRetry() async {
  final r = const RetryOptions(maxAttempts: 12);

  await r.retry(
        () => fetchData(),
    retryIf: (e) => e is FirebaseException,
  );
}
