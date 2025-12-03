/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import QGroundControl
import QGroundControl.Controls
import QtQuick.Shapes

Rectangle {
    id:     control
    width:  parent.width
    height: ScreenTools.toolbarHeight
    color:  "transparent"

    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property bool   _communicationLost: _activeVehicle ? _activeVehicle.vehicleLinkManager.communicationLost : false
    property color  _mainStatusBGColor: qgcPal.brandingBlue
    // property color  _mainStatusBGColor: "#00b4d8"
    property real   _leftRightMargin:   ScreenTools.defaultFontPixelWidth * 0.75




    Connections {
        target: QGroundControl.multiVehicleManager

        onActiveVehicleChanged: {
            if (_activeVehicle !== null) {
                console.log("sag Active vehicle connected");


                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors.value = 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus.value = 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels.value = 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition.value = 1;
                // sR0_POSITION.value= 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1.value = 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2.value = 1;
                QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3.value = 1;
                QGroundControl.settingsManager.videoSettings.videoSource.value = QGroundControl.settingsManager.videoSettings.rtspVideoSource;
                // QGroundControl.settingsManager.videoSettings.aspectRatio = 1.2
                // QGroundControl.settingsManager.appSettings.checkInternet.rawValue = false;
                QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle.rawValue = true;
                QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl.rawValue = false;
                QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude.rawValue = 40;
                QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude.rawValue = 400;
                QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance.rawValue = 10000;
                QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude.rawValue = 250;

            }
        }
    }



    function dropMainStatusIndicatorTool() {
        mainStatusIndicator.dropMainStatusIndicator();
    }

    QGCPalette { id: qgcPal }

    /// Bottom single pixel divider
    Rectangle {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        height:         1
        color:          qgcPal.toolbarDivider
    }

    Rectangle {
        id:             gradientBackground
        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        width:          lblArsha.width*4
        opacity:        qgcPal.windowTransparent.a
        gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0; color: _mainStatusBGColor }
                GradientStop { position: 1; color: qgcPal.window }
            }
    }

    Rectangle {
        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        anchors.left:   gradientBackground.right
        anchors.right:  parent.right
        color:          qgcPal.windowTransparent
    }

    RowLayout {
        id:                     mainLayout

        anchors.fill: parent

        RowLayout {
            id:                 leftStatusLayout
            Layout.fillHeight:  true
            Layout.alignment:   Qt.AlignLeft
            spacing:            ScreenTools.defaultFontPixelWidth * 2


            QGCLabel {
                id: lblArsha
                Layout.fillHeight: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pointSize: ScreenTools.largeFontPointSize * 1.5
                text: "Arsha"
                textFont : "Siegra"
            }
            QGCButton {
                id:         disconnectButton
                text:       qsTr("Disconnect")
                onClicked:  _activeVehicle.closeVehicle()
                visible:    _activeVehicle && _communicationLost
            }

            MainStatusIndicator {
                id:                 mainStatusIndicator
                Layout.fillHeight:  true
            }
        }


        QGCFlickable {
            id:                     indicatorsFlickable
            Layout.alignment:       Qt.AlignRight
            Layout.rightMargin: _leftRightMargin*14
            Layout.fillHeight:      true
            Layout.preferredWidth:  Math.min(contentWidth, availableWidth)

            contentWidth:           toolIndicators.width
            flickableDirection:     Flickable.HorizontalFlick

            property real availableWidth: mainLayout.width - leftStatusLayout.width

            FlyViewToolBarIndicators { id: toolIndicators }
        }

    }
    Item {
        anchors.fill: parent

        FlightModeIndicator {
            width: 100
            height: mainLayout.height   // same height as toolbar
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle{
                id:                      seperator
                anchors.right:           settingButton.left
                anchors.top:             parent.top
                anchors.bottom:          parent.bottom
                anchors.leftMargin:      13
                anchors.rightMargin:     13
                anchors.topMargin:       5
                anchors.bottomMargin:    5
                width:                   1
                height:                  mainLayout.height
                color:                   qgcPal.colorGrey
            }

            QGCColoredImage {
                id:                     settingButton
                source:                 "/res/gear-black.svg"
                height:                 ScreenTools.defaultFontPixelHeight *2
                width:                  height
                anchors.right:          parent.right
                sourceSize.height:      height
                anchors.rightMargin:    ScreenTools.defaultFontPixelWidth
                anchors.verticalCenter: parent.verticalCenter
                fillMode:               Image.PreserveAspectFit
                mipmap:                 true
                color:                  qgcPal.text

                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        mainWindow.showVehicleConfig()
                    }

                }
            }
    }


    ParameterDownloadProgress {
        anchors.fill: parent
    }
}
