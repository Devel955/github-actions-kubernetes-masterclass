# Stage 1: Build
FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux \
    go build -trimpath -ldflags="-s -w" -o skillpulse .


# Stage 2: Runtime
FROM alpine:3.23

RUN addgroup -S skillpulse && \
    adduser -S skillpulse -G skillpulse

WORKDIR /app

COPY --from=builder /app/skillpulse ./skillpulse
RUN chown -R skillpulse:skillpulse /app

USER skillpulse

EXPOSE 8080

ENTRYPOINT ["./skillpulse"]
