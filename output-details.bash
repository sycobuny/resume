#!/bin/bash

# yes, I store my address and phone number in my git config; cause, why not?
# it's as reasonable a private-ish key/value data store as any other.
street=$(git config user.address)
city=$(git config user.city)
state=$(git config user.state)
zip=$(git config user.zip)
phone=$(git config user.phone)
file=outputs/details.tex

# I don't mind the general populace knowing I live in Baltimore, though; at
# least, assuming I haven't moved and failed to update this script.
city=${city:-Baltimore}
state=${state:-MD}

# if we have enough to build it, put the whole address in there; otherwise,
# just the city and state (which we should have as a bare minimum)
if [ -n "$street" ] && [ -n "$zip" ]; then
    address="$street, $city, $state $zip"
else
    address="$city, $state"
fi

# address goes in the resume, whatever that wound up being
echo "\\address{$address}" > $file

# same deal with the phone.
if [ -n "$phone" ]; then
    echo "\\phone{$phone}" >> $file
fi
