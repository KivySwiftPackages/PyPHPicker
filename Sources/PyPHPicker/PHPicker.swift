//
//  PHPicker.swift
//  test
//
//  Created by MusicMaker on 06/01/2023.
//

import Foundation
import PhotosUI
import UniformTypeIdentifiers
import PySwiftCore
import PythonCore
import PySerializing

import PyFoundation

public class PHPickerResults {
    public func __getitem__(idx: Int) -> PyPointer? {
        guard idx < results.count else { return nil }
        return results[idx].itemProvider.pyPointer
    }
    

    
    
    var results: [PHPickerResult]
    
    internal init(results: [PHPickerResult]) {
        self.results = results
        
    }
}

public class PHPicker {
    var view: PHPickerViewController?
    public var py_callback: PyCallback?
    
    init() {

    }
    
    func newView(limit: Int) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = limit
        config.preferredAssetRepresentationMode = .current
        view = .init(configuration: config)
        view?.delegate = self
    }
}

extension PHPicker: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        py_callback?.picker_didFinishPicking(
            results: PHPickerResults.asPyPointer(.init(results: results))
        )
    }
    
}

extension PHPicker: PHPicker_PyProtocol {
    
    public func open(limit: Int) {
        newView(limit: limit)
        guard
            let view = view,
            let window = UIApplication.shared.windows.first,
            let vc = window.rootViewController
        else { return }
        vc.present(view, animated: true)
    }
    public func dismiss() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
    
}
