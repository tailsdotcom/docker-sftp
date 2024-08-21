[![Docker build](https://github.com/tailsdotcom/docker-sftp/actions/workflows/ci.yml/badge.svg)](https://github.com/tailsdotcom/docker-sftp/actions/workflows/ci.yml)

# sftp-alpine
This is a fully functional SFTP/SSH server for the cost of only 17.7MB! 

The default configuration has a non-privileged user `testuser` with password `tiger` and is exposed on port 2222.

### Example Usage
===
The following command will use physical port `2222`, detach the container to run in the background, and name the container `sftp`:
```
$ docker run -p 2222:2222 -d --name sftp tailsdotcom/docker-sftp
```
