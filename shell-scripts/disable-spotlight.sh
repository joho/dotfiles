#!/bin/sh

# Totally disable spotlight on snow leopard

# disable the indexing
sudo mdutil -a -i off
# chmod the search binary so the little menu icon goes away
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# restart the system UI so the icon goes away NOW
killall SystemUIServer
