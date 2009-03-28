TEMPLATE = lib
QT = core xml network sql
include( _files.qmake )
headers.files = Fingerprint.h
INCLUDEPATH += $$ROOT_DIR/src/fingerprint/fplib/include
DEFINES += _FINGERPRINT_DLLEXPORT

win32 {
    LIBS += -llibsamplerate -llibfftw3f-3 -lmad -lsamplerate
    DEFINES += __NO_THREAD_CHECK
    QMAKE_LFLAGS_DEBUG += /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmt.lib
    LIBS += -lmad -lfftw3f
}
else:macx*:CONFIG( app_bundle ){
	LIBS += /opt/local/lib/libmad.a /opt/local/lib/libfftw3f.a /opt/local/lib/libsamplerate.a
	INCLUDEPATH += /opt/local/include
}else{
    CONFIG += link_pkgconfig
    PKGCONFIG += mad fftw3f samplerate
}