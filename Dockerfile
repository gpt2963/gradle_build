# Use CentOS 7 as the base image
FROM centos:7

# Set environment variables for Gradle and Java
ENV GRADLE_VERSION=8.6 \
    GRADLE_HOME=/opt/gradle \
    PATH=$PATH:/opt/gradle/bin \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk \
    PATH=$PATH:$JAVA_HOME/bin

# Install necessary tools and dependencies
RUN yum install -y wget unzip java-11-openjdk-devel && \
    yum clean all

# Download and install Gradle
RUN wget -q --no-check-certificate https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -q gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    rm gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle

# Set the working directory
WORKDIR /app

# Copy the Gradle project files
COPY build.gradle /app/
COPY src /app/src

# Build the WAR file using Gradle
RUN gradle clean build

# Command to run the application (if applicable)
# CMD ["java", "-war", "ROOT.war"]

