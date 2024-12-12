#!/bin/bash

grep -RIl "iDempiere" org.adempiere.* org.idempiere.zk.*.theme | grep -v "*.idempiere.*" | xargs sed -i 's/iDempiere/Ompiere/g'
 
for file in $(find . -type f -name "*ompiereMonitor*" -exec ls -l {} + | awk '{print $9}'); do mv "$file" "${file/ompiereMonitor/ompiereMonitor}"; done
 
grep -Rl ompiereMonitor | xargs sed -i 's/ompiereMonitor/ompiereMonitor/g'

# HTML file modification
HTML_FILE="org.adempiere.server/idempiere.jsp"

# Add a new Ompiere div right after the existing footercopyright div, preserving indentation
sed -i '/<div id="footercopyright">/,/<\/div>/ {
    /<\/div>/a\
    <div id="footercopyright">\
        <p>&copy; Copyright 2024-<%=Prop.getYear()%> Ompiere - All rights reserved</p>\
	<p><a href="http://www.gnu.org/licenses/gpl-2.0.html" target="_blank">Ompiere License is GPLv2</a></p>\
        <%=Prop.getProperty(Prop.COPYRIGHT_TXT)%>\
    </div>
}' "$HTML_FILE"

# CSS file modification
CSS_FILE="org.adempiere.server/resources/templates/black/styles/template.css"
CSS_FILE2="org.adempiere.server/resources/templates/white/styles/template.css"
#CSS_FILE=$(ls /root/idempiere/org.adempiere.server/resources/templates/*/styles/template.css)

# Adjust the existing #footercopyright rule to set a specific top value
sed -i '/#footercopyright[[:space:]]*{/,/}/ {
    s/top:[[:space:]]*[0-9]*px/top: 12px/; # Set the new iDempiere top value to 20px
    /}/a\
    #footercopyright + #footercopyright {\
        top: 27px; /* Adjust this value to control the vertical spacing */\
    }
}' "$CSS_FILE"

sed -i '/#footercopyright[[:space:]]*{/,/}/ {
    s/top:[[:space:]]*[0-9]*px/top: 12px/; # Set the new iDempiere top value to 20px
    /}/a\
    #footercopyright + #footercopyright {\
        top: 27px; /* Adjust this value to control the vertical spacing */\
    }
}' "$CSS_FILE2"

CREDITS_FILE="Credits.html"

# Append a new link after the closing tag of the specific Zuellig Industrial <a> tag
sed -i '/<h5 class="text-center" style="color: #2e6c80;">Organizations<\/h5>/,/<\/div>/ {
    /<a class="text-center col-4 mt-3" target="_blank" href="https:\/\/www\.zuelligindustrial\.com\/">/,/<\/a>/ {
        /<\/a>/!b                   # Only process lines until the closing </a>
        s|</a>|</a>\
                <a class="text-center col-4 mt-3" target="_blank" href="https://vdel.com/">\
                    <img style="max-width: 100%;" src="https://www.vdel.com/bitrix/templates/vdel/images/logo.png" alt="VDEL Information Technology">\
                </a>|         # Append the new link after the closing </a>
    }
}' "$CREDITS_FILE"
BUILDPROP_FILE="org.adempiere.server/build.properties"

# Check if the file exists
if [[ -f "$BUILDPROP_FILE" ]]; then
    # Replace Ompiere120x60.gif with iDempiere120x60.gif
    sed -i 's/Ompiere120x60.gif/iDempiere120x60.gif/' "$BUILDPROP_FILE"
    echo "Replacement done in $BUILDPROP_FILE"
else
    echo "File $BUILDPROP_FILE not found!"
fi

# Define the target file
COPYRIGHT_FILE="org.adempiere.server/idempiere.jsp"

# Check if the file exists
if [[ -f "$COPYRIGHT_FILE" ]]; then
    # Use awk to update the first <div id="footercopyright"> and its content
    awk '
    BEGIN { found = 0 }
    /<div id="footercopyright">/ && found == 0 {
        found = 1
    }
    found == 1 {
        gsub(/Ompiere/, "iDempiere")
    }
    /<\/div>/ && found == 1 {
        found = 2
    }
    { print }
    ' "$COPYRIGHT_FILE" > temp_file && mv temp_file "$COPYRIGHT_FILE"

    echo "First occurrence of <div id=\"footercopyright\"> updated with 'iDempiere' in $COPYRIGHT_FILE"
else
    echo "File $COPYRIGHT_FILE not found!"
fi



echo "Rebranding completed successfully!"


