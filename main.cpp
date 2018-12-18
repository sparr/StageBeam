#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "radiusmousearea.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<RadiusMouseArea>("StageBeam", 0, 1, "RadiusMouseArea");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/display.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}


