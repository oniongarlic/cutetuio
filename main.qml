import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import org.tal.cutetuio 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("CuteTUIO")

    property bool multiTouchMode: false

    MouseArea {
        id: ma
        anchors.fill: parent
        //hoverEnabled: true

        enabled: !multiTouchMode

        onPressed: {
            tuio.pressed(mouseX/width, mouseY/height)
        }

        onReleased: {
            tuio.released(mouseX/width, mouseY/height)
        }

        onPositionChanged: {
            if (pressed)
                tuio.move(mouseX/width, mouseY/height, false);
        }

        onClicked: {
            // tuio.click(mouseX/width, mouseY/height);
        }
    }

    MultiPointTouchArea {
        id: mpta
        anchors.fill: parent
        enabled: multiTouchMode
        mouseEnabled: true

        maximumTouchPoints: 4
        minimumTouchPoints: 1

        onUpdated: {

        }

        onPressed: {

        }

        onReleased: {

        }

    }

    Rectangle {
        id: c
        width: 10
        height: 10
        color: "red"
        visible: ma.pressed
        x: ma.mouseX-5
        y: ma.mouseY-5
        radius: 5
    }

    CuteTUIO {
        id: tuio
    }

    Dialog {
        id: dialogConnect
        title: "Connect to host"
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            TextField {
                placeholderText: "Host"
                text: "localhost"
            }
            TextField {
                placeholderText: "Port"
                text: "3333"
            }
        }
        onAccepted: {
            tuio.connectServer("localhost", 3333);
        }
        onRejected: {
            tuio.disconnectServer();
        }
    }

    header: ToolBar {
        RowLayout {
            ToolButton {
                text: "Connect"
                enabled: true
                onClicked: {
                    dialogConnect.open();
                }
            }
            ToolButton {
                text: "Disconnect"
                enabled: true
                onClicked: {
                    tuio.disconnectServer();
                }
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            Text {
                text: ma.mouseX/ma.width                
                Layout.minimumWidth: 100
                Layout.maximumWidth: 100
            }
            Text {
                text: ma.mouseY/ma.height                
                Layout.minimumWidth: 100
                Layout.maximumWidth: 100
            }
            Rectangle {
                color: "green"
                Layout.minimumWidth: 20
                Layout.maximumWidth: 20
                Layout.minimumHeight: 20
                Layout.maximumHeight: 20
            }
        }
    }
}
