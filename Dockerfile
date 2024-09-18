
FROM gradle:8.10.0-jdk22 AS builder
ENV LANG='sv_SE.UTF-8' LANGUAGE='sv_SE:sv'
WORKDIR /app
COPY . .
RUN gradle assemble
# should be a specific version in order to have a deterministic build
FROM cgr.dev/chainguard/jre:latest
ENV LANG='sv_SE.UTF-8' LANGUAGE='sv_SE:sv'
EXPOSE 8080
USER 1001
COPY --from=builder /app/build/libs /deployments/libs/
ENTRYPOINT [ "java","-jar","/deployments/libs/eudi-srv-web-verifier-endpoint-23220-4-kt-0.1.5-SNAPSHOT.jar" ]