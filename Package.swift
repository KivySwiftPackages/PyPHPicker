// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PyPHPicker",
	platforms: [.iOS(.v14)],
	products: [
		.library(name: "PyPHPicker", targets: ["PyPHPicker"])
	],
	dependencies: [
        .package(url: "https://github.com/py-swift/PySwiftKit", from: .init(311, 0, 0)),
        .package(url: "https://github.com/KivySwiftPackages/PyFoundation", from: .init(311, 0, 0))
	],
	targets: [
		.target(
			name: "PyPHPicker",
			dependencies: [
                .product(name: "SwiftonizeModules", package: "PySwiftKit"),
                "PyFoundation"
			],
			plugins: []
		),

	]
)
