FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/demo0.0.1.jar /app/
EXPOSE 9090
CMD [ "java",".jar","demo0.0.1.jar" ]
