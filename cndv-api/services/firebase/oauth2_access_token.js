require('dotenv').config({path:'../../env/qa.env'});
const https = require('https');
const { google } = require('googleapis');

const PROJECT_ID = 'cndvqa';
const HOST = 'fcm.googleapis.com';
const PATH = '/v1/projects/' + PROJECT_ID + '/messages:send';
const MESSAGING_SCOPE = 'https://www.googleapis.com/auth/firebase.messaging';
const SCOPES = [MESSAGING_SCOPE];

/**
 * Get a valid access token.       //const key  = require('./service-account.json');
 */
function getAccessToken() {
    const firebase_email = process.env.FIREBASE_CLIENT_EMAIL;
    const firebase_private_key = process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/gm, '\n');
    return new Promise(function(resolve, reject) {
       const jwtClient = new google.auth.JWT(
           firebase_email,
           null,
           firebase_private_key,
           SCOPES,
           null
       );
       jwtClient.authorize(function(err, tokens){
           if (err) {
               reject(err);
               return;
           }
           resolve(tokens.access_token);
       });
    });
}

/**
 * Send HTTP request to FCM with given message
**/
function sendFcmMessage(fcmMessage) {
    getAccessToken().then(function(accessToken){
        const options = {
            hostname: HOST,
            path: PATH,
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + accessToken
            }
        }

        const request = https.request(options, function(resp){
            resp.setEncoding('utf8');
            resp.on('data', function(data){
              console.log('Message sent to Firebase for delivery, response:');
              console.log(data);
            })
        });

        request.on('error', function(err){
            console.log('Unable to send message to Firebase');
            console.log(err);
        });

        request.write(JSON.stringify(fcmMessage));
        request.end();
    });
}

function buildCommonMessage() {
    return {
        'message': {
            'topic': 'campanhas',
            'notification': {
                "title": "Campanha Vacinação Covid-19 Barueri",
                "body": "Campanha Vacinação COVID-19 para pessoas de 70 a 80 anos em Barueri, veja onde você pode vacinar."
            }
        }
    };
}

function buildToUniqueDeviceTokenMessage(messageTitle, messageBody, userDeviceUniqueToken){
    return {
        "message": {
            "data": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "title": messageTitle,
                "body": messageBody
            },
            "notification": {
                "title": messageTitle,
                "body": messageBody
            },
            "android":{
                "priority":"high"
            },
            "token": userDeviceUniqueToken
        }
    }
}

module.exports = {
    buildCommonMessage,
    sendFcmMessage,
    buildToUniqueDeviceTokenMessage
};