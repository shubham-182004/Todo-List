# Stage 1: Compile
FROM eclipse-temurin:11-jdk-jammy AS builder

WORKDIR /app
COPY src ./src
COPY WebContent ./WebContent

# Download a proper servlet API jar for compilation
RUN apt-get update && apt-get install -y wget && \
    wget -q https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar \
    -O /servlet-api.jar

# Compile Java files
RUN mkdir -p build/classes && \
    javac \
    -cp /servlet-api.jar:WebContent/WEB-INF/lib/jsp-api-2.2.jar:WebContent/WEB-INF/lib/jstl-1.2.jar:WebContent/WEB-INF/lib/mysql-connector-java-8.0.13.jar \
    -d build/classes \
    $(find src -name "*.java")

# Package WAR
RUN cp -r WebContent/. build/ && \
    cp -r build/classes/. build/WEB-INF/classes/ && \
    cd build && jar -cvf /ROOT.war .

# Stage 2: Run
FROM tomcat:9.0-jdk11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /ROOT.war /usr/local/tomcat/webapps/ROOT.war

ENV DB_URL=jdbc:mysql://db:3306/todo_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV DB_USER=root
ENV DB_PASSWORD=root

EXPOSE 8080
