import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as applicationDefault from "firebase-admin/app";
/* import * as gcs from "@google-cloud/storage"; */


admin.initializeApp({
  credential: applicationDefault.applicationDefault(),
  storageBucket: "online-tribes-6a28c.appspot.com",
});


export const addMessage = functions.https.onRequest(async (req, res)=>{
// Grab the text parameter.
  const original = req.query.text;


  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await admin.firestore()
      .collection("messages").add({original: original});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});

// uppercase version of the message to /messages/:documentId/uppercase
exports.makeUppercase = functions.firestore.document("/messages/{documentId}")
    .onCreate((snap, context) => {
      const original:string = snap.data().original;

      // Access the parameter `{documentId}` with `context.params`
      functions.logger.log("Uppercasing", context.params.documentId, original);

      const uppercase = original.toUpperCase();

      // You must return a Promise when performing asynchronous
      // tasks inside a Functions such as
      // writing to Firestore.
      // Setting an 'uppercase' field in Firestore document returns a Promise.
      return snap.ref.set({uppercase}, {merge: true});
    });
// uppercase version of the message to /messages/:documentId/uppercase

exports.deleteUserFiles = functions.firestore
    .document("USERS/{userID}")
    .onDelete(async (snap) => {
      const deletedValue = snap.data();

      await deleteUserData(deletedValue.userId);
    });


const deleteUserData = async (id:string) => {
  const bucket = admin.storage().bucket();

  // Grab the id parameter.
  const folder = `USERS/${id}/`;
  await bucket.deleteFiles({
    prefix: `${folder}`,
  });
  console.log({result: `delete user files with id ${id}`});
};

/* exports.resizeVideo = functions.storage.object().onFinalize((object) => {
  const filePath = object.id;
   const isVideo = object.contentType?.startsWith("video");
  if (filePath.startsWith("online-tribes-6a28c.appspot.com/USERS/tmp/") && isVideo) {

  }
  return true;

}); */
exports.resizingVideo = functions.firestore.document("USERS/{userID}").onUpdate(async (snap, context)=>{
  const path = require('path');
  const os = require('os');
  

  const data = snap.after.data();

  const baseUrl = data.intro_video_url.metaData.fullPath;
  const name =  data.intro_video_url.metaData.name;

  const tempPath = path.join(os.tmpdir(), name);

  await admin.storage().bucket().file(baseUrl).download({destination: tempPath});

  console.log('Image downloaded locally to', tempPath);

}
)


