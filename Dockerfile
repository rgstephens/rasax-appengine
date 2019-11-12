# This file is for local testing of Rasa X (not server deployment)
# . .env
# docker build --build-arg vers=${RASA_X_VERSION} -t rasax:${RASA_X_VERSION} .
# docker build --build-arg vers=0.22.1 -t rasax:0.22.1 .
# docker build --no-cache --build-arg vers=0.21.5 -t rasax:0.21.5 .
# docker build --no-cache --build-arg vers=${RASA_X_VERSION} -t rasax:${RASA_X_VERSION} .
# docker-compose -f docker-compose-local.yml up
# docker run -v $(pwd):/app -p 8080:5002 --rm rasax/appengine:0.21.5
# export RASA_X_VERSION=0.22.2
# docker build --build-arg RASA_X_VERSION=${RASA_X_VERSION} -t stephens/rasax-appengine:${RASA_X_VERSION} .
FROM python:3.6

ARG RASA_X_VERSION=0.22.2

RUN echo "RASA_X_VERSION: $RASA_X_VERSION"

RUN if [ "$vers" != "stable" ] ; then echo rasax==$RASA_X_VERSION ; else echo rasax=stable ; fi

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      wget \
      curl \
      sudo \
      python

RUN curl -sSL -k "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py

# install rasa
#RUN pip install rasa-x==$vers --extra-index-url https://pypi.rasa.com/simple
RUN if [ "$RASA_X_VERSION" != "stable" ] ; then pip install rasa-x=="$RASA_X_VERSION" --extra-index-url https://pypi.rasa.com/simple ; else pip install rasa-x --extra-index-url https://pypi.rasa.com/simple ; fi

VOLUME ["/app"]
WORKDIR /app

# expose port for rasa server
EXPOSE 5005

# expose port for rasa X server
EXPOSE 5002

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

#CMD ["rasa", "x"]
#CMD ["rasa", "start", "--actions", "actions.actions"]
CMD rasa x --no-prompt --endpoints endpoints.yml --credentials credentials.yml --port 5005 --cors "*" --debug
