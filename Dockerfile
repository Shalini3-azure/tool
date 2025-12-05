# Stage 1: Build the JAR
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn -q -DskipTests package


# Stage 2: Run the application
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar from the builder stage
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
