#!/usr/bin/env bash
#
# usage: ./generate.sh [couchdb_version]
# If you omit the version, then it will generate the latest
# Example valid versions: 1.5.0, 1.6.0, 1.6.1, stable, latest

COUCHDB_VERSION=$1

if [[ -z $COUCHDB_VERSION ]]; then
  COUCHDB_VERSION=latest
fi

wget "https://media.readthedocs.org/htmlzip/couchdb/${COUCHDB_VERSION}/couchdb.zip"

rootDir=CouchDB-${COUCHDB_VERSION}.docset
docsDir1=couchdb-${COUCHDB_VERSION}
docsDir2=$rootDir/Contents/Resources/Documents
tmpDir=couchdb-tmp

rm -fr $rootDir $docsDir1
mkdir -p $docsDir1
mkdir -p $docsDir2
rm -fr $tmpDir

unzip couchdb.zip -d $tmpDir

cp -r $tmpDir/couchdb*/* $docsDir1/
cp -r $tmpDir/couchdb*/* $docsDir2/
rm -f couchdb.zip

COUCHDB_VERSION=$COUCHDB_VERSION ./docset-gen

rm -fr $tmpDir