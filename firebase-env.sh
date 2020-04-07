## Switch Firebase project (environment)
# Usage: $ . ./firebase-env.sh [test|dev|stage|prod]

# Info:
# - https://firebase.google.com/docs/functions/config-env
# - https://medium.com/google-cloud/firebase-separating-configuration-from-code-in-admin-sdk-d2bcd2e87de6

[ -z "$1" ] || firebase use $1

export FIREBASE_TOKEN=`cat keys/token`
export GOOGLE_CLOUD_PROJECT=`firebase use`
export GOOGLE_APPLICATION_CREDENTIALS=`realpath keys/$GCLOUD_PROJECT.json`
export FIREBASE_CONFIG=`realpath ./config.json`

## config.json (add to .gitignore)
cat >./config.json <<!
{
  "databaseURL": "https://${GOOGLE_CLOUD_PROJECT}.firebaseio.com",
  "projectId": "${GOOGLE_CLOUD_PROJECT}",
  "storageBucket": "${GOOGLE_CLOUD_PROJECT}.appspot.com"
}
!

cat <<!
GOOGLE_CLOUD_PROJECT=$GOOGLE_CLOUD_PROJECT
GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS

FIREBASE_TOKEN set
FIREBASE_CONFIG=$FIREBASE_CONFIG
!
cat config.json
