// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "libPhoneNumber",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "libPhoneNumber",
            targets: ["libPhoneNumber"]
        ),
        .library(
          name: "libPhoneNumberShortNumber",
          targets: ["libPhoneNumberShortNumber"]
        )
    ],
    targets: [
        .target(
            name: "libPhoneNumber",
            path: "libPhoneNumber",
            exclude: [
              "Info.plist",
              "GeneratePhoneNumberHeader.sh"
            ],
            resources: [.process("NBPhoneNumberMetadata.plist")],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Internal")
            ],
            linkerSettings: [
                .linkedFramework("CoreTelephony"),
            ]
        ),
        .target(
          name: "libPhoneNumberShortNumber",
          dependencies: ["libPhoneNumber"],
          path: "libPhoneNumberShortNumber",
          exclude: ["Info.plist", "README.md"],
          publicHeadersPath: "Public",
          cSettings: [
              .headerSearchPath("../libPhoneNumber/Internal")
          ]
        ),

        .testTarget(
            name: "libPhoneNumberTests",
            dependencies: ["libPhoneNumber", "libPhoneNumberShortNumber"],
            path: "libPhoneNumberTests",
            exclude: ["Info.plist"],
            sources: [
                "NBAsYouTypeFormatterTest.m",
                "NBPhoneNumberParsingPerfTest.m",
                "NBPhoneNumberUtilTest.m",
                "NBShortNumberTestHelper.m",
                "NBPhoneNumberUtil+ShortNumberTest.h",
                "NBPhoneNumberUtil+ShortNumberTest.m",
                "NBShortNumberInfoTest.m"
            ],
            resources: [.process("Resources/libPhoneNumberMetadataForTesting")]
        ),
    ]
)
