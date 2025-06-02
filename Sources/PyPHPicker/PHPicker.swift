//
//  PHPicker.swift
//  test
//
//  Created by MusicMaker on 06/01/2023.
//

import Foundation
import PhotosUI
import UniformTypeIdentifiers


import PySwiftKit
import PySwiftObject
import PySerializing
import PySwiftWrapper
import PyUnpack

import PyFoundation




@PyClass
class PHPicker {
    var view: PHPickerViewController?
    //public var py_callback: PyCallback?
    var callback: (@Sendable ([NSItemProvider]) -> Void)?
    
    @PyInit
    init() {
        
    }
    
    
    @PyMethod
    func open(limit: Int, callback: @escaping @Sendable ([NSItemProvider])->Void) {
        self.callback = callback
        newView(limit: limit)
        guard
            let view = view,
            let window = UIApplication.shared.windows.first,
            let vc = window.rootViewController
        else { return }
        vc.present(view, animated: true)
    }
    
    @PyMethod
    func dismiss() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}

extension PHPicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        callback?(results.map(\.itemProvider))
    }
    
}

extension PHPicker {
    
    func newView(limit: Int) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = limit
        config.preferredAssetRepresentationMode = .current
        view = .init(configuration: config)
        view?.delegate = self
    }
    
}


@PyModule
struct Phpicker: PyModuleProtocol {
    static var py_classes: [(PyClassProtocol & AnyObject).Type] = [
        PHPicker.self
    ]
    
}

extension PySwiftModuleImport {
    public static let phpicker = PySwiftModuleImport(name: "phpicker", module: Phpicker.py_init)
}
