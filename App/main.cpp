// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include <QQuickView>

#include "autogen/environment.h"
#include "dbmanager.h"

int main(int argc, char *argv[])
{
    set_qt_environment();
    QApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/image/logo.png"));

    DBManager dbManager;
    dbManager.openDatabase("C:/Users/welli/OneDrive/Documents/Bezopyastie/database/bezopyastie_bracles.db");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("dbManager", &dbManager);
    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    const QUrl url(mainQmlFile);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
