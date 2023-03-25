FROM openjdk:11
COPY target/*.jar banking-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","banking-0.0.1-SNAPSHOT.jar"]
