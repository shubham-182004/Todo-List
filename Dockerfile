FROM tomcat:9.0-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*
RUN apt-get update && apt-get install -y default-jdk && rm -rf /var/lib/apt/lists/*

COPY src /app/src
COPY WebContent /app/WebContent

WORKDIR /app
RUN mkdir -p build/classes && \
    javac -cp WebContent/WEB-INF/lib/servlet-api-2.5.jar:WebContent/WEB-INF/lib/jsp-api-2.2.jar:WebContent/WEB-INF/lib/jstl-1.2.jar:WebContent/WEB-INF/lib/mysql-connector-java-8.0.13.jar \
    -d build/classes \
    $(find src -name "*.java") && \
    cp -r WebContent/. build/ && \
    cp -r build/classes/. build/WEB-INF/classes/ && \
    cd build && jar -cvf /usr/local/tomcat/webapps/ROOT.war .

ENV DB_URL=jdbc:mysql://db:3306/todo_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV DB_USER=root
ENV DB_PASSWORD=root

EXPOSE 8080
