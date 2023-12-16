// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PyPHPicker",
	platforms: [.iOS(.v14)],
	products: [
		.library(name: "PyPHPicker", targets: ["PyPHPicker"])
	],
	dependencies: [
        .package(url: "https://github.com/PythonSwiftLink/KivySwiftLink", from: .init(311, 0, 0)),
        .package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 0, 0)),
        .package(url: "https://github.com/KivySwiftPackages/PyFoundation", from: .init(311, 0, 0))
	],
	targets: [
		.target(
			name: "PyPHPicker",
			dependencies: [
                .product(name: "PythonSwiftCore", package: "KivySwiftLink"),
                .product(name: "PySwiftObject", package: "KivySwiftLink"),
                "PyFoundation"
				//"SwiftOpenCV",

			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),

	]
)
