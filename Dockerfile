# Stage 1: Compile
FROM eclipse-temurin:11-jdk-jammy AS builder

WORKDIR /app
COPY src ./src
COPY WebContent ./WebContent

# Step 1: Make output dir
RUN mkdir -p build/classes

# Step 2: Compile Java files
RUN javac \
    -cp WebContent/WEB-INF/lib/servlet-api-2.5.jar:WebContent/WEB-INF/lib/jsp-api-2.2.jar:WebContent/WEB-INF/lib/jstl-1.2.jar:WebContent/WEB-INF/lib/mysql-connector-java-8.0.13.jar \
    -d build/classes \
    $(find src -name "*.java")

# Step 3: Copy WebContent into build
RUN cp -r WebContent/. build/

# Step 4: Copy compiled classes into WEB-INF
RUN cp -r build/classes/. build/WEB-INF/classes/

# Step 5: Package WAR
RUN cd build && jar -cvf /ROOT.war .

# Stage 2: Run
FROM tomcat:9.0-jdk11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /ROOT.war /usr/local/tomcat/webapps/ROOT.war

ENV DB_URL=jdbc:mysql://db:3306/todo_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV DB_USER=root
ENV DB_PASSWORD=root

EXPOSE 8080
