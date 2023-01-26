FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/
EXPOSE 9090
CMD [ "java",".jar","demo-0.0.1.jar" ]
