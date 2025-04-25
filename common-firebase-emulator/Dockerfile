FROM node:20-bullseye-slim

RUN apt update -y && apt install -y openjdk-11-jdk bash procps

RUN npm install -g firebase-tools


WORKDIR /firebase

COPY ./firebase.json ./
COPY ./.firebaserc ./
COPY ./firestore.rules ./
COPY ./storage.rules ./
COPY ./database.rules.json ./
COPY ./firestore.indexes.json ./
COPY ./entrypoint.sh ./
COPY ./data /firebase/data
# somehow the docker didn't see entrypoint.sh if I just copy it from the source folder however it does exist when checking with `ls la`
RUN chmod +x /firebase/entrypoint.sh

ENTRYPOINT ["/firebase/entrypoint.sh"]
