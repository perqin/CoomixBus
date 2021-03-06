VERSION = 1.2.1
# Add more folders to ship with the application, here
folder_01.source = qml/CoomixBus
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0x205051AA

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian {
    TARGET.CAPABILITY += NetworkServices \
            Location

    DEFINES += QVIBRA

    my_deployment.pkg_prerules += vendorinfo

    DEPLOYMENT += my_deployment
    DEPLOYMENT.display_name = 酷米客公交

    vendorinfo += "%{\"Perqin\"}" ":\"Perqin\""
}

contains(DEFINES, QVIBRA): include(./QVibra/vibra.pri)

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += location

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    network.cpp \
    settings.cpp \
    qdeclarativepositionsource.cpp

CONFIG += mobility
MOBILITY = location bearer

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    network.h \
    settings.h \
    qgeocoordinate.h \
    qdeclarativepositionsource.h

QT += network
