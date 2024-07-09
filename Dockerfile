FROM golang:1.22.4-alpine as build

WORKDIR /application

COPY . .

RUN go mod download && go mod verify

RUN go build -o /application/journey ./cmd/journey/journey.go

FROM scratch

WORKDIR /application

COPY --from=build /application/journey /application/journey

EXPOSE 8080

ENTRYPOINT [ "/application/journey" ]