- Перейти в папку с файлом
- Скомпилировать `g++ -std=c++17 z8.cpp -o program`
- запустить `./program`

чтобы скомпилировать на Win
- скачать `brew install mingw-64`
- выполнить команду `i686-w64-mingw32-g++ -std=c++17 -Os -s -ffunction-sections -fdata-sections -Wl,--gc-sections -static -static-libgcc -static-libstdc++ z8.cpp -o SHUMAN-Z8.exe`