cmake_minimum_required(VERSION 2.6)

add_definitions(-DLASTFM_OHAI_QMAKE)

# Macro to copy and rename headers
macro(copy_header from to)
  configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/${from}
    ${CMAKE_CURRENT_BINARY_DIR}/lastfm/${to}
    COPY_ONLY
  )
  install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/lastfm/${to}
    DESTINATION include/lastfm/
  )
endmacro(copy_header)

# Copy headers
copy_header(global.h global.h)
copy_header(core/misc.h misc.h)
copy_header(core/XmlQuery.h XmlQuery)
copy_header(core/UrlBuilder.h UrlBuilder)
copy_header(scrobble/Audioscrobbler.h Audioscrobbler)
copy_header(scrobble/Handshake.h Handshake)
copy_header(scrobble/NowPlaying.h NowPlaying)
copy_header(scrobble/Scrobble.h Scrobble)
copy_header(scrobble/ScrobbleCache.h ScrobbleCache)
copy_header(scrobble/ScrobblePoint.h ScrobblePoint)
copy_header(scrobble/ScrobblerHttp.h ScrobbleHttp)
copy_header(scrobble/ScrobblerSubmission.h ScrobblerSubmission)
copy_header(types/Playlist.h Playlist)
copy_header(types/Mbid.h Mbid)
copy_header(types/FingerprintId.h FingerprintId)
copy_header(types/Xspf.h Xspf)
copy_header(types/Album.h Album)
copy_header(types/Tag.h Tag)
copy_header(types/User.h User)
copy_header(types/Artist.h Artist)
copy_header(types/Track.h Track)
copy_header(radio/RadioTuner.h RadioTuner)
copy_header(radio/RadioStation.h RadioStation)
copy_header(ws/ws.h ws.h)
copy_header(ws/InternetConnectionMonitor.h InternetConnectionMonitor)
copy_header(ws/NetworkAccessManager.h NetworkAccessManager)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(SOURCES
  core/misc.cpp
  core/UrlBuilder.cpp
  core/XmlQuery.cpp
  radio/RadioStation.cpp
  radio/RadioTuner.cpp
  scrobble/Audioscrobbler.cpp
  scrobble/Handshake.cpp
  scrobble/NowPlaying.cpp
  scrobble/ScrobbleCache.cpp
  scrobble/Scrobble.cpp
  scrobble/ScrobblerHttp.cpp
  scrobble/ScrobblerSubmission.cpp
  types/Album.cpp
  types/Artist.cpp
  types/FingerprintId.cpp
  types/Mbid.cpp
  types/Playlist.cpp
  types/Tag.cpp
  types/Track.cpp
  types/User.cpp
  types/Xspf.cpp
  ws/InternetConnectionMonitor.cpp
  ws/NetworkAccessManager.cpp
  ws/ws.cpp
)

set(MOC_HEADERS
  radio/RadioTuner.h
  scrobble/ScrobblerHttp.h
  scrobble/Audioscrobbler.h
  ws/InternetConnectionMonitor.h
  ws/NetworkAccessManager.h
)

qt4_wrap_cpp(MOC_SOURCES ${MOC_HEADERS})

add_library(lastfm SHARED
  ${SOURCES}
  ${MOC_SOURCES}
)

target_link_libraries(lastfm
  ${QT_LIBRARIES}
)

if(APPLE)
  target_link_libraries(lastfm
    /System/Library/Frameworks/CoreFoundation.framework
    /System/Library/Frameworks/SystemConfiguration.framework
  )
endif(APPLE)

install(TARGETS lastfm
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
)
