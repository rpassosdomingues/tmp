#!/bin/bash

# Create directories based on UML
mkdir -p project/src/main/java/com/example/project
mkdir -p project/src/test/java/com/example/project

# Directories for classes
mkdir -p project/src/main/java/com/example/project/models
mkdir -p project/src/main/java/com/example/project/controllers
mkdir -p project/src/main/java/com/example/project/services

# Directory for interfaces
mkdir -p project/src/main/java/com/example/project/interfaces

# Directory for utilities
mkdir -p project/src/main/java/com/example/project/utils

# Directory for class tests
mkdir -p project/src/test/java/com/example/project/tests

# Display completion message
echo "Directory structure based on UML created successfully!"
