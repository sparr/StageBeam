#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QWindow>
#include <QtGui>

#include "qquickitemradiusmask.h"
#include "osx_native_code.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<QQuickItemRadiusMask>("StageBeam", 0, 1, "ItemRadiusMask");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/display.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    app.allWindows()[0]->showFullScreen();
    NSRunningApplication_setPresentationOptions(10);

    return app.exec();
}


