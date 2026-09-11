#!/bin/bash

#####################################################################
# INSTRUCTIONS
# 1. Edit line 20 to echo the message you want
# 2. Edit line 48 to check for your required software
# 3. Edit line 50 to include the command you want to run (here it's launching streamlit)
#####################################################################

port_number="$1"
if [[ "${port_number}x" == "x" ]] ; then
    port_number=8889
fi

export HOME=$(pwd)

# Check if streamlit is available
which streamlit > /dev/null 2>&1

exit_code="$?"
if [[ "${exit_code}" != 0 ]] ; then
    cat << EOF

    Error: Could not find the 'streamlit' command!
    Run 'source /opt/conda/bin/activate' and try again.

EOF
exit 1
fi

echo "Setting keys to environment"

eval $(python3 -c "
import yaml
with open('config.yml') as f:
    cfg = yaml.safe_load(f) or {}

api_keys = cfg.get('api_keys', {})
for key, value in api_keys.items():
    if value:
        print(f'export {key}=\"{value}\"')
")



echo "Launching Streamlit application..."

streamlit run app.py --server.port=${port_number}

