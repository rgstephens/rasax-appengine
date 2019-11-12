# Rasa X on Google AppEngine

Follow the [quickstart instructions](https://cloud.google.com/appengine/docs/flexible/custom-runtimes/quickstart) for setting up the Google AppEngine SDK.

```
gcloud compute firewall-rules create rasa-x --allow tcp:5002-5055
gcloud compute firewall-rules create allow-5002 --allow tcp:5002 --target-tags http-server
gcloud compute firewall-rules create allow-5005 --allow tcp:5005 --target-tags rasa-server
gcloud app --project rasa-x-greg instances enable-debug
gcloud app deploy
```

The deploy command should give you output similar to this:

```
Creating App Engine application in project [rasa-x-greg] and region [us-west2]....done.                                                                                                           
Services to deploy:

descriptor:      [/Users/greg/Dev/appengine/rasax/app.yaml]
source:          [/Users/greg/Dev/appengine/rasax]
target project:  [rasa-x-greg]
target service:  [default]
target version:  [20191111t142033]
target url:      [https://rasa-x-greg.appspot.com]
```

You should then see the Docker build execute and if all goes well you should be able to browse to the Rasa X UI.

# Google Cloud URL's

* [Instances Page](https://console.cloud.google.com/appengine/instances?_ga=2.180007842.-761914247.1573508558)
* [Container Logs](https://console.cloud.google.com/logs/viewer)

# Docker Hub

stephens/rasax-appengine:0.22.2
stephens/rasax-appengine:0.21.5



