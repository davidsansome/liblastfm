cmake_minimum_required(VERSION 2.6)

include_directories(${LIBFFTW3_INCLUDE_DIRS})
include_directories(${LIBSAMPLERATE_INCLUDE_DIRS})

include_directories(${CMAKE_CURRENT_BINARY_DIR}/..)

link_directories(${LIBFFTW3_LIBRARY_DIRS})
link_directories(${LIBSAMPLERATE_LIBRARY_DIRS})

set(SOURCES
  Collection.cpp
  Fingerprint.cpp
  Sha256.cpp
  fplib/Filter.cpp
  fplib/FingerprintExtractor.cpp
  fplib/OptFFT.cpp
)

add_library(lastfm_fingerprint SHARED
  ${SOURCES}
)

target_link_libraries(lastfm_fingerprint
  ${QT_LIBRARIES}
  ${LIBFFTW3_LIBRARY}
  ${LIBSAMPLERATE_LIBRARY}
  lastfm
)

