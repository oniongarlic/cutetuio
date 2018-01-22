#include "cutetuio.h"

#include <QDebug>

CuteTUIO::CuteTUIO(QObject *parent) :
    QObject(parent),
    server(NULL),
    cursor(NULL)
{

}

bool CuteTUIO::connectServer(QString host, uint port)
{
    if (server)
        return false;

    server = new TUIO::TuioServer(host.toLocal8Bit().constData(), port);
    server->setSourceName("CuteTUIO");

    TUIO::TuioTime::initSession();
    frameTime = TUIO::TuioTime::getSessionTime();

    //server->enableObjectProfile(false);
    //server->enableBlobProfile(false);

    return true;
}

bool CuteTUIO::disconnectServer()
{
    if (!server)
        return false;

    if (cursor)
        server->removeTuioCursor(cursor);
    cursor=NULL;

    handleEvents();

    delete server;
    server=NULL;

    return true;
}

bool CuteTUIO::click(float x, float y)
{
    if (!server)
        return false;

    pressed(x, y);
    handleEvents();

    released(x, y);
    handleEvents();

    return true;
}

bool CuteTUIO::pressed(float x, float y)
{
    if (!server)
        return false;

    if (cursor) {
        server->removeTuioCursor(cursor);
        cursor=NULL;
        handleEvents();
    }

    cursor=server->addTuioCursor(x, y);
    handleEvents();
}

bool CuteTUIO::released(float x, float y)
{
    if (!server)
        return false;

    if (cursor) {
        server->removeTuioCursor(cursor);
        cursor=NULL;
    }
    handleEvents();

    return true;
}

bool CuteTUIO::move(float x, float y, bool relative)
{
    if (!server)
        return false;

    if (cursor) {
        server->updateTuioCursor(cursor, x, y);
    } else {
        cursor=server->addTuioCursor(x, y);
    }

    qDebug() << x << y;

    handleEvents();
}

void CuteTUIO::handleEvents()
{
    if (!server)
        return;

    //frameTime = TUIO::TuioTime::getSessionTime();
    server->initFrame(frameTime);
    server->stopUntouchedMovingCursors();
    server->commitFrame();
}
