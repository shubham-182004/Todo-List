FROM tomcat:9.0-jdk11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file
COPY ROOT.war /usr/local/tomcat/webapps/

# Set environment variables for DB connection (override at runtime)
ENV DB_URL=jdbc:mysql://db:3306/todo_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV DB_USER=root
ENV DB_PASSWORD=root

EXPOSE 8080
