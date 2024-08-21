FROM docker.io/library/golang:alpine AS base

# set Go envvars
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# set code location and build app
WORKDIR /app
ADD src/ /app
RUN go build -o app

# Deploy: Copy apps into deployment container
FROM docker.io/library/golang:alpine
RUN adduser -DH user

COPY --from=base /app/app /usr/local/bin

# Run as non-root user
RUN chmod +x /usr/local/bin/app
RUN chown user:users /usr/local/bin/app

# set environment variables
ENV PORT=22

# set user for app
USER user

CMD /usr/local/bin/app