cmake_minimum_required(VERSION 2.6)

include(FindPkgConfig)
find_package(Qt4 REQUIRED QtCore QtGui QtNetwork QtXml QtSql QtTest)

if(${CMAKE_BUILD_TYPE} MATCHES "Release")
  add_definitions(-DNDEBUG)
  add_definitions(-DQT_NO_DEBUG_OUTPUT)
endif(${CMAKE_BUILD_TYPE} MATCHES "Release")

# Set up definitions and paths
add_definitions(${QT_DEFINITIONS})
include(${QT_USE_FILE})

# Main Library
add_subdirectory(src)

# Optionally build the fingerprint library
option(BUILD_FINGERPRINT "Build the lastfm-fingerprint library" ON)
pkg_check_modules(LIBFFTW3 fftw3f)
pkg_check_modules(LIBSAMPLERATE samplerate)

# Tests
add_subdirectory(tests)

if (BUILD_FINGERPRINT AND LIBFFTW3_FOUND AND LIBSAMPLERATE_FOUND)
  add_subdirectory(src/fingerprint)
endif (BUILD_FINGERPRINT AND LIBFFTW3_FOUND AND LIBSAMPLERATE_FOUND)

# Uninstall support
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
