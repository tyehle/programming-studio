cmake_minimum_required(VERSION 3.7)
project(tobin)

add_custom_target(tobin
        COMMAND /home/tobin/opt/swift-3.1.1-RELEASE-ubuntu16.04/usr/bin/swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES Sources/main.swift)
