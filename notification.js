const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
  .document('messages/{message}')
  .onCreate((snap, context) => {
    console.log('---start function---')

    const doc = snap.data()
    console.log(doc)

    //const idFrom = doc.idFrom
    //const idTo = doc.idTo
   
    const chatroomId = doc.chatroomId
    const senderid = doc.senderid
    var fields = chatroomId.split('-')
    var firstId = fields[0]
    var secondId = fields[1]
    var idTo
    var idFrom
    

    if(senderid === firstId){
        idTo = firstId
        idFrom = secondId
    }
    else{
        idTo = secondId
        idFrom = firstId
    }

    const contentMessage = doc.message

    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('id', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log(`Found user to: ${userTo.data().nickname}`)
          if (userTo.data().pushToken) {
            console.log(`PushToken: ${userTo.data().pushToken}`)
            // Get info user from (sent)
            admin
              .firestore()
              .collection('users')
              .where('id', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().nickname}`)
                  const payload = {
                    notification: {
                      title: `You have a message from "${userFrom.data().nickname}"`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })
