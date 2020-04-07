@echo off

cd ..

python -m http.server

rem http://localhost:8000/viewer/reconstruction.html#file=/data/berlin/reconstruction.meshed.json

@pause