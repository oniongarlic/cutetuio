#ifndef CUTETUIO_H
#define CUTETUIO_H

#include <QObject>

#include "TuioServer.h"
#include "TcpSender.h"

class CuteTUIO : public QObject
{
    Q_OBJECT
public:
    explicit CuteTUIO(QObject *parent = nullptr);

    Q_INVOKABLE bool connectServer(QString host, uint port);
    Q_INVOKABLE bool disconnectServer();

    Q_INVOKABLE bool click(float x, float y);

    Q_INVOKABLE bool pressed(float x, float y);
    Q_INVOKABLE bool released(float x, float y);

    Q_INVOKABLE bool move(float x, float y, bool relative);

signals:

public slots:

private:
    TUIO::TuioServer *server;

    TUIO::TuioCursor *cursor;

    TUIO::TuioTime frameTime;

    void handleEvents();
};

#endif // CUTETUIO_H
