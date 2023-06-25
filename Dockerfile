# syntax=docker/dockerfile:1
FROM golang:1.19

WORKDIR /app

# Dependencies + checksum
COPY go.mod go.sum ./

# Install them
RUN go mod download

# Copy project
COPY . ./

# Build package
RUN cd cmd/ && CGO_ENABLED=1 GOOS=linux go build --ldflags "-s -w" -o ../docker-emyt

EXPOSE 9999
EXPOSE 9000

CMD [ "/app/docker-emyt" ]
