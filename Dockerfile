
#Use CentOS as the base image
FROM centos:7


# Set environment variables for Gradle
ENV GRADLE_VERSION=8.6

# Install necessary tools and dependencies
RUN yum install -y wget unzip md5sum java-11-openjdk-devel \
        && cd /opt \
        && wget -q --no-check-certificate https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip  \
        && unzip -q gradle-${GRADLE_VERSION}-bin.zip \
        && mv gradle-${GRADLE_VERSION} gradle \
        && rm gradle-${GRADLE_VERSION}-bin.zip \
        && yum clean all

# Set gradle environment variables and update PATH
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# Create a directory in the container for the project
RUN mkdir /app/


# Copy the Gradle project files
COPY build.gradle /app/.
COPY src /app/src

# Set the working directory
WORKDIR /app


# Check gardel  version
RUN gradle --version

# Use the Gradle executable from the installation directory
RUN gradle clean build

VOLUME ["/app/opt"]
