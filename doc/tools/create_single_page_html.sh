#!/bin/bash
#
# This creates the single_document.html.
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}/../modules/ROOT/pages

echo "Creating ${DIR}/../modules/ROOT/pages/single_document.html"

SED_ARG="s/xref:/include::/"
for NUM in $(seq 1 1 5); do
  SED_ARG="${SED_ARG} -e s/^*\{$NUM\}.\(inc.*\)\[.*\]$/\1[leveloffset=+$NUM]/"
done

cat << SEC | asciidoctor -b html5 -o single_document.html - 
= OpenEMS - Open Energy Management System
ifndef::toc[]
(c) 2023 OpenEMS Association e.V.
:doctype: book
:sectnums:
:sectnumlevels: 4
:toc:
:toclevels: 2
:toc-title: Inhalt
:experimental:
:keywords: AsciiDoc
:source-highlighter: highlight.js
:icons: font
endif::toc[]

$(cat ../nav.adoc | sed -e $(echo ${SED_ARG}) -e 's/^* \(.*\)$/== \1/g' | head -n-1)
SEC
