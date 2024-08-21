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
FROM alpine
RUN adduser -DH user

WORKDIR /tmp

COPY --from=base /app/app /usr/local/bin
COPY --chown=user:users id_rsa /srv/id_rsa
COPY --chown=user:users id_rsa.pub /srv/id_rsa.pub

# Run as non-root user
RUN chmod +x /usr/local/bin/app
RUN chown user:users /usr/local/bin/app

# set environment variables
ENV PORT=2222

# set user for app
USER user

CMD /usr/local/bin/app