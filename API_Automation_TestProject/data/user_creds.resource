*** Variables ***
${username}    admin
${password}    password123
&{auth_body}    username=${username}    password=${password}

${cost}    1115
&{BOOKING_DATES}    checkin=2021-05-07    checkout=2025-12-08
&{BOOKING_DATA}    firstname=Test   lastname=Master    totalprice=${cost}    depositpaid=${TRUE}    bookingdates=${BOOKING_DATES}    additionalneeds=Breakfast
