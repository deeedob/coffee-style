#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.loadFromModule("Tests", "TestBasics");
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
