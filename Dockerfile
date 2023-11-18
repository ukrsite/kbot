# Use a smaller base image for the final stage
FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . . 
RUN make build

# Use a minimal base image for the final stage
FROM scratch

# Copy only necessary files
COPY --from=builder go/src/app/kbot .

# Copy the CA certificates from the builder stage
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["./kbot", "start"]