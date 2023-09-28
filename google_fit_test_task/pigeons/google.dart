import 'package:pigeon/pigeon.dart';


@HostApi()
abstract class GoogleApi{
  void search(Object keyword);
}