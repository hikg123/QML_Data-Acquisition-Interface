import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: homePage3
    //color: "#f0ffff"
    width: w.width
    height: w.height-w.height/12
    Image{
        anchors.fill:parent
        //fillMode:Image.PreserveAspectFit
        source:"img/background.png"
    }
    Label{
        text:"help"
    }

}
