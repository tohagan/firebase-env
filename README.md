# Switch Firebase project instances for Test / Development / Staging / Production

## Setup
    
#### 1. Create a `keys` folder to contain project credentials and ensure it's excluded from GIT source control.

        $ mkdir ./keys
        $ echo keys/ >> .gitignore
    
#### 2.  Login to Firebase Console and create your Test / Development / Staging / Production projects

#### 3.  Generate and download service keys for each project.

    Save each Private Key file as a JSON file under file names that match their respective project-id.
    
    Example file names:

        ./keys/myapp-test.json
        ./keys/myapp-dev.json
        ./keys/myapp-stage.json
        ./keys/myapp-prod.json

![Download Service Key](service-keys.png)

#### 4.  Assign each project a local alias (saved in `.firebaserc` file)

        $ firebase use --add

Example `.firebaserc`

```
{
 "projects": {
   "test": "myapp-test",
   "dev": "myapp-dev",
   "stage": "myapp-stage",
   "prod": "myapp-prod"
  }
}
```

#### 5. For CI/CD (Travis/GitLab/CircleCI) you can configure a `$FIREBASE_TOKEN` variable and test script locally

Run this generated a new CI access token

        $ firebase login:ci 

Save the token to file `./keys/token`

## Use `firebase-env.sh` to switch Firebase project.

This script runs `firebase use <alias>` and then exports 
environment variables for this project so must be run with a ". " prefix.


        $ . ./firebase-env.sh [test|dev|stage|prod]

This will set the following environment variables that match those pre-configured on Firebase/GCP servers.

```
$GCLOUD_PROJECT
$GOOGLE_APPLICATION_CREDENTIALS
$FIREBASE_CONFIG
```

It will also set `$FIREBASE_TOKEN` for use in CI/CD scripts.

#### 6. Remove credentials and project specific values from your code.

Now your Cloud Functions code and CI scripts need not contain any references to credentials or project specific values.

```
import * as admin from 'firebase-admin';

// Uses $GOOGLE_APPLICATION_CREDENTIALS and $FIREBASE_CONFIG
const adminApp = admin.initializeApp();  
```

```

// adminApp.options: AppOptions contains all your project settings

  interface AppOptions {
    credential?: admin.credential.Credential;
    databaseAuthVariableOverride?: Object;
    databaseURL?: string;
    serviceAccountId?: string;
    storageBucket?: string;
    projectId?: string;
    httpAgent?: Agent;
  }

```


