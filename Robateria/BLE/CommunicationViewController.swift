//
//  CommunicationViewController.swift
//  Robateria
//
//  Created by Korbinian Baumer on 14.01.18.
//  Copyright © 2018 Korbinian Baumer. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class CommunicationViewController: UIViewController,  CBPeripheralDelegate {

    //Books
    let book1 = Books("Computernetze",-2,2,false)
    let book2 = Books("Kunststoffe",-1,2,false)
    let book3 = Books("Komplexitätstheorie",1,2,false)
    let book4 = Books("Embedded Systems",2,2,false)

    let book5 = Books("Advanced Physics",-2,1,true)
    let book6 = Books("Computer Graphics",-1,1,true)
    let book7 = Books("Change Management",1,1,true)
    let book8 = Books("C++ Introduction",2,1,true)

    let book9 = Books("BWLkompakt",-2,1,false)
    let book10 = Books("Grundlagen Infromatik",-1,1,false)
    let book11 = Books("Spieltherie",1,1,false)
    let book12 = Books("Diskrete Strukturen",2,1,false)

    let book13 = Books("Grundkurs Java",-2,0,true)
    let book14 = Books("Rechnerarchitektur",-1,0,true)
    let book15 = Books("Wirtschaftsinformatik",1,0,true)
    let book16 = Books("Betriebsysteme",2,0,true)

    var bookArray: [Books] = []

    // Coordinates
    var currentCoords = ""


    // Every button has its own function to send the coordinates. This is only a temporary solution and will be changed in the future. A scroll view or a collection view would be a better solution. The code in every button is repeating itself, except for the coordintes, therefore only the first three function contain the code.
    // The function creates a string with the three coordinates and uses that string to create an Data array. This array is passed on to the bluetooth device by calling .writeValue()
    @IBAction func book1(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book1.x),")
        coordinates.append("\(book1.y),")
        coordinates.append("\(book1.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data String")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates

        // Present an alert to the user to follow the robot
        let alert = UIAlertController(title: "Let's Go", message: "Please follow the Robot to the shelf", preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func book2(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book2.x),")
        coordinates.append("\(book2.y),")
        coordinates.append("\(book2.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data String")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates

        // Present an alert to the user to follow the robot
        let alert = UIAlertController(title: "Let's Go", message: "Please follow the Robot to the shelf", preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func book3(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book3.x),")
        coordinates.append("\(book3.y),")
        coordinates.append("\(book3.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data String")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates

        // Present an alert to the user to follow the robot
        let alert = UIAlertController(title: "Let's Go", message: "Please follow the Robot to the shelf", preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func book4(_ sender: Any) {
    }
    @IBAction func book5(_ sender: Any) {
    }
    @IBAction func book6(_ sender: Any) {
    }
    @IBAction func book7(_ sender: Any) {
    }
    @IBAction func book8(_ sender: Any) {
    }
    @IBAction func book9(_ sender: Any) {
    }
    @IBAction func book10(_ sender: Any) {
    }
    @IBAction func book11(_ sender: Any) {
    }
    @IBAction func book12(_ sender: Any) {
    }
    @IBAction func book13(_ sender: Any) {
    }
    @IBAction func book14(_ sender: Any) {
    }
    @IBAction func book15(_ sender: Any) {
    }
    @IBAction func book16(_ sender: Any) {
    }

    // Device UUIDs
    let ledServiceUUID = CBUUID(string: "F0001110-0451-4000-B000-000000000000")
    let ledChar0UUID = CBUUID(string: "F0001111-0451-4000-B000-000000000000")
    let dataServiceUUID = CBUUID(string: "F0001130-0451-4000-B000-000000000000")
    let dataChar0UUID = CBUUID(string: "F0001131-0451-4000-B000-000000000000")
    let dataChar1UUID = CBUUID(string: "F0001132-0451-4000-B000-000000000000")

    // Bluetooth Characteristics
    var ledCharLED0: CBCharacteristic?
    var dataCharString: CBCharacteristic?
    var dataCharData: CBCharacteristic?

    var peripheralManager: CBPeripheralManager?

    // Variables
    var btDevice: CBPeripheral?
    var bleDeviceVC: BLEDevicesViewController?

    // Setting the led to red
    var rInt = UInt8(1*255), gInt = UInt8(0*255), bInt = UInt8(0*255)

    //Initializing the books
    override func viewDidLoad() {
        super.viewDidLoad()
        bookArray = [book1, book2, book3, book4, book5, book6, book7, book8, book9, book10, book11, book12, book13, book14, book15, book16]
    }

    //LED Switch and color buttons
    @IBOutlet weak var ledSwitch: UISwitch!

    @IBAction func ledSwitch(_ sender: Any) {
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        if (ledSwitch?.isOn)! {
            let writeArray: [UInt8] = [rInt,gInt,bInt]

            btDevice?.writeValue(Data(writeArray),
                                for: ledCharLED,
                                type: CBCharacteristicWriteType.withResponse)
        }else {
            let writeArray: [UInt8] = [rInt*0,gInt*0,bInt*0]
            btDevice?.writeValue(Data(writeArray),
                                for: ledCharLED,
                                type: CBCharacteristicWriteType.withResponse)
        }
    }

    @IBAction func redButton(_ sender: Any) {
        rInt = UInt8(1*255)
        gInt = UInt8(0*255)
        bInt = UInt8(0*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)
    }

    @IBAction func greenButton(_ sender: Any) {
        rInt = UInt8(0*255)
        gInt = UInt8(1*255)
        bInt = UInt8(0*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)

    }

    @IBAction func blueButton(_ sender: Any) {
        rInt = UInt8(0*255)
        gInt = UInt8(0*255)
        bInt = UInt8(1*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)
    }

    // CBPeripheralDelegate
    // Checking if the services that we require are available and if yes we look for the characteristic uuids. If they are the same uuids that were set at Device UUIDS, we can assign a CBCharacteristics variable to that specific service characteristic.

    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?)
    {
        for service in peripheral.services!
        {
            let thisService = service as CBService
            peripheral.discoverCharacteristics(nil, for: thisService)
        }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?)
    {
        if service.uuid == ledServiceUUID
        {
            for characteristic in service.characteristics!
            {
                if characteristic.uuid == ledChar0UUID
                {
                    ledCharLED0 = characteristic

                    print("********************")
                    print(ledCharLED0 as Any)
                }
                else
                {
                    print("Unknown characteristic UUID: \(characteristic.uuid.uuidString)")
                    continue
                }

                btDevice?.readValue(for: characteristic)
            }
        }
        else if service.uuid == dataServiceUUID
        {
            for characteristic in service.characteristics!
            {
                if characteristic.uuid == dataChar0UUID
                {
                    dataCharString = characteristic
                }
                else if characteristic.uuid == dataChar1UUID
                {
                    dataCharData = characteristic
                    btDevice?.setNotifyValue(true, for: characteristic)

                }
                else
                {
                    print("Unknown characteristic UUID: \(characteristic.uuid.uuidString)")
                    continue
                }
            }
        }
        else
        {
            print("ProjectZero: Unknown Service UUID \(service.uuid.uuidString)")
        }
    }


}
