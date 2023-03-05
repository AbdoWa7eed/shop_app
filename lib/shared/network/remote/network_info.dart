import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
