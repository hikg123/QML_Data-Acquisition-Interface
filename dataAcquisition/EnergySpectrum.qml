import QtQuick
import QtQuick.Controls

Rectangle{
    id:rec
    width:0.330*w.width
    height:0.170*w.width
    radius:height*0.1
    color: "#a3bed3"
    border.width: 1
    border.color: "#303030"
    property alias ack: btn

    function storeSettings(){}
    Column{//Column,Row 内的子项不应使用 top、bottom、anchors.verticalCenter、fill、centerIn 这些锚点设置，
        //也不应该设置 y 属性
        x:20
        y:20
        spacing:20
        Row{
            spacing:6
            Label{
                id:mode
                text:"能量测量模式:"
            }
            Rectangle{
                width:100
                height:20
                anchors.verticalCenter: mode.verticalCenter

                Text{
                    text:"38"
                    color:"#999999"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            ComboBox{

                //displayText:"数字求和点数"
                anchors.verticalCenter: mode.verticalCenter
                contentItem: Text { //界面上显示出来的文字
                    color: "#999999"    //文字颜色
                    text: "数字求和点数"
                    verticalAlignment: Text.AlignVCenter  //文字位置
                    elide: Text.ElideRight
                }
            }

        }

        Row{
            spacing:6
            Label{
                id:mode1
                text:"多点求和权重模式:"
            }

            TextField{
                width:182
                cursorVisible: true;
                id:inp_mode
                //text:settings.num_s
                //anchors.left:mode1.right
                anchors.verticalCenter: mode1.verticalCenter
                //anchors.leftMargin:6
                //rightPadding: 20
                selectByMouse: true
                text: "00"
                background: Rectangle
                {
                    //implicitWidth: 40
                    //implicitHeight: 40
                    color: inp_mode.hovered ? "#eeeeee":"white"
                    border.color: inp_mode.hovered ? "#555666" : "white"
                }
            }

        }


    }
    MyButton{
        id:btn
        text: "确定"
        clr:"#333333"
        font:"宋体"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/5
        height: width/2
        size:13
        border.width: 1
        border.color: "#303030"
        radius:height*0.1
        color:hover?"#ffb24d":parent.color

    }
}
