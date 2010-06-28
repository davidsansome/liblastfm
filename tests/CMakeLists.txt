cmake_minimum_required(VERSION 2.6)

set(SOURCES
  main.cpp
)

set(MOC_HEADERS
  TestTrack.h
  TestUrlBuilder.h
)

qt4_wrap_cpp(MOC_SOURCES ${MOC_HEADERS})

include_directories(${CMAKE_CURRENT_BINARY_DIR}/../src)

add_executable(tests
  ${SOURCES}
  ${MOC_SOURCES}
)

target_link_libraries(tests
  ${QT_LIBRARIES}
  lastfm
)

add_custom_target(test WORKING_DIRECTORY ${CURRENT_BINARY_DIR})
add_custom_command(TARGET test POST_BUILD
  COMMAND ./tests${CMAKE_EXECUTABLE_SUFFIX})

