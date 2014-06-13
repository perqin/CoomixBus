#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeComponent>
#include "qmlapplicationviewer.h"
#include "network.h"
#include "settings.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));

    app->setApplicationName ("CoomixBus");
    app->setOrganizationName ("Perqin");
    app->setApplicationVersion ("1.0.0");
    Settings *setting=new Settings;

    Network network;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.rootContext()->setContextProperty("Network", &network);
    viewer.rootContext()->setContextProperty("Settings", setting);
    viewer.setMainQmlFile(QLatin1String("qml/CoomixBus/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
