FROM alpine:3.7

RUN apk -U add ca-certificates

EXPOSE 8080

ADD awesome-cicd-linux-amd64 /usr/local/bin/awesome-cicd

CMD ["awesome-cicd"]
