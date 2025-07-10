FROM openjdk-11-jre

WORKDIR /app

COPY package*.json

RUN apt update -y

COPY . .

EXPOSE 3000

ENV 

LABEL

CMD ["." ,"."]

`````````````````````````````````````````````````````````
