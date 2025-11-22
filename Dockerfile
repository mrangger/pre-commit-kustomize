FROM alpine:3.21
RUN apk add --no-cache git kustomize helm openssh

# Copy only necessary files and set permissions
COPY --chmod=755 ./bin/kustomize-build /bin/kustomize-build

# Use a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV PATH=/bin:$PATH
WORKDIR /src
