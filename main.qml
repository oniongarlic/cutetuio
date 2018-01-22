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

    MouseArea {
        id: ma
        anchors.fill: parent
        //hoverEnabled: true

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

    header: ToolBar {
        RowLayout {
            ToolButton {
                text: "Con"
                enabled: true
                onClicked: {
                    tuio.connectServer("localhost", 3333);
                }
            }
            ToolButton {
                text: "Dis"
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
