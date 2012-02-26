#! /bin/bash

# cloudfiles.sh
#
# Provides simple command-line access to Cloud Files.
#
# Relies on curl and a few common Unix-y tools (file, basename, sed, tr)
#
# Written by Mike Barton (mike@weirdlooking.com), based on work by letterj.

function usage {
  echo "Usage: $0 [Username] [API Key] LS"
  echo "       $0 [Username] [API Key] LS [container]"
  echo "       $0 [Username] [API Key] PUT [container] [local file]"
  echo "       $0 [Username] [API Key] GET [/container/object]"
  echo "       $0 [Username] [API Key] MKDIR [/container]"
  echo "       $0 [Username] [API Key] RM [/container/object]"
  echo "       $0 [Username] [API Key] RMDIR [/container]"
  exit 1
}

function scurl {
  curl -s -g -w '%{http_code}' -H Expect: -H "X-Auth-Token: $TOKEN" -X "$@"
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  usage
else
  LOGIN=`curl --dump-header - -s -H "X-Auth-User: $1" \
         -H "X-Auth-Key: $2" "https://auth.api.rackspacecloud.com/v1.0"`
  TOKEN=`echo "$LOGIN" | grep ^X-Auth-Token | sed 's/.*: //' | tr -d "\r\n"`
  URL=`echo "$LOGIN" | grep ^X-Storage-Url | sed 's/.*: //' | tr -d "\r\n"`
  if [ -z $TOKEN ] || [ -z $URL ]; then
    echo "Unable to auth."
    exit 1
  fi
  case $3 in
    LS)
      if [ -z $4 ]; then
        curl -s -o - -H "Expect:" -H "X-Auth-Token: $TOKEN" "$URL"
      else
        curl -s -o - -H "Expect:" -H "X-Auth-Token: $TOKEN" "$URL/$4"
      fi
      exit 0
      ;;
    GET)
      OBJNAME=`basename "$4"`
      CODE=`scurl GET "$URL$4" -o "$OBJNAME" -i -v`
      ;;
    PUT)
      if [ ! -f $5 ]; then
        usage
      fi
      TYPE=`file -bi "$5"`
      OBJNAME=`basename "$5"`
      CODE=`scurl PUT -H "Content-Type: $TYPE" -T "$5" "$URL/$4/$OBJNAME"`
      ;;
    MKDIR) CODE=`scurl PUT -T /dev/null "$URL/$4"`;;
    RM*) CODE=`scurl DELETE "$URL/$4"`;;
    *) usage
    esac
  if [ $CODE -lt 200 ] || [ $CODE -gt 299 ]; then
    echo "Invalid response code: $CODE"
    exit 1
  fi
fi

