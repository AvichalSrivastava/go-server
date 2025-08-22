# Stage 1: Build the Go binary
FROM golang:1.24.6 AS builder

# Set working directory
WORKDIR /app

# Copy go files
COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build binary
RUN go build -o main .

# Stage 2: Run the binary in a small image
FROM alpine:latest

WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/main .

# Expose service port (change if needed)
EXPOSE 8080

# Run the service
CMD ["./main"]