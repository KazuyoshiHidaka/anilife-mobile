const functions = require('firebase-functions');
const firestore = require('@google-cloud/firestore');
const admin = require('firebase-admin');
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: 'https://anilife-mobile.firebaseio.com',
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.animeNotify = functions.pubsub
  .schedule('* * * * *')
  .onRun(async (context) => {
    const _firestore = admin.firestore();
    const _timeNow = new Date();
    const _timeStamp = firestore.Timestamp.fromDate(
      new Date(
        _timeNow.getFullYear(),
        _timeNow.getMonth(),
        _timeNow.getDate(),
        _timeNow.getHours(),
        _timeNow.getMinutes(),
      ),
    );
    const _data = _firestore
      .collectionGroup('animes')
      .where('notifyTime', '==', _timeStamp);

    await _data.get().then((querySnapshot) => {
      querySnapshot.forEach(async (doc) => {
        if (querySnapshot.empty) {
          console.log('No matching documents.');
          return;
        }

        const _uid = doc.ref.parent.parent.id;
        const anime = doc.data();
        var time = anime['time'].toDate();
        var notifyTime = anime['notifyTime'].toDate();
        const notifyRepeatIntervalDayCount =
          anime['notifyRepeatIntervalDayCount'];

        var message = {
          notification: {
            title: `${anime['title']}`,
            body: `このあと${time.getHours()}時${time.getMinutes()}分から！`,
          },
          topic: `/topics/${_uid}`,
        };

        await admin
          .messaging()
          .send(message)
          .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
          })
          .catch((error) => {
            console.log('Error sending message:', error);
          });

        if (notifyRepeatIntervalDayCount > 0) {
          await doc.ref.update({
            notifyTime: new Date(
              notifyTime.setDate(
                notifyTime.getDate() + notifyRepeatIntervalDayCount,
              ),
            ),
            time: new Date(
              time.setDate(time.getDate() + notifyRepeatIntervalDayCount),
            ),
          });
        } else {
          await doc.ref.delete();
        }
      });
    });
    return null;
  });
