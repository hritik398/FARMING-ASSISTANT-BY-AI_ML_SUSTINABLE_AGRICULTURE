import 'package:firebase_database/firebase_database.dart';


class IotService {
/// Expected Realtime DB path structure:
/// sensors/{deviceId}/{timestamp}:{ temperature:.., humidity:.., moisture:.. }
static final _db = FirebaseDatabase.instance.ref();


static Stream<DatabaseEvent> sensorStream(String deviceId) {
return _db.child('sensors').child(deviceId).limitToLast(1).onValue;
}
}
