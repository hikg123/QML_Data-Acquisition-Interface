import QtQuick
Rectangle{
    id:btn
    radius:3
    width:0.08*w.width;height:0.08*w.height
    color: ma.containsMouse ?"gray":parent.color

    property alias text:text.text     //提到外层，方便其它qml文件来访问
    property alias hover:ma.containsMouse
    signal clicked
    property alias size:text.font.pixelSize
    property alias clr:text.color
    property alias font:text.font.family

    Text{
        id:text
        anchors.centerIn: parent
        text: ""
        font.family: "微软雅黑"
        font.pixelSize: 0.2*0.08*w.width

        font.bold: true
        color: "#FFFFFF"

    }
    MouseArea{
        id:ma
        hoverEnabled:true
        anchors.fill:parent
        onClicked: {
            btn.clicked()
        }

    }

}
