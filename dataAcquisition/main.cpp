#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "fileio.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Some Company");

    //在engine声明之前注册C++类型
    //@1:类在qml中别名 @2:版本主版本号 @3:版本的次版本号 @4类的名称
    qmlRegisterType<FileIO>("org.fileio",1,0,"FileIO");

    QQmlApplicationEngine engine;


    const QUrl url(u"qrc:/untitled/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);



    return app.exec();
}
