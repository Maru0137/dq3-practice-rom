include(FetchContent)

FetchContent_Declare(
    asar
    URL "https://github.com/RPGHacker/asar/releases/download/v1.81/asar181.zip"
)

FetchContent_MakeAvailable(asar)

set(asar_exe ${asar_SOURCE_DIR}/asar.exe)
