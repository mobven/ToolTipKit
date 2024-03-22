#!/bin/sh

xcrun xcodebuild docbuild \
    -scheme ToolTipKit \
    -destination 'generic/platform=iOS Simulator' \
    -derivedDataPath "$PWD/.derivedData"
    
xcrun docc process-archive transform-for-static-hosting \
    "$PWD/.derivedData/Build/Products/Debug-iphonesimulator/ToolTipKit.doccarchive" \
    --output-path ".docs" \
    --hosting-base-path "ToolTipKit" # add with your repo name later
    
echo '<script>window.location.href += "/documentation/tooltipkit"</script>' > .docs/index.html
