# build stage 1
FROM golang:1.8 AS builder

WORKDIR /app

COPY hello.go .

RUN go build -o hello .

# build stage 2
# The scratch image is the most minimal image in Docker. This is the base ancestor for all other images.
# It is essentially an empty image with no file system, no package manager, and no shell.
# It is used to build images that are as small as possible.
FROM scratch

COPY --from=builder /app .

# This is because the resulting image does not have a shell to execute the image.
# So we cannot use ./hello to run the image. We need to use ENTRYPOINT or CMD with a JSON array of string to run the image.
ENTRYPOINT ["./hello"]
