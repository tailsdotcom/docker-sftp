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

# Generate keys
FROM alpine AS keygen
RUN   apk update && \
      apk add --no-cache \
      openssh-keygen

# to-do: make it generate keys automatically

# Deploy: Copy apps into deployment container
FROM alpine
RUN adduser -DH user

COPY --from=base /app/app /usr/local/bin
COPY --chown=user:users id_rsa /id_rsa
COPY --chown=user:users id_rsa.pub /id_rsa.pub

# Run as non-root user
RUN chmod +x /usr/local/bin/app
RUN chown user:users /usr/local/bin/app

# set environment variables
ENV PORT=2222

# set user for app
USER user

CMD /usr/local/bin/app