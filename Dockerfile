FROM maven:3.6.1-jdk-8-slim@sha256:608e3a23cbeb210b5537e4bf51a1c31fe99887b83b49f3a68eb3e9fcd2eb3418 as build

WORKDIR /usr/src/app

#RUN mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
#COPY pom.xml .
#RUN mvn package

COPY . .
RUN mvn package

RUN cd target && ls -l *.jar && sha256sum *.jar

FROM scratch as export

COPY --from=build /usr/src/app/target/*.jar /
