FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11
RUN apk add --no-cache git kustomize helm openssh

# Copy only necessary files and set permissions
COPY --chmod=755 ./bin/kustomize-build /bin/kustomize-build
COPY --chmod=755 ./bin/check-yaml-extension /bin/check-yaml-extension

# Use a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV PATH=/bin:$PATH
WORKDIR /src
